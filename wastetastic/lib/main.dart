import 'package:flutter/material.dart';
import 'package:wastetastic/screens/BasicTestingScreen.dart';
import 'package:wastetastic/screens/CarParkScreen.dart';
import 'package:wastetastic/screens/ForgotPasswordScreen.dart';
import 'package:wastetastic/screens/LoadingScreen.dart';
import 'package:wastetastic/screens/MainScreen.dart';
import 'package:wastetastic/screens/NearYouScreen.dart';
import 'package:wastetastic/screens/OtpScreen.dart';
import 'package:wastetastic/screens/MapTestingScreen.dart';
import 'package:wastetastic/screens/POIDetailsScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:wastetastic/screens/ResetPaswordScreen.dart';
import 'package:wastetastic/screens/SignInScreen.dart';
import 'package:wastetastic/screens/SignUpScreen.dart';
import 'package:wastetastic/screens/WelcomeScreen.dart';
import 'package:wastetastic/screens/MapScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wastetastic',
      theme: ThemeData.light(),
      initialRoute: WelcomeScreen.id,
      routes: {
        BasicTestingScreen.id: (context) => BasicTestingScreen(),
        MainScreen.id: (context) => MainScreen(),
        MapScreen.id: (context) => MapScreen(),
        POI_DetialScreen.id: (context) => POI_DetialScreen(),
        NearYouScreen.id: (context) => NearYouScreen(),
        CarParkScreen.id: (context) => CarParkScreen(),
        ForgotPasswordScreen.id: (context) => ForgotPasswordScreen(),
        ResetPasswordScreen.id: (context) => ResetPasswordScreen(),
        OTPScreen.id: (context) => OTPScreen(),
        WelcomeScreen.id: (context) => WelcomeScreen(),
        SignInScreen.id: (context) => SignInScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        LoadingScreen.id: (context) => LoadingScreen(),
        MapTestingScreen.id: (context) => MapTestingScreen(),
      },
    );
  }
}
