import 'package:firebase_test/models/user_model.dart';
import 'package:firebase_test/services/services.dart';
import 'package:firebase_test/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            _textfield(context.watch<UserViewModel>().emailController, "email"),
            _textfield(context.watch<UserViewModel>().nameController, "name"),
            _textfield(context.watch<UserViewModel>().ageController, "age"),
            _button(
              () async {
                bool result;
                if (context.read<UserViewModel>().isCreate) {
                  result = await context.read<UserViewModel>().addUser();
                } else {
                  result = await context
                      .read<UserViewModel>()
                      .updateUser(); //TODO UPDATE EKLENECEK
                }
                if (result)
                  Navigator.pop(context);
                else
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text("User Eklenemedi")));
              },
              "Kaydet",
            ),
          ],
        ));
  }

  Widget _textfield(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
    );
  }

  Widget _button(Function() onPressed, String text) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
