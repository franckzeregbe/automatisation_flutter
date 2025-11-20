import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2B4E),
      appBar: AppBar(
        title: const Text('Contact'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          'Section en construction...',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
