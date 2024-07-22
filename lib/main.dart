import 'package:flutter/material.dart';
import 'package:user_list/src/screens/user_list_screen.dart';

void main() {
  runApp(UserListApp());
}

class UserListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User List App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserListScreen(),
    );
  }
}
