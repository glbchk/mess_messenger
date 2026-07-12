import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/layouts/auth_desktop_layout.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/layouts/auth_mobile_layout.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/layouts/auth_tablet_layout.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/auth/presentation/widgets/sign_in_form_widget.dart';
import 'package:mess_messenger_app/features/auth/presentation/widgets/sign_up_form_widget.dart';
import 'package:mess_messenger_app/features/ui_app_root/app_shell.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _showPassword = false;

  void _handleFormSubmit() {
    // Read the current state once when the button/Enter key is pressed
    final authState = ref.read(authProvider);

    final isRegisterMode = authState is AuthUnauthenticated
        ? authState.isRegisterMode
        : true;

    if (isRegisterMode) {
      // Trigger Sign Up Notifier Method
      ref
          .read(authProvider.notifier)
          .signUp(_emailController.text, _passwordController.text);
    } else {
      // Trigger Sign In Notifier Method
      ref
          .read(authProvider.notifier)
          .signInWithEmail(
            _emailController.text,
            _passwordController.text,
            authState.rememberMe,
          );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AppShell()),
          (route) => false,
        );
      }
      if (next is AuthUnauthenticated && next.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
        ref.read(authProvider.notifier).clearErrorMessage();
      }
      if (next is AuthUnauthenticated && next.successMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.successMessage!)));
        ref.read(authProvider.notifier).clearSuccessMessage();
      }
      if (next is AuthUnauthenticated && next.needsGoogleLinkConfirmation) {
        showDialog(
          //TODO: Need to change the popup because it's not finished
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Account exists'),
            content: const Text(
              'An account with this email already exists via Google. Sign in with Google to link your password to it?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref.read(authProvider.notifier).confirmGoogleLinkAndSignIn();
                },
                child: const Text('Sign in with Google'),
              ),
            ],
          ),
        );
      }
    });

    final authState = ref.watch(authProvider);
    final isLoading = authState is AuthLoading;
    final unauthState = authState is AuthUnauthenticated ? authState : null;

    final isRegisterMode = authState is AuthUnauthenticated
        ? authState.isRegisterMode
        : true;

    final signUpForm = SignUpFormWidget(
      nameController: _nameController,
      emailController: _emailController,
      passwordController: _passwordController,
      isRegisterMode: isRegisterMode,
      isLoading: isLoading,
      emailError: unauthState?.emailError,
      passwordError: unauthState?.passwordError,
      showPassword: _showPassword,
      onToggleIconShowPassword: () =>
          setState(() => _showPassword = !_showPassword),
      onPressedGetStarted: () {
        ref
            .read(authProvider.notifier)
            .signUp(_emailController.text, _passwordController.text);
      },
      onPressedSignUpWithGoogle: () {
        ref.read(authProvider.notifier).signInWithGoogle();
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
      showPassword: _showPassword,
      onToggleIconShowPassword: () =>
          setState(() => _showPassword = !_showPassword),
      onPressedSignIn: () {
        ref
            .read(authProvider.notifier)
            .signInWithEmail(
              _emailController.text,
              _passwordController.text,
              unauthState?.rememberMe ?? true,
            );
      },
      onPressedSignInWithGoogle: () {
        ref.read(authProvider.notifier).signInWithGoogle();
      },
      onPressedSignUp: () {
        ref.read(authProvider.notifier).toggleAuthMode();
      },
      rememberMe: unauthState?.rememberMe ?? true,
      onToggleRememberMe: () {
        ref.read(authProvider.notifier).toggleRememberMe();
      },
      onPressedForgotPassword: () {
        ref
            .read(authProvider.notifier)
            .sendPasswordResetEmail(_emailController.text);
      },
    );

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.enter): _handleFormSubmit,
      },
      child: ResponsiveLayout(
        mobile: AuthMobileLayout(
          formContent: isRegisterMode ? signUpForm : signInForm,
          onSignOutPressed: () {
            ref.read(authProvider.notifier).logout();
          },
        ),
        tablet: AuthTabletLayout(
          formContent: isRegisterMode ? signUpForm : signInForm,
        ),
        desktop: AuthDesktopLayout(
          formContent: isRegisterMode ? signUpForm : signInForm,
        ),
      ),
    );
  }
}
