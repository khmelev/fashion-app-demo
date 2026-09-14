import 'package:fashion_app/screens/profile/login_screen.dart';
import 'package:fashion_app/screens/profile/profile_screen.dart';
import 'package:fashion_app/services/customer_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileContainerScreen extends ConsumerWidget {
  const ProfileContainerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthorized =
        ref.watch(customerControllerProvider).value?.isAuthorized == true;
    if (isAuthorized) {
      return ProfileScreen();
    } else {
      return LoginScreen();
    }
  }
}
