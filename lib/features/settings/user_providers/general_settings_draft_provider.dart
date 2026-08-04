import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mess_messenger_app/features/settings/data/models/general_settings_model.dart';
import 'package:mess_messenger_app/features/settings/user_providers/user_providers.dart';

class GeneralSettingsDraftNotifier extends Notifier<GeneralSettingsModel> {
  @override
  GeneralSettingsModel build() {
    final userData = ref.read(userNotifierProvider).userData;
    return userData?.generalSettings ?? GeneralSettingsModel.defaults();
  }

  void setLogin(bool value) {
    state = state.copyUserWith(isLoggedIn: value);
  }

  void setLanguage(String? code) {
    state = state.copyUserWith(language: () => code);
  }

  void togglePhoto() {
    state = state.copyUserWith(
      isPhotoPasswordProtected: !(state.isPhotoPasswordProtected ?? false),
    );
  }

  void toggleAudio() {
    state = state.copyUserWith(
      isAudioPasswordProtected: !(state.isAudioPasswordProtected ?? false),
    );
  }

  void toggleVideo() {
    state = state.copyUserWith(
      isVideoPasswordProtected: !(state.isVideoPasswordProtected ?? false),
    );
  }

  void toggleDocument() {
    state = state.copyUserWith(
      isDocumentPasswordProtected:
          !(state.isDocumentPasswordProtected ?? false),
    );
  }

  void reset() {
    final userData = ref.read(userNotifierProvider).userData;
    state = userData?.generalSettings ?? GeneralSettingsModel.defaults();
  }
}

final generalSettingsDraftProvider =
    NotifierProvider<GeneralSettingsDraftNotifier, GeneralSettingsModel>(
      GeneralSettingsDraftNotifier.new,
    );
