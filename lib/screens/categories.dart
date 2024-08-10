import 'package:flutter/material.dart';

class CategriesScreen extends StatelessWidget {
  const CategriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        children: const [
          Text("1", style: TextStyle(color: Colors.white60)),
          Text("2", style: TextStyle(color: Colors.white60)),
          Text("3", style: TextStyle(color: Colors.white60)),
          Text("4", style: TextStyle(color: Colors.white60)),
          Text("5", style: TextStyle(color: Colors.white60)),
          Text("6", style: TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }
}
