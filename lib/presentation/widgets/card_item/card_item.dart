// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:practice_apis/data/models/usermodel.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    Key? key,
    required this.usermodel,
  }) : super(key: key);
  final Usermodel usermodel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          backgroundColor:
              usermodel.gender == 'male' ? Colors.blue : Colors.pink,
          child: Text(
            usermodel.gender.toString(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          usermodel.name.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(usermodel.email.toString()),
        trailing: Chip(
          label: Text(
            usermodel.status.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor:
              usermodel.status == 'active' ? Colors.green : Colors.red,
        ),
      ),
    );
  }
}
