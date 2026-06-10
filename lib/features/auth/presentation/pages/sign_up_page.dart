import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/layouts/sign_up_desktop.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/layouts/sign_up_mobile.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/layouts/sign_up_tablet.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/auth/presentation/widgets/auth_form_widget.dart';
import 'package:mess_messenger_app/features/auth/providers/auth_provider.dart';
import 'package:mess_messenger_app/features/chat/presentation/pages/home_page.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Listen for side-effects (Navigation & Snackbars)
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
          (route) => false,
        );
      }
      if (next is AuthUnauthenticated && next.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
        ref.read(authProvider.notifier).clearErrorMessage();
      }
    });

    // 2. Read State
    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthLoading;
    final unauthState = authState is AuthUnauthenticated ? authState : null;

    // 3. Create the extracted form UI
    final form = AuthFormWidget(
      nameController: _nameController,
      emailController: _emailController,
      passwordController: _passwordController,
      isLoading: isLoading,
      emailError: unauthState?.emailError,
      passwordError: unauthState?.passwordError,
      onPressed: () {
        ref
            .read(authProvider.notifier)
            .signUp(_emailController.text, _passwordController.text);
      },
    );

    // 4. Return the Responsive Wrapper, passing the form to each!
    return ResponsiveLayout(
      mobile: SignUpMobile(formContent: form),
      tablet: SignUpTablet(formContent: form),
      desktop: SignUpDesktop(formContent: form),
    );
  }
}
