import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/layouts/auth_desktop_layout.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/layouts/auth_mobile_layout.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/layouts/auth_tablet_layout.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/auth/presentation/widgets/sign_in_form_widget.dart';
import 'package:mess_messenger_app/features/auth/presentation/widgets/sign_up_form_widget.dart';
import 'package:mess_messenger_app/features/auth/providers/auth_provider.dart';
import 'package:mess_messenger_app/features/chat/presentation/pages/home_page.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
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

    final isRegisterMode = authState is AuthUnauthenticated
        ? authState.isRegisterMode
        : true;

    // 3. Create the extracted form UI
    final signUpForm = SignUpFormWidget(
      nameController: _nameController,
      emailController: _emailController,
      passwordController: _passwordController,
      isRegisterMode: isRegisterMode,
      isLoading: isLoading,
      emailError: unauthState?.emailError,
      passwordError: unauthState?.passwordError,
      onPressedGetStarted: () {
        ref
            .read(authProvider.notifier)
            .signUp(_emailController.text, _passwordController.text);
      },
      onPressedSignUpWithGoogle: () {
        // ref
        //     .read(authProvider.notifier)
        //     .signUp(_emailController.text, _passwordController.text);
      },
      onPressedLogIn: () {
        ref.read(authProvider.notifier).toggleAuthMode();
      },
    );

    final signInForm = SignInFormWidget(
      emailController: _emailController,
      passwordController: _passwordController,
      isRegisterMode: isRegisterMode,
      isLoading: isLoading,
      emailError: unauthState?.emailError,
      passwordError: unauthState?.passwordError,
      onPressedSignIn: () {
        // ref
        //     .read(authProvider.notifier)
        //     .signUp(_emailController.text, _passwordController.text);
      },
      onPressedSignInWithGoogle: () {
        // ref
        //     .read(authProvider.notifier)
        //     .signUp(_emailController.text, _passwordController.text);
      },
      onPressedSignUp: () {
        ref.read(authProvider.notifier).toggleAuthMode();
      },
    );

    // 4. Return the Responsive Wrapper, passing the form to each!
    return ResponsiveLayout(
      mobile: AuthMobileLayout(
        formContent: isRegisterMode ? signUpForm : signInForm,
        isRegisterMode: isRegisterMode,
      ),
      tablet: AuthTabletLayout(
        formContent: isRegisterMode ? signUpForm : signInForm,
        isRegisterMode: isRegisterMode,
      ),
      desktop: AuthDesktopLayout(
        formContent: isRegisterMode ? signUpForm : signInForm,
        isRegisterMode: isRegisterMode,
      ),
    );
  }
}
