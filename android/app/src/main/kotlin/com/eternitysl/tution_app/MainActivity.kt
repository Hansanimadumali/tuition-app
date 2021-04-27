package com.eternitysl.tution_app

import android.annotation.TargetApi
import android.app.PendingIntent
import android.content.Intent
import android.content.IntentFilter
import android.nfc.*
import android.nfc.tech.Ndef
import android.nfc.tech.NfcA
import android.os.Build
import android.os.Bundle

import io.flutter.app.FlutterActivity
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
import java.io.IOException

const val MIME_TEXT_PLAIN = "text/plain"


@TargetApi(Build.VERSION_CODES.JELLY_BEAN)
class MainActivity : FlutterActivity(), MethodChannel.MethodCallHandler, EventChannel.StreamHandler {
    // NFC adapter
    private var nfcAdapter: NfcAdapter? = null


    // need to check NfcAdapter for nullability. Null means no NFC support on the device
    private var isNfcSupported: Boolean = false

    // Event channel stream
    private var eventSink: EventChannel.EventSink? = null

    // MethodChannel and event channel names
    private var METHOD_CHANNEL: String = "com.eternitysl.nfc"

    private var EVENT_CHANNEL: String = "com.eternitysl.nfc_stream"
    // NFC data write
    private var isWrite: Boolean = false
    private lateinit var message: String


    // override on create
    @TargetApi(Build.VERSION_CODES.GINGERBREAD_MR1)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        GeneratedPluginRegistrant.registerWith(this)

        nfcAdapter = NfcAdapter.getDefaultAdapter(this)?.let { it }
        isNfcSupported = this.nfcAdapter != null


        val methodChannel = MethodChannel(flutterView, METHOD_CHANNEL).setMethodCallHandler(this)
        val eventChannel = EventChannel(flutterView, EVENT_CHANNEL).setStreamHandler(this)

    }


    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        if (call.method == "startNfcMode") {
            startDispatchSystem()
            result.success("NFC MODE started")
            eventSink?.success("start button pressed")
        } else if(call.method == "stopNfcMode"){
            stopDispatchSystem()
            result.success("NfcMode stopped")
            eventSink?.success("stop button pressed")

        }
    }

    override fun onListen(args: Any?, events: EventChannel.EventSink?) {
        this.eventSink = events
    }

    override fun onCancel(p0: Any?) {
        this.eventSink = null
    }


    private fun startDispatchSystem() {
        val tagDetected: IntentFilter = IntentFilter(NfcAdapter.ACTION_TAG_DISCOVERED)
        val ndefDetected: IntentFilter = IntentFilter(NfcAdapter.ACTION_NDEF_DISCOVERED)
        val techDetected: IntentFilter = IntentFilter(NfcAdapter.ACTION_TECH_DISCOVERED)
        val nfcIntentFilter: Array<IntentFilter?> = arrayOfNulls<IntentFilter>(3)
        nfcIntentFilter[0] = tagDetected
        nfcIntentFilter[1] = ndefDetected
        nfcIntentFilter[2] = techDetected

        val pendingIntent = PendingIntent.getActivity(
                this, 0, Intent(this, javaClass).addFlags(Intent.FLAG_ACTIVITY_SINGLE_TOP), 0)

        if (nfcAdapter != null) {
            nfcAdapter!!.enableForegroundDispatch(this, pendingIntent, nfcIntentFilter, null)
            this.eventSink?.success("enableForegroundDispatch")
        }
    }

    private fun stopDispatchSystem() {
        if (nfcAdapter != null) {
            nfcAdapter!!.disableForegroundDispatch(this)
        }
        eventSink?.success("dispatch system stopped")
    }

    override fun onNewIntent(intent: Intent?) {
        eventSink?.success("new intent discovered")
        handleIntent(intent)
    }


    private fun handleIntent(intent: Intent?) {
        val tag: Tag = intent!!.getParcelableExtra(NfcAdapter.EXTRA_TAG) as Tag

        this.eventSink?.success("onNewIntent: " + intent.action.toString())

        if (tag != null) {
            val ndef: Ndef = Ndef.get(tag)

            if (isWrite) {
                writeToNfc(ndef, message)
                eventSink?.success("write finished")

            } else {
                readFromNFC(ndef)
            }

        }
    }


    private fun readFromNFC(ndef: Ndef) {

        try {
            ndef.connect()
            val ndefMessage = ndef.ndefMessage
            val message = String(ndefMessage.records[0].payload)
            this.eventSink?.success(message)
            ndef.close()
        } catch (e: IOException) {
            e.printStackTrace()

        } catch (e: FormatException) {
            e.printStackTrace()
        }

    }



    private fun writeToNfc(ndef: Ndef?, message: String) {

        if (ndef != null) {

            try {
                ndef.connect()
                val mimeRecord = NdefRecord.createMime(MIME_TEXT_PLAIN, message.toByteArray(Charsets.US_ASCII))
                ndef.writeNdefMessage(NdefMessage(mimeRecord))
                ndef.close()
                //Write Successful

            } catch (e: IOException) {
                e.printStackTrace()

            } catch (e: FormatException) {
                e.printStackTrace()
            } finally {
                this.eventSink?.success("write job done")
                this.isWrite = false
            }

        }
    }


}
