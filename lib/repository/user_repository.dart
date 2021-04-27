import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:github_sign_in/github_sign_in.dart';

class UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepository({FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: "8a7d6ff025f5d56750a1",
      clientSecret: "ea4dd79f6d048d4b3e54d1d380feb59a2b3919bc",
      redirectUrl: 'https://tution-app-2b3bc.firebaseapp.com/__/auth/handler');



  Future<void> signInWithCredentials(String email, String password) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }


  Future<void> githubSignIn(BuildContext context) async{


    // Trigger the sign-in flow
    final result = await gitHubSignIn.signIn(context);

    // Create a credential from the access token
    final githubAuthCredential = GithubAuthProvider.getCredential(token: result.token);

    // Once signed in, return the UserCredential
    return  _firebaseAuth.signInWithCredential(githubAuthCredential);

  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
    
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUser() async {
    return (await _firebaseAuth.currentUser()).email;
  }
    
}

