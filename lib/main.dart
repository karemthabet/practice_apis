import 'package:flutter/material.dart';
import 'package:practice_apis/helper/app_routing/app_routing.dart';

void main() {
  runApp(const  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute:AppRouting.generateRoute ,
    );
  }
}

