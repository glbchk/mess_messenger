import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_desktop_layout.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_mobile_layout.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_tablet_layout.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;

  late final TextEditingController nameController;
  late final TextEditingController birthdayController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);

    final currentUserData = ref.read(userNotifierProvider).userData;

    nameController = TextEditingController(text: currentUserData?.name ?? '');
    birthdayController = TextEditingController(
      text: currentUserData?.birthday ?? '',
    );
    emailController = TextEditingController(text: currentUserData?.email ?? '');
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    tabController.dispose();
    nameController.dispose();
    birthdayController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');

    final bp = ResponsiveBreakpoints.of(context);

    ref.listen(userNotifierProvider, (previous, next) {
      final newName = next.userData?.name ?? '';
      if (nameController.text != newName) {
        nameController.text = newName;
      }
    });

    ref.listen(userNotifierProvider, (previous, next) {
      final newBirthday = next.userData?.birthday ?? '';
      if (birthdayController.text != newBirthday) {
        birthdayController.text = newBirthday;
      }
    });

    Future<void> openChattingPage() async {
      // final currentUserId = ref.read(userNotifierProvider).userData?.id;
      // if (currentUserId == null) return;
      //
      // const otherUserId =
      //     'nBEcLiKmQER28aVpq0BlCC3b25Y2'; // the second test user
      //
      // final chatId = await ref
      //     .read(getOrCreateChatUseCaseProvider)
      //     .execute(currentUserId, otherUserId);
      // print('DEBUG: chatId = $chatId');
      //
      // if (!context.mounted) return;
      //
      // if (bp.isMobile) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (_) => MobileOpenChatPage(chatId: chatId)),
      //   );
      // } else {
      //   ref.read(selectedChatIdProvider.notifier).state = chatId;
      // }
    }

    return ResponsiveLayout(
      mobile: SettingsMobileLayout(
        userData: userData,
        tabController: tabController,
        onPressed: () => openChattingPage(),
        nameController: nameController,
        birthdayController: birthdayController,
        emailController: emailController,
        passwordController: passwordController,
      ),
      tablet: SettingsTabletLayout(
        userData: userData,
        tabController: tabController,
        onPressed: () => openChattingPage(),
        nameController: nameController,
        birthdayController: birthdayController,
        emailController: emailController,
        passwordController: passwordController,
      ),
      desktop: SettingsDesktopLayout(
        userData: userData,
        tabController: tabController,
        onPressed: () => openChattingPage(),
        nameController: nameController,
        birthdayController: birthdayController,
        emailController: emailController,
        passwordController: passwordController,
      ),
    );
  }
}
