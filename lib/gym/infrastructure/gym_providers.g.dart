// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gymApiHash() => r'd7f116828a2ce78f2cbe942c954f73412758f411';

/// See also [gymApi].
@ProviderFor(gymApi)
final gymApiProvider = AutoDisposeProvider<GymApi>.internal(
  gymApi,
  name: r'gymApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gymApiHash,
  dependencies: <ProviderOrFamily>[gymRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    gymRepositoryProvider,
    ...?gymRepositoryProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GymApiRef = AutoDisposeProviderRef<GymApi>;
String _$gymRepositoryHash() => r'7e0819f5f8b73d3aed0204f9df8a0cab7c837afa';

/// See also [gymRepository].
@ProviderFor(gymRepository)
final gymRepositoryProvider = AutoDisposeProvider<GymRepository>.internal(
  gymRepository,
  name: r'gymRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gymRepositoryHash,
  dependencies: <ProviderOrFamily>[gymRemoteDataProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    gymRemoteDataProvider,
    ...?gymRemoteDataProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GymRepositoryRef = AutoDisposeProviderRef<GymRepository>;
String _$gymRemoteDataHash() => r'abdf1a6a42c299141ea39f2d5c6c30b1233d474a';

/// See also [gymRemoteData].
@ProviderFor(gymRemoteData)
final gymRemoteDataProvider =
    AutoDisposeProvider<GymRemoteDataProvider>.internal(
  gymRemoteData,
  name: r'gymRemoteDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gymRemoteDataHash,
  dependencies: <ProviderOrFamily>[crashlyticsApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    crashlyticsApiProvider,
    ...?crashlyticsApiProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GymRemoteDataRef = AutoDisposeProviderRef<GymRemoteDataProvider>;
String _$resetScheduleHash() => r'a0c80b461f12229f3b441159ba0dd04f748f6c13';

/// See also [resetSchedule].
@ProviderFor(resetSchedule)
final resetScheduleProvider =
    AutoDisposeFutureProvider<List<ResetModel>>.internal(
  resetSchedule,
  name: r'resetScheduleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resetScheduleHash,
  dependencies: <ProviderOrFamily>[gymApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    gymApiProvider,
    ...?gymApiProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ResetScheduleRef = AutoDisposeFutureProviderRef<List<ResetModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
