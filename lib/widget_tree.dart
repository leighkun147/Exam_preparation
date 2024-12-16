import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/App/home_screen.dart';
import 'package:flutter_auth/Screens/Login/login_screen.dart';
import 'package:flutter_auth/Screens/Welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WidgetTree extends StatelessWidget {
  const WidgetTree({Key? key}) : super(key: key);

  Future<Widget> determineStartScreen() async {
    // Step 1: Check if it’s the first launch
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (isFirstLaunch) {
      // Mark first launch as complete
      await prefs.setBool('isFirstLaunch', false);
      return const WelcomeScreen(); // Navigate to Welcome screen
    }

    // Step 2: Check user authentication status
    final User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // User is authenticated, navigate to HomePage
      return HomePage();
    } else {
      // No user is authenticated, navigate to LoginScreen
      return const LoginScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: determineStartScreen(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        // Step 4: Conditional navigation logic
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner while determining the start screen
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          // Return the determined screen
          return snapshot.data!;
        } else {
          // Handle any error that occurred during future execution
          return const Center(child: Text('Something went wrong!'));
        }
      },
    );
  }
}
