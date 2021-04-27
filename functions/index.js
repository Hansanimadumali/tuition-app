// The Cloud Functions for Firebase SDK to create Cloud Functions and setup triggers.
const functions = require('firebase-functions');

// The Firebase Admin SDK to access the Firebase Realtime Database.
const admin = require('firebase-admin');

const firebase = admin.initializeApp();

const defaultAdminStorage = admin.storage();



// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.deletePhoto = functions.firestore
    .document("students/{studentId}")
    .onDelete((snap, context) => {
        const student = snap.data();
        const studnetId = context.params.studnetId;
        if (student.avatar != null) {
            const path = extractPath(student.avatar);
            const bucket = defaultAdminStorage.bucket();
            const file = bucket.file(path);

            return file.delete();
        }
        return
    });


function extractPath(url){
    let uriParts = url.split('?')[0].split('/');
    let countParts = uriParts.length;
    return decodeURIComponent(uriParts[countParts-1]);
}