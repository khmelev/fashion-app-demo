import 'package:fashion_app/services/customer_controller.dart';
import 'package:fashion_app/utils/theme.dart';
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
    final isDark = ref.watch(themeNotifierProvider).isDark;
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello: $email'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
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
