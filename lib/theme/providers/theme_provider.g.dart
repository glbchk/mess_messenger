// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AppTheme)
final appThemeProvider = AppThemeProvider._();

final class AppThemeProvider extends $NotifierProvider<AppTheme, ThemeMode> {
  AppThemeProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeHash();

  @$internal
  @override
  AppTheme create() => AppTheme();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ThemeMode value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ThemeMode>(value),
    );
  }
}

String _$appThemeHash() => r'308367822faefe7a38624e87eabf99e68b00f5d2';

abstract class _$AppTheme extends $Notifier<ThemeMode> {
  ThemeMode build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ThemeMode, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ThemeMode, ThemeMode>,
              ThemeMode,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(_appL10n)
final _appL10nProvider = _AppL10nProvider._();

final class _AppL10nProvider
    extends
        $FunctionalProvider<
          AppLocalizations,
          AppLocalizations,
          AppLocalizations
        >
    with $Provider<AppLocalizations> {
  _AppL10nProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'_appL10nProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$_appL10nHash();

  @$internal
  @override
  $ProviderElement<AppLocalizations> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppLocalizations create(Ref ref) {
    return _appL10n(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLocalizations value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLocalizations>(value),
    );
  }
}

String _$_appL10nHash() => r'6059fa2f44b0787f3516b73bce2207d5da98e664';

@ProviderFor(themeModeOptions)
final themeModeOptionsProvider = ThemeModeOptionsProvider._();

final class ThemeModeOptionsProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  ThemeModeOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeModeOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeModeOptionsHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return themeModeOptions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$themeModeOptionsHash() => r'b8c56338a239064040e9ee79491ac3047430feeb';

@ProviderFor(currentThemeModeLabel)
final currentThemeModeLabelProvider = CurrentThemeModeLabelProvider._();

final class CurrentThemeModeLabelProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  CurrentThemeModeLabelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentThemeModeLabelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentThemeModeLabelHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return currentThemeModeLabel(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$currentThemeModeLabelHash() =>
    r'5b3f493ae1184d504173bf6e630570441d82bbc3';
