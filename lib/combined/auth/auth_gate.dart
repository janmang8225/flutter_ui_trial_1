/*

AUTH GATE - Continuously listen for auth state changes
------------------------------------------------------

unauthenticated -> Login Page
authenticated -> Profile Page

*/

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:ui_trial_1/combined/main_screen2.dart';

import '../startup_pages/login_page.dart';
// import '../startup_pages/profile_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      // listen to auth state changes
      stream: Supabase.instance.client.auth.onAuthStateChange,

      // build appropriate page based on auth state
      builder: (context, snapshot) {
        // loading...
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // check is there is a valid session currently
        final session = snapshot.hasData ? snapshot.data!.session : null;

        if (session != null) {
          return HomeScreen4();
        } else {
          return LoginPage();
        }
      },
    );
  }
}
