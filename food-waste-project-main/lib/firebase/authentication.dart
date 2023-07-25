// save user's account into the firebase
// Code Provided by https://www.bacancytechnology.com/blog/email-authentication-using-firebase-auth-and-flutter
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_waste_proj_v1/firebase/db.dart';

class AuthenticationHelper {
  // FirebaseAuth.instance has many function you can use such as _auth.createUserWithEmailAndPassword
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  get uid => user.uid;

  // creates a new user with email and password
  // Instructions: Use try/catch method and createUserWithEmailAndPassword()
  // return null for try function and error message for catch function
  Future signUp({required String email, required String password}) async {
    // add code here ...
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    }
    on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  String getUID() {
    return user.uid;
  }

  //SIGN IN METHOD
  // Instructions: Use try/catch method and signInWithEmailAndPassword().
  // Check if user is signing in with correct role by calling getUserInfo() (returns a map) and checks if info['role'] is equal to the role they are trying to sign in with
  // return null for try function and error message for catch function
  Future signIn(
      {required String email,
      required String password,
      required String role}) async {
  //    add code here ....
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Map<String, dynamic> info = await getUserInfo();
      if (role != info['role']) {
        return 'You must log in with the ${info['role']} role';
      }
      return 'successful';
    }
    on FirebaseAuthException catch (e){
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }
}
