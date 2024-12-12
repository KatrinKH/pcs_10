import 'package:flutter/material.dart';
import 'package:pcs_10/auth/auth_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // get auth services
  final authServices = AuthServices();

  // text controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // login button pressed
  void login() async {
    // prepare data 
    final email = _emailController.text;
    final password = _passwordController.text;

    // attempt login..
    try {
      await authServices.signInWithEmailPassword(email, password);
    }

    // catch any errors..
    catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Ошибка: $e")));
      }
    } 
  }

  // BUILD UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // email
          TextField(
            controller: _emailController,
          ),

          // password
          TextField(
            controller: _passwordController,
          ),

          // button
          ElevatedButton(
            onPressed: login, 
            child: const Text("Логин"))
        ],
      )
    );
  }
}