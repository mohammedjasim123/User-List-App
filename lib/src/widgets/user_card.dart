import 'package:flutter/material.dart';
import '../models/user_model.dart';

class UserCard extends StatelessWidget {
  final User user;

  const UserCard({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(user.name),
        subtitle: Text(user.email,style: TextStyle(fontSize: 13),),
        trailing: Icon(Icons.arrow_forward_ios,size: 15,)
       
        
      ),
    );
  }
}
