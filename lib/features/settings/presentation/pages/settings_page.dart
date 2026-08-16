import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
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
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late final TabController tabController;

  late final TextEditingController nameController;
  late final MenuController birthdayController;
  DateTime? _selectedDate;
  late final TextEditingController emailController;
  late final TextEditingController phoneNumberController;
  late final TextEditingController currentPasswordController;
  late final TextEditingController newPasswordController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    tabController = TabController(length: 6, vsync: this);

    final currentUserData = ref.read(userNotifierProvider).userData;

    nameController = TextEditingController(text: currentUserData?.name ?? '');
    birthdayController = MenuController();
    emailController = TextEditingController(text: currentUserData?.email ?? '');
    phoneNumberController = TextEditingController(
      text: currentUserData?.phoneNumber ?? '',
    );
    newPasswordController = TextEditingController();
    currentPasswordController = TextEditingController();

    final savedBirthday = currentUserData?.birthday;
    if (savedBirthday != null && savedBirthday.isNotEmpty) {
      _selectedDate = DateTime.tryParse(savedBirthday);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    tabController.dispose();
    nameController.dispose();
    birthdayController.close();
    emailController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(userNotifierProvider.notifier).checkEmailVerificationStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
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
      if (_selectedDate != DateTime.tryParse(newBirthday)) {
        _selectedDate = DateTime.tryParse(newBirthday);
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
        l10n: l10n,
        userData: userData,
        tabController: tabController,
        onPressed: () => openChattingPage(),
        nameController: nameController,
        birthdayController: birthdayController,
        selectedDate: _selectedDate,
        emailController: emailController,
        phoneNumberController: phoneNumberController,
        newPasswordController: newPasswordController,
        currentPasswordController: currentPasswordController,
      ),
      tablet: SettingsTabletLayout(
        l10n: l10n,
        userData: userData,
        tabController: tabController,
        onPressed: () => openChattingPage(),
        nameController: nameController,
        birthdayController: birthdayController,
        selectedDate: _selectedDate,
        emailController: emailController,
        phoneNumberController: phoneNumberController,
        newPasswordController: newPasswordController,
        currentPasswordController: currentPasswordController,
      ),
      desktop: SettingsDesktopLayout(
        l10n: l10n,
        userData: userData,
        tabController: tabController,
        onPressed: () => openChattingPage(),
        nameController: nameController,
        birthdayController: birthdayController,
        selectedDate: _selectedDate,
        emailController: emailController,
        phoneNumberController: phoneNumberController,
        newPasswordController: newPasswordController,
        currentPasswordController: currentPasswordController,
      ),
    );
  }
}
