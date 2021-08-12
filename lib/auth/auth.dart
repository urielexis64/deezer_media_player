import 'package:deezer_media_player/pages/login/login_page.dart';
import 'package:deezer_media_player/utils/dialogs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth {
  Auth._internal();
  static Auth _instance = Auth._internal();
  static Auth get instance => _instance;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> get user async {
    return _firebaseAuth.currentUser;
  }

  Future<User?> loginByPassword(
    BuildContext context, {
    required String email,
    required String password,
  }) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final UserCredential result = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      progressDialog.dismiss();

      if (result.user != null) {
        return result.user;
      }
      return null;
    } on PlatformException catch (e) {
      print(e);
      progressDialog.dismiss();
      String message = "";
      if (e.code == "ERROR_USER_NOT_FOUND") {
        message = "Invalid email. User not found";
      } else {
        message = e.message ?? 'error';
      }

      Dialogs.alert(context, title: "ERROR", description: message);

      return null;
    }
  }

  Future<User?> facebook(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();

      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        print("facebook login ok");
        // final userData = await FaebookAuth.instance.getUserData();
        // print(userData);

        final AuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);

        final UserCredential authResult =
            await _firebaseAuth.signInWithCredential(credential);
        final User? user = authResult.user;
        print("facebook username: ${user?.displayName} ");
        progressDialog.dismiss();
        return user;
      } else if (result.status == LoginStatus.cancelled) {
        print("facebook login cancelled");
      } else {
        print("facebook login failed");
      }
      progressDialog.dismiss();
      return null;
    } catch (e) {
      print(e);
      progressDialog.dismiss();
      return null;
    }
  }

  Future<User?> google(BuildContext context) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? authentication =
          await googleUser?.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: authentication?.idToken,
          accessToken: authentication?.accessToken);

      final UserCredential result =
          await _firebaseAuth.signInWithCredential(credential);

      final User? user = result.user;

      print("username: ${user?.displayName} ");
      progressDialog.dismiss();
      return user;
    } catch (e) {
      print(e);
      progressDialog.dismiss();
      return null;
    }
  }

  Future<User?> signUp(
    BuildContext context, {
    required String username,
    required String email,
    required String password,
  }) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();

      final UserCredential result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.user != null) {
        await result.user!.updateDisplayName(username);
        progressDialog.dismiss();
        return result.user!;
      }

      progressDialog.dismiss();
      return null;
    } on PlatformException catch (e) {
      String message = "Unknown error";
      if (e.code == "ERROR_EMAIL_ALREADY_IN_USE") {
        message = e.message!;
      } else if (e.code == "ERROR_WEAK_PASSWORD") {
        message = e.message!;
      }
      print(e);
      progressDialog.dismiss();
      Dialogs.alert(context, title: "ERROR", description: message);
      return null;
    }
  }

  Future<bool> sendResetEmailLink(BuildContext context,
      {required String email}) async {
    ProgressDialog progressDialog = ProgressDialog(context);
    try {
      progressDialog.show();
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      progressDialog.dismiss();
      return true;
    } on PlatformException catch (e) {
      print(e);
      progressDialog.dismiss();
      Dialogs.alert(context, title: "ERROR", description: e.message);
      return false;
    }
  }

  Future<void> logOut(BuildContext context) async {
    final String providerId = (await user)!.providerData[0].providerId;
    print("providerId $providerId");
    switch (providerId) {
      case "facebook.com":
        await FacebookAuth.instance.logOut();
        break;
      case "google.com":
        await _googleSignIn.signOut();
        break;
      case "password":
        break;
      case "phone":
        break;
    }
    await _firebaseAuth.signOut();
    Navigator.pushNamedAndRemoveUntil(
        context, LoginPage.routeName, (_) => false);
  }
}
