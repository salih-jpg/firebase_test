import 'package:firebase_test/models/user_model.dart';
import 'package:firebase_test/services/services.dart';
import 'package:flutter/material.dart';

class UserViewModel extends ChangeNotifier {
  List<UserModel> users = [];

  bool isCreate = true;

  Future getUsers() async {
    users = await Services().getUsers();
    notifyListeners();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  clear([UserModel? user]) {
    isCreate = user == null;
    emailController = TextEditingController(text: user?.email ?? "");
    nameController = TextEditingController(text: user?.name ?? "");
    ageController = TextEditingController(text: user?.age.toString() ?? "");
    notifyListeners();
  }

  Future<bool> addUser() async {
    UserModel? user = await Services().postUser(UserModel(
      name: nameController.text,
      age: int.parse(ageController.text),
      email: emailController.text,
      image: "",
    ));
    getUsers();

    return user != null;
  }

  Future<bool> updateUser() async {
    await Services().updateData(UserModel(
      name: nameController.text,
      age: int.parse(ageController.text),
      email: emailController.text,
      image: "",
    ));
    getUsers();

    return true;
  }

  Future deleteUser(String id) async {
    await Services().deleteUser(id);
    getUsers();
  }
}
