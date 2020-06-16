import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  User({@required this.uid});
  final String uid;
}

abstract class AuthBase {
  Stream<User> get onAuthStateChanged;
  Future<User> currentUser();
  Future<User> signInWithGoogle();
  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  User _userFromFirebase(FirebaseUser user) {
    if (user == null) {
      return null;
    }
    return User(uid: user.uid);
  }

  @override
  Stream<User> get onAuthStateChanged {
    return _firebaseAuth.onAuthStateChanged.map(_userFromFirebase);
  }

  @override
  Future<User> currentUser() async {
    final user = await _firebaseAuth.currentUser();
    return _userFromFirebase(user);
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();
    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;
      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        final authResult = await _firebaseAuth.signInWithCredential(
          GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken,
            accessToken: googleAuth.accessToken,
          ),
        );

        final QuerySnapshot result =
            await Firestore.instance.collection('profile').getDocuments();
        final List<DocumentSnapshot> documents = result.documents;
        bool userExits = false;
        for (var document in documents) {
          if (document.documentID == authResult.user.uid) userExits = true;
        }
        SharedPreferences prefs;
        prefs = await SharedPreferences.getInstance();

        if (!userExits) {
          prefs.setBool('first', true);
          try {
            await Firestore.instance
                .collection('profile')
                .document(authResult.user.uid.toString())
                .setData({
              'userName': authResult.user.displayName,
              'email': authResult.user.email,
              'phoneNumber': authResult.user.phoneNumber ?? ' ',
              'uid': authResult.user.uid,
              'picture':
                  'https://image.shutterstock.com/image-vector/profile-anonymous-face-icon-gray-260nw-789318310.jpg',
              'weight': '50',
              'height': '70',
              'bloodPressure': 'Normal',
              'bloodSugar': 'Normal',
              'allergies': 'None',
              'bloodGroup': 'Not Set',
              'age': '45',
              'gender': 'Not Set',
            });
          } catch (e) {
            print(e.toString());
          }
        }

        return _userFromFirebase(authResult.user);
      } else {
        throw PlatformException(
          code: 'ERROR_MISSING_GOOGLE_AUTH_TOKEN',
          message: 'Missing Google Auth Token',
        );
      }
    } else {
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();

    await _firebaseAuth.signOut();
  }
}
