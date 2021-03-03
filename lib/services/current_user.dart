import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUser extends ChangeNotifier {
  String _userId;
  String _emailId;

  String getEmail() => _emailId;
  String getUserID() => _userId;

  FirebaseAuth _auth = FirebaseAuth.instance;

  String onStartUp() {
    String retval = 'error';

    try {
      User _firebaseUser = _auth.currentUser;
      _userId = _firebaseUser.uid;
      _emailId = _firebaseUser.email;
      retval = 'sucess';
    } catch (e) {
      print(e);
    }
    return retval;
  }

  Future<String> signOut() async {
    String retval = 'error';

    try {
      await _auth.signOut();
      _userId = null;
      _emailId = null;
      retval = 'sucess';
    } catch (e) {
      print(e);
    }
    return retval;
  }

  Future<String> registerUser(
      {@required String email, @required String password}) async {
    String retVal = 'Not Registerd';
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        _userId = userCredential.user.uid;
        _emailId = userCredential.user.email;
        retVal = 'sucess';
      }
    } catch (e) {
      retVal = e.message;
    }
    return retVal;
  }

  Future<String> loginUSer({String email, String password}) async {
    String retVal = 'Not Signed In';
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (userCredential.user != null) {
        _userId = userCredential.user.uid;
        _emailId = userCredential.user.email;
        retVal = 'sucess';
      }
    } catch (e) {
      retVal = e.message;
    }
    return retVal;
  }
}
