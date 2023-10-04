import 'package:flutter/material.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Page 2',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Container(
        color: Colors.white,
        child: const Center(
          child: Text(
            'History Page',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
