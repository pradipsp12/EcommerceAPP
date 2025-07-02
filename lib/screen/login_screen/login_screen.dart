import 'package:e_commerce_flutter/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A3C4A), // Deep teal for modern elegance
            Color(0xFF2A5D6E), // Slightly lighter teal for depth
          ],
        ),
      ),
      child: FlutterLogin(
        title: 'ShopTrend',
        logo: const AssetImage('assets/images/logo.png'),
        loginAfterSignUp: false,
        messages: LoginMessages(
          userHint: 'Email or Username',
          passwordHint: 'Password',
          confirmPasswordHint: 'Confirm Password',
          loginButton: 'SIGN IN',
          signupButton: 'SIGN UP',
          goBackButton: 'Go Back',
          recoverPasswordButton: 'Recover',
          recoverPasswordIntro: 'Reset your password',
          recoverPasswordDescription:
              'Enter your email to receive a password reset link.',
          signUpSuccess: 'Account created! Please log in.',
        ),
        onLogin: (loginData) async {
          try {
            await context.userProvider.login(loginData);
            return null;
          } catch (e) {
            return e.toString();
          }
        },
        onSignup: (SignupData data) async {
          try {
            await context.userProvider.register(data);
            return null;
          } catch (e) {
            return e.toString();
          }
        },
        onSubmitAnimationCompleted: () {
          if (context.dataProvider.getLoginUsr()?.sId != null) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
             const SnackBar(
                content: const Text(
                  'Login failed. Please try again.',
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
        },
        onRecoverPassword: (String email) async {
          try {
            // Implement password recovery logic here
            return null;
          } catch (e) {
            return e.toString();
          }
        },
        hideForgotPasswordButton: false,
        theme: LoginTheme(
          primaryColor: const Color(0xFFF06267), // Vibrant coral for buttons and accents
          accentColor: Colors.white,
          errorColor: Colors.redAccent,
          pageColorLight: Colors.transparent,
          pageColorDark: Colors.transparent,
          cardTheme: CardTheme(
            color: Colors.white.withOpacity(0.98),
            surfaceTintColor: Colors.white,
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          titleStyle: const TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            fontFamily: 'Montserrat',
          ),
          bodyStyle: const TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
          textFieldStyle: const TextStyle(
            color: Colors.black87,
            fontFamily: 'Montserrat',
          ),
          buttonStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontFamily: 'Montserrat',
          ),
          inputTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Color(0xFFF06267), width: 2.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: Colors.redAccent, width: 2.5),
            ),
          ),
          buttonTheme: LoginButtonTheme(
            backgroundColor: const Color(0xFFF06267), // Coral for buttons
            highlightColor: const Color(0xFF1A3C4A).withOpacity(0.3),
            splashColor: Colors.white.withOpacity(0.4),
            elevation: 6,
            highlightElevation: 12,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        additionalSignupFields: const[
           UserFormField(
            keyName: 'full_name',
            displayName: 'Full Name',
            icon: Icon(Icons.person_outline, color: Color(0xFFF06267)),
            fieldValidator: null,
          ),
        ],
      ),
    );
  }
}