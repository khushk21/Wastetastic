import 'package:email_auth/email_auth.dart';

/// Controller Class to manage OTP related functionality
///
/// * Handles sending of OTP to user
/// * Keeps track of number of attempts by the user
/// * Validates if the user has entered the correct OTP
class OTPMgr {
  /// The number of attempts made by the user for the OTP
  static int numAttempts;

  /// Sends a randomly generated 6-digit OTP to [email]
  ///
  /// Returns void.
  static void sendOTP(String email) async {
    numAttempts = 3;
    EmailAuth.sessionName = "Verification";
    var response = await EmailAuth.sendOtp(receiverMail: email);
    if (response) {
      print("OTP SENT");
    } else {
      print("problem encountered");
    }
  }

  /// Decrements the number of attempts [numAttempts].
  ///
  /// Return true if maximum number of tries ar exceeded, false if not.
  static bool maxTries() {
    numAttempts--;
    if (numAttempts == 0) return true;
    return false;
  }

  /// Verifies if the user entered OTP is valid.
  ///
  /// Makes use of [email] and [otp] to determine if [otp] (entered by user)
  /// matches the actual OTP sent to [email]. Return true if user entered OTP
  /// is valid, false if not.
  static bool verifyOTP(String email, String otp) {
    var response = EmailAuth.validate(receiverMail: email, userOTP: otp);
    if (response) {
      return true;
    } else {
      return false;
    }
  }
}
