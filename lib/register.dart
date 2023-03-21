import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  @override
  void initState() {
    super.initState();
    usernameController =
        TextEditingController(text: "ertugazi91@gmail.com");
    passwordController =
        TextEditingController(text: "12345678");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textfield(usernameController, "Username"),
              _textfield(passwordController, "Password"),
              _button(() async {
                FirebaseAuth auth = FirebaseAuth.instance;
                try {
                  UserCredential credential = await auth
                      .createUserWithEmailAndPassword(
                          email: usernameController.text,
                          password:
                              passwordController.text);
                  print(credential);
                } catch (e) {
                  print(e.toString());
                }
              }, "Register"),
            ],
          ),
        ));
  }

  Widget _textfield(
      TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _button(Function() onPressed, String text) {
    return ElevatedButton(
        onPressed: onPressed, child: Text(text));
  }
}
