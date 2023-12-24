// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userApiHash() => r'2b6205eef1ccaa0c2bbe237b6dd600fdc0a3184b';

/// See also [userApi].
@ProviderFor(userApi)
final userApiProvider = AutoDisposeProvider<UserApi>.internal(
  userApi,
  name: r'userApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserApiRef = AutoDisposeProviderRef<UserApi>;
String _$authenticationStreamHash() =>
    r'1003b1c8ef0dc96111b7b21561bb589b330751ae';

/// See also [authenticationStream].
@ProviderFor(authenticationStream)
final authenticationStreamProvider =
    AutoDisposeStreamProvider<UserModel?>.internal(
  authenticationStream,
  name: r'authenticationStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticationStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AuthenticationStreamRef = AutoDisposeStreamProviderRef<UserModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
