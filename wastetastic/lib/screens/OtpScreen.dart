import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wastetastic/control/OTPMgr.dart';
import 'package:wastetastic/control/RegistrationMgr.dart';
import 'package:wastetastic/screens/ForgotPasswordScreen.dart';
import 'package:wastetastic/screens/MainScreen.dart';
import 'package:wastetastic/screens/ResetPaswordScreen.dart';
import 'package:wastetastic/widgets/SimpleButton.dart';
import 'package:wastetastic/screens/SignUpScreen.dart';

//TextEditingController emailController = new TextEditingController();

/// Unique Key for the form displayed on the screen
final _formKey = GlobalKey<FormState>();

/// The entered OTP
String enteredOTP;

/// Boundary Class to display the UI for taking the OTP input from user
///
/// * Implements user input error handling
/// * Makes use of controller classes to validate OTP and register a new user
class OTPScreen extends StatefulWidget {
  /// Unique ID to identify the screen and set routing
  static String id = 'OTP_Screen';
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  /// Renders the widgets onto the screen
  ///
  /// Makes use of controller classes to first validate the OTP entered by the
  /// user, then to register a new user in case of correct OTP. Also implements
  /// input error handling.
  @override
  Widget build(BuildContext context) {
    final Map args = ModalRoute.of(context).settings.arguments;
    String name = args['name'];
    String username = args['username'];
    String email = args['email'];
    String password = args['password'];

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Container(
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
                      Text('Enter OTP',
                          style: TextStyle(
                              fontSize: 35.0,
                              color: Colors.white,
                              fontFamily: "Source Sans Pro")),
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) return "Enter OTP";
                            return null;
                          },
                          onChanged: (value) {
                            enteredOTP = value;
                          },
                          cursorColor: Colors.teal[900],
                          maxLength: 6,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock, color: Colors.teal[900]),
                            labelText: 'OTP',
                            labelStyle: TextStyle(
                              color: Colors.teal[900],
                              fontSize: 20,
                            ),
                            //helperText: 'Number of digits',
                            //suffixIcon: Icon(Icons.check_circle, color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.teal[900]),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SimpleButton(
                        content: 'Submit',
                        onPress: () async {
                          if (_formKey.currentState.validate()) {
                            if (OTPMgr.verifyOTP(email, enteredOTP)) {
                              await RegistrationMgr.registerUserAccount(
                                  name, email, password, username);

                              Navigator.pushNamed(
                                context,
                                MainScreen.id,
                              );
                            } else {
                              print('Wrong otp entered, retry');
                              showDialog(
                                context: context,
                                builder: (BuildContext dialogContext) {
                                  return AlertDialog(
                                    title: Center(
                                      child: Text('Wrong OTP'),
                                    ),
                                    content: Text(
                                      'You have entered a wrong OTP.\n' +
                                          OTPMgr.numAttempts.toString() +
                                          ' attempts left.',
                                    ),
                                    actions: <Widget>[
                                      new FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        textColor: Colors.grey,
                                        child: const Text('Retry'),
                                      ),
                                    ],
                                  );
                                },
                              );

                              if (OTPMgr.maxTries()) {
                                Navigator.popUntil(context,
                                    ModalRoute.withName(SignUpScreen.id));
                              }
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
        ));
  }
}
