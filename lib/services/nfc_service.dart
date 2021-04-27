import 'dart:async';

import 'package:flutter/services.dart';

const String METHOD_CHANNEL = 'com.eternitysl.nfc';
const String EVENT_CHANNEL = 'com.eternitysl.nfc_stream';

class NfcService {

  static const MethodChannel _channel = const MethodChannel(METHOD_CHANNEL);

  static const stream = const EventChannel(EVENT_CHANNEL);

  static Future<String> get startNFC async {
    final String result = await _channel.invokeMethod('startNfcMode');
    print(result);
    return result;
  }

  static Future<String> get stopNFC async {
    final String result = await _channel.invokeMethod('stopNfcMode');
    print(result);
    return result;
  }

  static Stream<dynamic> get read {
    return stream.receiveBroadcastStream();
  }
}
