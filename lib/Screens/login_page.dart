import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/Services/oauth2_authentication_service.dart';

import '../Services/password_authentication_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
              labelText: "Email",
            ),
          ),
          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              labelText: "Password",
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<PasswordAuthenticationService>().signIn(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
            },
            child: Text("Sign in"),
          )
        ],
      ),
    );
  }
}