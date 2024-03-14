// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userApiHash() => r'dd2eff5dbd52d962af1256f483eac4e5afd99902';

/// See also [userApi].
@ProviderFor(userApi)
final userApiProvider = AutoDisposeProvider<UserRemoteDataProvider>.internal(
  userApi,
  name: r'userApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userApiHash,
  dependencies: <ProviderOrFamily>[crashlyticsApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    crashlyticsApiProvider,
    ...?crashlyticsApiProvider.allTransitiveDependencies
  },
);

typedef UserApiRef = AutoDisposeProviderRef<UserRemoteDataProvider>;
String _$authenticationStreamHash() =>
    r'f2dd4059aabb956569ddbf1b8c150365b6caac8b';

/// See also [authenticationStream].
@ProviderFor(authenticationStream)
final authenticationStreamProvider =
    AutoDisposeStreamProvider<UserModel?>.internal(
  authenticationStream,
  name: r'authenticationStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authenticationStreamHash,
  dependencies: <ProviderOrFamily>[userApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    userApiProvider,
    ...?userApiProvider.allTransitiveDependencies
  },
);

typedef AuthenticationStreamRef = AutoDisposeStreamProviderRef<UserModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
