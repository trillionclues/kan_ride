import 'package:flutter/material.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      // maybe use an emptyplaceholder widgets here
      body: const Center(child: Text('404 - Not Found')),
    );
  }
}
