// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userApiHash() => r'e79a9bd3f15642fa9cb3d8103ec2c35fbe28d369';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UserApiRef = AutoDisposeProviderRef<UserRemoteDataProvider>;
String _$authenticationStreamHash() =>
    r'5dac208c8c089de552f64d986fa9f4ad65ef1625';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthenticationStreamRef = AutoDisposeStreamProviderRef<UserModel?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
