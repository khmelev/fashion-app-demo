import 'dart:async';

import 'package:fashion_app/utils/const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomerController extends AsyncNotifier<CustomerState> {
  @override
  Future<CustomerState> build() async => UnauthorizedCustomerState.instance;

  Future<void> authorize({
    required String email,
    required String password,
  }) async {
    if (state.value is AuthorizedCustomerState) {
      return;
    }
    state = const AsyncValue.loading();
    await Future.delayed(mockLongDelay);
    final isCredentialsValid = email.isNotEmpty && password.isNotEmpty;
    if (isCredentialsValid) {
      state = AsyncValue.data(AuthorizedCustomerState(email: email));
    } else {
      state = AsyncValue.data(UnauthorizedCustomerState.instance);
    }
  }

  Future<void> logout() async {
    if (state.value is UnauthorizedCustomerState) {
      return;
    }
    state = const AsyncValue.loading();
    await Future.delayed(mockLongDelay);
    state = AsyncValue.data(UnauthorizedCustomerState.instance);
  }
}

abstract class CustomerState {
  const CustomerState();
}

extension CustomerStateExtension on CustomerState? {
  bool get isAuthorized => this is AuthorizedCustomerState;
}

class UnauthorizedCustomerState extends CustomerState {
  const UnauthorizedCustomerState();

  static final instance = const UnauthorizedCustomerState();
}

class AuthorizedCustomerState extends CustomerState {
  AuthorizedCustomerState({required this.email});

  final String email;
}

final customerControllerProvider =
    AsyncNotifierProvider<CustomerController, CustomerState>(
      () => CustomerController(),
    );
