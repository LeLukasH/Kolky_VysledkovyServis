import 'package:flutter/material.dart';

class InterligaPage extends StatelessWidget {
  const InterligaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interliga'),
      ),
      body: const Center(
        child: Text('This is my page'),
      ),
    );
  }
}
