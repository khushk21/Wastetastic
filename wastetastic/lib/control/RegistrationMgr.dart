import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';

/// A control class for new user registration
///
/// Interacts with the firestore database to add new user details
class RegistrationMgr {
  /// A firebase firestore instance to interact with the User Account database
  static final _firestore = FirebaseFirestore.instance;

  /// Adds a new user document to the database
  ///
  /// Registers a new user, [name] with the username: [username] and
  /// password: [password] and linked to the email, [email].
  /// The points the user is set to zero during registration.
  /// Adds the user information to the database using [_firestore] instance.
  /// Returns void
  static Future<void> registerUserAccount(
      String name, String email, String password, String username) async {
    final auth = FirebaseAuth.instance;

    try {
      print("Reached here");
      final newUser = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("Created User with Email and Password");
      if (newUser != null) {
        String userEmail = newUser.user.email;
        print("User email: " + userEmail);
        print('About to write to firestore');
        await _firestore
            .collection('UserAccounts')
            .doc('$username')
            .set({'name': name, 'email': userEmail, 'points': 0});
        await UserAccountMgr.readUserDetails(username);
        UserAccountMgr.userDetails.printUserDetails();
      }
    } catch (e) {
      print("Error!!");
      print(e);
    }
  }
}
