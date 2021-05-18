import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/screens/MainScreen.dart';
import 'package:wastetastic/screens/SignInScreen.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';

//TextEditingController emailController = new TextEditingController();

/// Unique Key for the form displayed on the screen
final _formKey = GlobalKey<FormState>();

/// User entered new password
String newPassword;

/// User entered confirm password
String confirmPassword;

/// Boundary Class to display the UI for taking user input for resetting password
///
/// * Implements various user input error handling
/// * Makes use of controller classes to reset password for the user
class ResetPasswordScreen extends StatefulWidget {
  /// Unique ID to identify the screen and set routing
  static String id = 'Forgot_password_page';
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  /// Whether the user has chosen to blue the confirm password field
  bool _obscureConfirmText = true;

  /// Whether the user has chosen to blue the password field
  bool _obscureText = true;

  /// Renders the widgets onto the screen
  ///
  /// Ensures that the user enters matching password and confirm password fields.
  /// Makes use of controller classes to make necessary updates to the database.
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    final String email = args['email'];
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Center(
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Colors.lightGreen.shade700,
                  Colors.lime.shade400,
                ],
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 60.0,
                          //backgroundImage: AssetImage('')
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/images/wastetastic logo.png'),
                        ),
                        SizedBox(height: 20),
                        Text('Reset Password',
                            style: TextStyle(
                                fontSize: 35.0,
                                color: Colors.white,
                                fontFamily: "Source Sans Pro")),
                        //style: TextStyle(color: Colors.white, fontSize: 18)),
                        SizedBox(height: 7.5),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 7.5, horizontal: 20),
                          child: TextFormField(
                            validator: (value) => value.isEmpty
                                ? "Enter Password"
                                : value.length < 6
                                    ? "Password must contain atleast 6 characters"
                                    : null,
                            onChanged: (value) {
                              newPassword = value;
                            },
                            cursorColor: Colors.teal[900],
                            maxLength: 30,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock, color: Colors.teal[900]),
                              labelText: 'New Password',
                              labelStyle: TextStyle(
                                color: Colors.teal[900],
                                fontSize: 20,
                              ),
                              //helperText: 'Number of characters',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal[900]),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _obscureText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.teal[900]),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 7.5, horizontal: 20),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) return "Enter Password";
                              if (value != newPassword)
                                return "Passwords Dont Match";
                              return null;
                            },
                            onChanged: (value) {
                              confirmPassword = value;
                            },
                            cursorColor: Colors.teal[900],
                            maxLength: 30,
                            obscureText: _obscureConfirmText,
                            decoration: InputDecoration(
                              icon: Icon(Icons.lock, color: Colors.teal[900]),
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                color: Colors.teal[900],
                                fontSize: 20,
                              ),
                              //helperText: 'Number of characters',
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.teal[900]),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                    _obscureConfirmText
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.teal[900]),
                                onPressed: () {
                                  setState(() {
                                    _obscureConfirmText = !_obscureConfirmText;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SimpleButton(
                          content: 'Reset Password',
                          onPress: () {
                            if (_formKey.currentState.validate()) {
                              UserAccountMgr.updateUserPassword(
                                  email, newPassword);
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title:
                                        Center(child: Text('Password Changed')),
                                    content: Text(
                                        'You have successfully changed your account Password!'),
                                    actions: <Widget>[
                                      new FlatButton(
                                        onPressed: () {
                                          Navigator.popUntil(
                                              context,
                                              ModalRoute.withName(
                                                  MainScreen.id));
                                        },
                                        textColor: Colors.grey,
                                        child: const Text('Continue'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
