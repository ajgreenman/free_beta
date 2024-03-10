// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gymApiHash() => r'd02386a499e840986ce59c7bf3ca66a51d8b8825';

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

typedef GymApiRef = AutoDisposeProviderRef<GymApi>;
String _$gymRepositoryHash() => r'e408202a33a719a9132b2c13e90e1b3c37e46d9d';

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

typedef GymRepositoryRef = AutoDisposeProviderRef<GymRepository>;
String _$gymRemoteDataHash() => r'f4c097a55d22d8d1c302d2ccfd857942adfb97dc';

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

typedef GymRemoteDataRef = AutoDisposeProviderRef<GymRemoteDataProvider>;
String _$resetScheduleHash() => r'f456213400484f9e7e4bce0d30d88dfe5f41dbee';

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

typedef ResetScheduleRef = AutoDisposeFutureProviderRef<List<ResetModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
