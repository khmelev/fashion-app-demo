import 'package:fashion_app/services/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(customerControllerProvider).isLoading;
    final email =
        ref.watch(customerControllerProvider).value is AuthorizedCustomerState
        ? (ref.watch(customerControllerProvider).value
                  as AuthorizedCustomerState)
              .email
        : 'Unknown';
    return Scaffold(
      appBar: AppBar(title: Text('Profile: $email')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading
                  ? null
                  : () {
                      ref.read(customerControllerProvider.notifier).logout();
                    },
              child: isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
