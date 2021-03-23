import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in anon method
  Future signinAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      //User is a firebase class for user.
      User user = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register new account with username & passwd
  Future registerWithEmailAndPasswd(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      // create a new FireStore document for this user with the uid
      User user = result.user;
      //Send email to confirm valid / owned address
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print(e);
        //TODO: if email already exists show popup dialog
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // TODO: To confirm validate email address
  // // using regular expression
  // if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
  // return "Please enter a valid email address";
  // }
  // // the email is valid
  // return null;

  //sign in existing user with email & password
  Future signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out of account
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('signout error');
      print(e.toString());
      return null;
    }
  }

  //Sign in with Google
  Future<UserCredential> singInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  // SignInMethods().singInWithGoogle().then((user) {print(user.user); TODO: To use google signin data

  //sign out of google (remove preset)
  Future signOutGoogle() async {
    try {
      return await GoogleSignIn().signOut();
    } catch (e) {
      print('Google Sign Out ERROR');
      print(e.toString());
      return null;
    }
  }

  //Sign in with Facebook

  //sign out of facebook

  //Sign in with Twitter

  //sign out of twitter

}
