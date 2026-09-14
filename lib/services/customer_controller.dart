import 'dart:async';

import 'package:fashion_app/utils/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerController extends AsyncNotifier<CustomerState> {
  @override
  Future<CustomerState> build() async => CustomerState(isAuthorized: false);

  Future<void> authorize({
    required String email,
    required String password,
  }) async {
    if (state.value?.isAuthorized == true) {
      return;
    }
    state = const AsyncValue.loading();
    await Future.delayed(mockLongDelay);
    final isAuthorized = email.isNotEmpty && password.isNotEmpty;
    state = AsyncValue.data(CustomerState(isAuthorized: isAuthorized));
  }

  Future<void> logout() async {
    if (state.value?.isAuthorized == false) {
      return;
    }
    state = const AsyncValue.loading();
    await Future.delayed(mockLongDelay);
    state = AsyncValue.data(CustomerState(isAuthorized: false));
  }
}

class CustomerState {
  const CustomerState({required this.isAuthorized});

  final bool isAuthorized;
}

final customerControllerProvider =
    AsyncNotifierProvider<CustomerController, CustomerState>(
      () => CustomerController(),
    );
