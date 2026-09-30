import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/widgets/mess_main_button.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/theme/theme_extensions/theme_extension.dart';

class ConfirmEmailPage extends ConsumerStatefulWidget {
  const ConfirmEmailPage({super.key});

  @override
  ConsumerState<ConfirmEmailPage> createState() => _ConfirmEmailPageState();
}

class _ConfirmEmailPageState extends ConsumerState<ConfirmEmailPage>
    with WidgetsBindingObserver {
  bool _checking = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _check();
    }
  }

  Future<void> _check() async {
    setState(() => _checking = true);
    await ref
        .read(userNotifierProvider.notifier)
        .checkEmailVerificationStatus();
    if (mounted) setState(() => _checking = false);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textStyles;
    final email = ref.watch(userNotifierProvider).userData?.email ?? '';

    return Scaffold(
      backgroundColor: colors.bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Confirm your email',
                style: textTheme.headlineLarge?.copyWith(color: colors.text1),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                "We've sent a confirmation link to $email. "
                "Tap the link, then come back here.",
                style: textTheme.bodyLarge?.copyWith(color: colors.text2),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              if (_checking)
                const CircularProgressIndicator()
              else ...[
                MessMainButton(label: "I've confirmed", onPressed: _check),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () =>
                      ref.read(authNotifierProvider.notifier).logout(),
                  child: Text(
                    'Log out',
                    style: textTheme.labelLarge?.copyWith(color: colors.text2),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
