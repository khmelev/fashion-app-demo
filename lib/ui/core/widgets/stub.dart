import 'package:flutter/material.dart';

class StubWidget extends StatelessWidget {
  const StubWidget({super.key, required this.onRetryPressed});

  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Something went wrong.'),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetryPressed, child: const Text('Retry')),
        ],
      ),
    );
  }
}
