import 'package:firebase_test/models/user_model.dart';
import 'package:firebase_test/services/services.dart';
import 'package:firebase_test/view_models/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import 'add_user.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: [
          IconButton(
              onPressed: () {
                context.read<UserViewModel>().clear();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddUserPage()));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
                  itemCount: context.watch<UserViewModel>().users.length,
                  itemBuilder: (context, index) {
                    UserModel user =
                        context.watch<UserViewModel>().users[index];
                    return Row(
                      children: [
                        Text(user.name),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              context.read<UserViewModel>().clear(user);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddUserPage()));
                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                      content: Column(
                                children: [
                                  Text("Delete user?",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text("This will delet user data!"),
                                  Row(
                                    children: [
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            context
                                                .read<UserViewModel>()
                                                .deleteUser(user.id!);
                                          },
                                          icon: Icon(Icons.done),
                                          label: Text("ACCEPT")),
                                      Spacer(),
                                      ElevatedButton.icon(
                                          onPressed: () {},
                                          icon: Icon(Icons.block),
                                          label: Text("CANCEL"))
                                    ],
                                  )
                                ],
                              )));

                              //TODO Sende
                            },
                            icon: Icon(Icons.delete))
                      ],
                    );
                  })),
        ],
      ),
    );
  }
}
