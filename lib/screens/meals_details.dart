import 'package:flutter/material.dart';
// import 'package:meals/models/meal.dart';
class MealsDetails extends StatelessWidget {
  const MealsDetails({super.key, required this.title,  required this.onSelectMeal});

  final String title;
  final String onSelectMeal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title),) ,
      body: const  Text('a')
    );
  }
}