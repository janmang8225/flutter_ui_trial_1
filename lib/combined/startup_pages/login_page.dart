import 'package:flutter/material.dart';
import 'package:ui_trial_1/combined/startup_pages/register_page.dart';

import '../auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // get auth service
  final authService = AuthService();

  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // login button pressed
  void login() async {
    // prepare data
    final email = _emailController.text;
    final password = _passwordController.text;

    // attempt login
    try {
      await authService.signInWithEmailPassword(email, password);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Error : $e")));
      }
    }
  }

  // BUILDING UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login"),),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        children: [
          // email
          TextField(
            controller: _emailController,
            decoration: InputDecoration(labelText: "Email"),
          ),

          // password
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
          ),

          SizedBox(
            height: 20,
          ),

          // button
          ElevatedButton(onPressed: login, child: const Text("Login")),

          SizedBox(
            height: 10,
          ),

          // go to register page to sig up
          GestureDetector(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
                  )),
              child:
                  const Center(child: Text("Don't have an account? Sign Up"))),
        ],
      ),
    );
  }
}
