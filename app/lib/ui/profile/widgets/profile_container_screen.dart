import 'package:fashion_app/ui/profile/widgets/login_screen.dart';
import 'package:fashion_app/ui/profile/widgets/profile_screen.dart';
import 'package:fashion_app/data/repositories/customer_repository.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileContainerScreen extends ConsumerWidget {
  const ProfileContainerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(customerRepositoryProvider).value.isAuthorized) {
      return ProfileScreen();
    } else {
      return LoginScreen();
    }
  }
}
