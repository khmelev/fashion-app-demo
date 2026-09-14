import 'package:fashion_app/services/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hello, User42!')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Authorized profile'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(customerControllerProvider.notifier).logout();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
