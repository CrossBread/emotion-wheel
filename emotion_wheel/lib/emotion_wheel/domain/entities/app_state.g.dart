// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AppStateCWProxy {
  AppState selectedCoreEmotion(String? selectedCoreEmotion);

  AppState selectedSecondaryEmotion(String? selectedSecondaryEmotion);

  AppState selectedTertiaryEmotion(String? selectedTertiaryEmotion);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AppState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AppState(...).copyWith(id: 12, name: "My name")
  /// ````
  AppState call({
    String? selectedCoreEmotion,
    String? selectedSecondaryEmotion,
    String? selectedTertiaryEmotion,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAppState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAppState.copyWith.fieldName(...)`
class _$AppStateCWProxyImpl implements _$AppStateCWProxy {
  const _$AppStateCWProxyImpl(this._value);

  final AppState _value;

  @override
  AppState selectedCoreEmotion(String? selectedCoreEmotion) => this(selectedCoreEmotion: selectedCoreEmotion);

  @override
  AppState selectedSecondaryEmotion(String? selectedSecondaryEmotion) =>
      this(selectedSecondaryEmotion: selectedSecondaryEmotion);

  @override
  AppState selectedTertiaryEmotion(String? selectedTertiaryEmotion) =>
      this(selectedTertiaryEmotion: selectedTertiaryEmotion);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AppState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AppState(...).copyWith(id: 12, name: "My name")
  /// ````
  AppState call({
    Object? selectedCoreEmotion = const $CopyWithPlaceholder(),
    Object? selectedSecondaryEmotion = const $CopyWithPlaceholder(),
    Object? selectedTertiaryEmotion = const $CopyWithPlaceholder(),
  }) {
    return AppState(
      selectedCoreEmotion: selectedCoreEmotion == const $CopyWithPlaceholder()
          ? _value.selectedCoreEmotion
          // ignore: cast_nullable_to_non_nullable
          : selectedCoreEmotion as String?,
      selectedSecondaryEmotion: selectedSecondaryEmotion == const $CopyWithPlaceholder()
          ? _value.selectedSecondaryEmotion
          // ignore: cast_nullable_to_non_nullable
          : selectedSecondaryEmotion as String?,
      selectedTertiaryEmotion: selectedTertiaryEmotion == const $CopyWithPlaceholder()
          ? _value.selectedTertiaryEmotion
          // ignore: cast_nullable_to_non_nullable
          : selectedTertiaryEmotion as String?,
    );
  }
}

extension $AppStateCopyWith on AppState {
  /// Returns a callable class that can be used as follows: `instanceOfAppState.copyWith(...)` or like so:`instanceOfAppState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AppStateCWProxy get copyWith => _$AppStateCWProxyImpl(this);
}
