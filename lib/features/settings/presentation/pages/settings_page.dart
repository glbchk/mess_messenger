import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mess_messenger_app/core/enums/enums.dart';
import 'package:mess_messenger_app/core/extensions/l10n_extension.dart';
import 'package:mess_messenger_app/core/router/app_routes.dart';
import 'package:mess_messenger_app/core/utils/layouts/responsive_layout_wrapper.dart';
import 'package:mess_messenger_app/core/widgets/mess_alert.dart';
import 'package:mess_messenger_app/features/auth/auth_providers/auth_providers.dart';
import 'package:mess_messenger_app/features/auth/presentation/states/auth_state.dart';
import 'package:mess_messenger_app/features/settings/data/models/user_model.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/account_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/controllers/general_settings_controller.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/settings_desktop_layout.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/settings_mobile_layout.dart';
import 'package:mess_messenger_app/features/settings/presentation/pages/layouts/settings_layout/settings_tablet_layout.dart';
import 'package:mess_messenger_app/features/settings/user_providers/data_providers/user_providers.dart';
import 'package:mess_messenger_app/features/settings/user_providers/ui_providers/general_settings_ui_provider.dart';
import 'package:mess_messenger_app/localization/errors/auth_failure_l10n.dart';
import 'package:mess_messenger_app/localization/supported_locales.dart';

class SettingsPage extends ConsumerStatefulWidget {
  final String? initialTab;
  const SettingsPage({super.key, this.initialTab});

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

  final Map<String, Timer> _debounce = {};

  final _settingsTabNames = [
    'general',
    'account',
    'personalisation',
    'billing',
    'notifications',
    'api',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    final targetTab = widget.initialTab ?? SettingsTab.general.name;
    int initialIndex = SettingsTab.values.indexWhere(
      (tab) => tab.name == targetTab,
    );
    if (initialIndex == -1) initialIndex = 0;

    tabController = TabController(
      length: SettingsTab.values.length,
      vsync: this,
      initialIndex: initialIndex,
    );

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        final selectedTabName = SettingsTab.values[tabController.index].name;
        context.go('/settings/$selectedTabName');
      }
    });

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
    for (final t in _debounce.values) {
      t.cancel();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      ref.read(userNotifierProvider.notifier).checkEmailVerificationStatus();
    }
  }

  Future<void> openChattingPage() async {}

  void _showChangeAvatarDialog() {
    //TODO: Still need to fix, errors are not displaying properly and also it saves anything now

    MessAlertWidget.show(
      context: context,
      ref: ref,
      title: 'Change your avatar',
      message: 'Take a picture or select one of your existing pictures.',
      buttonLabel: 'Take a picture',
      secondaryButtonLabel: 'Select photo',
      onConfirmWithImage: (XFile? selectedImage) async {
        if (selectedImage == null) return;
        await ref
            .read(userNotifierProvider.notifier)
            .updateAvatar(selectedImage);
      },
      onSecondaryPressed: () async {},
      pictureSelectorEnabled: true,
    );
  }

  void _logoutFromAllDevices() {
    ref.read(authNotifierProvider.notifier).logoutFromAllDevices();
  }

  void _onArchiveAllMessages() {
    print('DEBUG: Archive all messages');
    // TODO: implement archive-all
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final userData =
        ref.watch(userNotifierProvider).userData ?? UserModel(id: '');
    // final userNotifier = ref.read(userNotifierProvider.notifier);
    final languages = getSupportedLanguages(l10n);
    final view = buildGeneralSettingsView(userData, l10n);
    final generalSettingsController = ref.read(
      generalSettingsControllerProvider,
    );

    final accountSettingsController = ref.read(
      accountSettingsControllerProvider,
    );

    ref.listen<AuthState>(authNotifierProvider, (prev, next) {
      if (next is AuthAuthenticated && next.passwordUpdateError != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.passwordUpdateError!.message(l10n))),
        );
      }
    });

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

    return ResponsiveLayout(
      mobile: SettingsMobileLayout(
        userData: userData,
        tabController: tabController,
        onPressedArchiveAllMessages: _onArchiveAllMessages,
        onPressedChangeAvatar: _showChangeAvatarDialog,
        onPressedLogoutFromAllDevices: _logoutFromAllDevices,
        onPressedContactSupport: () => context.push(AppRoutes.support),
        view: view,
        generalSettingsController: generalSettingsController,
        languages: languages,
        accountSettingsController: accountSettingsController,
        nameController: nameController,
        birthdayController: birthdayController,
        selectedDate: _selectedDate,
        emailController: emailController,
        phoneNumberController: phoneNumberController,
        currentPasswordController: currentPasswordController,
        newPasswordController: newPasswordController,
      ),
      tablet: SettingsTabletLayout(
        userData: userData,
        tabController: tabController,
        onPressedArchiveAllMessages: _onArchiveAllMessages,
        onPressedChangeAvatar: _showChangeAvatarDialog,
        onPressedLogoutFromAllDevices: _logoutFromAllDevices,
        view: view,
        generalSettingsController: generalSettingsController,
        languages: languages,
        accountSettingsController: accountSettingsController,
        nameController: nameController,
        birthdayController: birthdayController,
        selectedDate: _selectedDate,
        emailController: emailController,
        phoneNumberController: phoneNumberController,
        currentPasswordController: currentPasswordController,
        newPasswordController: newPasswordController,
      ),
      desktop: SettingsDesktopLayout(
        userData: userData,
        tabController: tabController,
        onPressedArchiveAllMessages: _onArchiveAllMessages,
        onPressedChangeAvatar: _showChangeAvatarDialog,
        onPressedLogoutFromAllDevices: _logoutFromAllDevices,
        view: view,
        generalSettingsController: generalSettingsController,
        languages: languages,
        accountSettingsController: accountSettingsController,
        nameController: nameController,
        birthdayController: birthdayController,
        selectedDate: _selectedDate,
        emailController: emailController,
        phoneNumberController: phoneNumberController,
        currentPasswordController: currentPasswordController,
        newPasswordController: newPasswordController,
      ),
    );
  }
}
