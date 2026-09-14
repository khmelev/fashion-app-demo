import 'package:fashion_app/services/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Not authorized profile'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(customerControllerProvider.notifier)
                    .authorize(email: 'email', password: 'password');
              },
              child: Text('Sing in'),
            ),
          ],
        ),
      ),
    );
  }
}
