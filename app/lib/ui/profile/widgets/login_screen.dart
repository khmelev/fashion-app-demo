import 'package:fashion_app/data/repositories/customer_repository.dart';
import 'package:fashion_app/ui/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _emailErrorMessage;
  String? _passwordErrorMessage;

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isEmailHasValidPattern(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  bool _isEmailValid() {
    final email = _emailController.text.trim();

    setState(() {
      if (email.isEmpty) {
        _emailErrorMessage = 'Email cannot be empty';
      } else if (!_isEmailHasValidPattern(email)) {
        _emailErrorMessage = 'Please enter a valid email address';
      } else {
        _emailErrorMessage = null;
      }
    });

    return _emailErrorMessage == null;
  }

  bool _isPasswordValid() {
    final password = _passwordController.text.trim();

    setState(() {
      if (password.isEmpty) {
        _passwordErrorMessage = 'Password cannot be empty';
      } else if (password.length < 6) {
        _passwordErrorMessage = 'Password must be at least 6 symbols';
      } else {
        _passwordErrorMessage = null;
      }
    });

    return _passwordErrorMessage == null;
  }

  @override
  void dispose() {
    // Clean up controllers when widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(customerRepositoryProvider).isLoading;
    final isDark = ref.watch(themeNotifierProvider).isDark;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            //spacing: 20,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icon(Icons.email),
                  errorText: _emailErrorMessage,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Simple email validation
                  if (!value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icon(Icons.lock),
                  errorText: _passwordErrorMessage,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () {
                        if (_isEmailValid() && _isPasswordValid()) {
                          ref
                              .read(customerRepositoryProvider.notifier)
                              .authorize(
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                              );
                        }
                      },
                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text('Sing in'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
