import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ui_trial_1/combined/startup_pages/login_page.dart';
import '../auth/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // get auth service
  final authService = AuthService();

  // logout button pressed
  void logout() async {
    await authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    // get user email
    final currentEmail = authService.getCurrentUserEmail();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          // logout button
          //IconButton(onPressed: logout, icon: const Icon(Icons.logout))

          IconButton(
              onPressed: () {
                logout();
                MaterialPageRoute(builder: (context) => const LoginPage());
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text(currentEmail.toString()),
      ),
    );
  }
}
