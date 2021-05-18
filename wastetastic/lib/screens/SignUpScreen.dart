import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wastetastic/control/OTPMgr.dart';
import 'package:wastetastic/control/UserAccountMgr.dart';
import 'package:wastetastic/screens/OtpScreen.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';
import 'package:email_validator/email_validator.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

/// Unique Key for the form displayed on the screen
final _formKey = GlobalKey<FormState>();

/// Unique Key for the Scaffold displayed on the screen
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

/// The user entered name
String enteredName;

/// The user entered username
String enteredUsername;

/// The user entered email
String enteredEmail;

/// The user entered password field
String enteredPassword;

/// The user entered confirm password field
String enteredConfirmPassword;

/// Boundary Class to display the UI for taking user input to sign up.
///
/// * Implements various user input error handling
/// * Makes use of controller classes to validate if sign up can be successfully
/// done.
class SignUpScreen extends StatefulWidget {
  /// Unique ID to identify the screen and set routing
  static String id = 'signup_page';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  /// Whether the user has chosen to blue the confirm password field
  bool _obscureConfirmText = true;

  /// Whether the user has chosen to blue the password field
  bool _obscureText = true;

  /// Renders the widgets onto the screen.
  ///
  ///Ensures that the user enters matching password and confirm password fields.
  /// Makes use of controller classes to validate if [enteredUsername] and
  /// [enteredEmail] are not already registered, and to send an OTP for
  /// confirmation of email ID.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: <Widget>[
                      Hero(
                        tag: 'App Logo',
                        child: CircleAvatar(
                          radius: 60.0,
                          //backgroundImage: AssetImage('')
                          backgroundColor: Colors.transparent,
                          backgroundImage:
                              AssetImage('assets/images/wastetastic logo.png'),
                        ),
                      ),
                      SizedBox(
                        width: 150.0,
                        child: TypewriterAnimatedTextKit(
                          text: [
                            "Sign Up",
                          ],
                          textStyle: TextStyle(
                              fontSize: 35.0, fontFamily: "Source Sans Pro"),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Enter Name" : null,
                          onChanged: (value) {
                            enteredName = value;
                          },
                          cursorColor: Colors.teal[900],
                          maxLength: 50,
                          decoration: InputDecoration(
                            icon: Icon(Icons.perm_identity_rounded,
                                color: Colors.teal[900]),
                            labelText: 'Name',
                            labelStyle: TextStyle(
                                color: Colors.teal[900], fontSize: 17),
                            // helperText: 'Number of characters',
                            // helperStyle: TextStyle(
                            //     color: Colors.teal[900],
                            //     fontSize: 12
                            // ),
                            //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[900]),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty) return "Enter Email";
                            final bool isValid = EmailValidator.validate(value);
                            if (isValid == false) return "Enter Valid Email";
                            return null;
                          },
                          onChanged: (value) {
                            enteredEmail = value;
                          },
                          cursorColor: Colors.teal[900],
                          maxLength: 50,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email_rounded,
                                color: Colors.teal[900]),

                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Colors.teal[900], fontSize: 17),
                            // helperText: 'Number of characters',
                            // helperStyle: TextStyle(
                            //     color: Colors.teal[900],
                            //     fontSize: 12
                            // ),
                            //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[900]),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextFormField(
                          validator: (value) =>
                              value.isEmpty ? "Enter Username" : null,
                          onChanged: (value) {
                            enteredUsername = value;
                          },
                          cursorColor: Colors.teal[900],
                          maxLength: 30,
                          decoration: InputDecoration(
                            icon: Icon(Icons.person, color: Colors.teal[900]),

                            labelText: 'Username',
                            labelStyle: TextStyle(
                                color: Colors.teal[900], fontSize: 17),
                            // helperText: 'Number of characters',
                            // helperStyle: TextStyle(
                            //     color: Colors.teal[900],
                            //     fontSize: 12
                            // ),
                            //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[900]),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextFormField(
                          validator: (value) => value.isEmpty
                              ? "Enter Password"
                              : value.length < 6
                                  ? "Password must contain atleast 6 characters"
                                  : null,
                          onChanged: (value) {
                            enteredPassword = value;
                          },
                          cursorColor: Colors.teal[900],
                          maxLength: 30,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock, color: Colors.teal[900]),

                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Colors.teal[900], fontSize: 17),
                            // helperText: 'Number of characters',
                            // helperStyle: TextStyle(
                            //     color: Colors.teal[900],
                            //     fontSize: 12
                            // ),
                            //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
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
                        margin:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 30),
                        child: TextFormField(
                          validator: (value) {
                            if (value.isEmpty) return "Confirm Password";
                            if (value != enteredPassword)
                              return "Passwords Don't Match";
                            return null;
                          },
                          onChanged: (value) {
                            enteredConfirmPassword = value;
                          },
                          cursorColor: Colors.teal[900],
                          maxLength: 30,
                          obscureText: _obscureConfirmText,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock, color: Colors.teal[900]),

                            labelText: 'Confirm Password',

                            labelStyle: TextStyle(
                                color: Colors.teal[900], fontSize: 17),
                            // helperText: 'Number of characters',
                            // helperStyle: TextStyle(
                            //     color: Colors.teal[900],
                            //     fontSize: 12
                            // ),
                            //suffixIcon: Icon(Icons.check_circle, color: Colors.teal[900]),
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
                        content: 'Sign Up',
                        onPress: () async {
                          if (_formKey.currentState.validate()) {
                            /* var  =
                                await RegistrationMgr.validateUsername_Email(
                                    enteredUsername, enteredEmail);
                            */
                            var username_emailExist =
                                await UserAccountMgr.validateUsername_Email(
                                    enteredUsername, enteredEmail);
                            print(username_emailExist);
                            if (username_emailExist == null) {
                              OTPMgr.sendOTP(enteredEmail);
                              Navigator.pushNamed(
                                context,
                                OTPScreen.id,
                                arguments: {
                                  'name': enteredName,
                                  'username': enteredUsername,
                                  'email': enteredEmail,
                                  'password': enteredPassword,
                                },
                              );
                            } else {
                              /*_scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Entered ' +
                                        username_emailExist +
                                        ' already exist.',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  duration: Duration(seconds: 3),
                                ),
                              );*/
                              showTopSnackBar(
                                context,
                                CustomSnackBar.error(
                                  message: "Entered " +
                                      username_emailExist +
                                      " already exist. Please enter another " +
                                      username_emailExist +
                                      " and try again.",
                                ),
                              );
                            }
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
      ),
    );
  }
}
