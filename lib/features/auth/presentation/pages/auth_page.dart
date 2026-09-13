import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/layouts/auth_mobile_layout.dart';
import 'package:mess_messenger_app/features/auth/presentation/pages/layouts/auth_tablet_and_desktop_layout.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/auth/presentation/widgets/sign_in_form_widget.dart';
import 'package:mess_messenger_app/features/auth/presentation/widgets/sign_up_form_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
    final authState = ref.read(authNotifierProvider);

    final isRegisterMode = authState.isRegisterMode;

    if (isRegisterMode) {
      ref
          .read(authNotifierProvider.notifier)
          .signUp(
            _emailController.text,
            _passwordController.text,
            _nameController.text,
          );
    } else {
      final rememberMe = switch (authState) {
        AuthUnauthenticated(:final rememberMe) => rememberMe,
        _ => true,
      };
      ref
          .read(authNotifierProvider.notifier)
          .signInWithEmail(
            _emailController.text,
            _passwordController.text,
            rememberMe,
          );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final message = ref.read(postSignOutMessageProvider);
      if (message != null) {
        ref.read(postSignOutMessageProvider.notifier).clear();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });
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
    final l10n = context.l10n;
    final bp = ResponsiveBreakpoints.of(context);
    final formMaxWidth = (bp.screenWidth * 0.4).clamp(320.0, 480.0);

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthUnauthenticated && next.errorMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.errorMessage!)));
        ref.read(authNotifierProvider.notifier).clearErrorMessage();
      }
      if (next is AuthUnauthenticated && next.successMessage != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.successMessage!)));
        ref.read(authNotifierProvider.notifier).clearSuccessMessage();
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
                  ref
                      .read(authNotifierProvider.notifier)
                      .confirmGoogleLinkAndSignIn();
                },
                child: const Text('Sign in with Google'),
              ),
            ],
          ),
        );
      }
    });

    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState is AuthLoading;
    final unauthState = authState is AuthUnauthenticated ? authState : null;

    final isRegisterMode = authState.isRegisterMode;

    //TODO: Need to finish update for textfields
    // final signUpTextfields = ref.watch(formFieldsProvider('signIn').notifier);

    final signUpForm = SignUpFormWidget(
      l10n: l10n,
      nameController: _nameController,
      emailController: _emailController,
      passwordController: _passwordController,
      isRegisterMode: isRegisterMode,
      isLoading: isLoading,
      showPassword: _showPassword,
      onToggleIconShowPassword: () =>
          setState(() => _showPassword = !_showPassword),
      onPressedGetStarted: () {
        ref
            .read(authNotifierProvider.notifier)
            .signUp(
              _emailController.text,
              _passwordController.text,
              _nameController.text,
            );
      },
      onPressedSignUpWithGoogle: () {
        ref.read(authNotifierProvider.notifier).signInWithGoogle();
      },
      onPressedLogIn: () {
        ref.read(authNotifierProvider.notifier).toggleAuthMode();
      },
    );

    final signInForm = SignInFormWidget(
      l10n: l10n,
      emailController: _emailController,
      passwordController: _passwordController,
      isRegisterMode: isRegisterMode,
      isLoading: isLoading,
      showPassword: _showPassword,
      onToggleIconShowPassword: () =>
          setState(() => _showPassword = !_showPassword),
      onPressedSignIn: () {
        ref
            .read(authNotifierProvider.notifier)
            .signInWithEmail(
              _emailController.text,
              _passwordController.text,
              unauthState?.rememberMe ?? true,
            );
      },
      onPressedSignInWithGoogle: () {
        ref.read(authNotifierProvider.notifier).signInWithGoogle();
      },
      onPressedSignUp: () {
        ref.read(authNotifierProvider.notifier).toggleAuthMode();
      },
      rememberMe: unauthState?.rememberMe ?? true,
      onToggleRememberMe: () {
        ref.read(authNotifierProvider.notifier).toggleRememberMe();
      },
      onPressedForgotPassword: () {
        final email = _emailController.text;
        if (email.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Enter your email first')),
          );
          return;
        }
        ref.read(authNotifierProvider.notifier).sendPasswordResetEmail(email);
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
            ref.read(authNotifierProvider.notifier).logout();
          },
        ),
        tablet: AuthTabletAndDesktopLayout(
          formMaxWidth: formMaxWidth,
          formContent: isRegisterMode ? signUpForm : signInForm,
        ),
        desktop: AuthTabletAndDesktopLayout(
          formMaxWidth: formMaxWidth,
          formContent: isRegisterMode ? signUpForm : signInForm,
        ),
      ),
    );
  }
}
