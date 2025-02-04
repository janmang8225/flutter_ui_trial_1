import 'package:flutter/material.dart';

import '../auth/auth_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // get auth service
  final authService = AuthService();

  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // sign up button pressed
  void signUp() async {
    // prepare data
    final email = _emailController.text;
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // check that passwords match or no
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords don't match")));
      return;
    }

    // attempt sign up
    try {
      await authService.signUpWithEmailPassword(email, password);

      // pop this register page
      Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("error : $e")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
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

          // confirm password
          TextField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(labelText: "Confirm Password"),
            obscureText: true,
          ),

          SizedBox(
            height: 20,
          ),

          // button
          ElevatedButton(onPressed: signUp, child: const Text("Sign Up")),
        ],
      ),
    );
  }
}
