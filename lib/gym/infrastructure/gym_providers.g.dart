// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gym_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gymApiHash() => r'376d082170669accea436582b5b0a51fa63c2cd2';

/// See also [gymApi].
@ProviderFor(gymApi)
final gymApiProvider = AutoDisposeProvider<GymApi>.internal(
  gymApi,
  name: r'gymApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$gymApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GymApiRef = AutoDisposeProviderRef<GymApi>;
String _$gymRepositoryHash() => r'2ccfb8d7181d33a4d37a1d9ca0fe783750a7fedb';

/// See also [gymRepository].
@ProviderFor(gymRepository)
final gymRepositoryProvider = AutoDisposeProvider<GymRepository>.internal(
  gymRepository,
  name: r'gymRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gymRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GymRepositoryRef = AutoDisposeProviderRef<GymRepository>;
String _$gymRemoteDataHash() => r'616f32832a8ec2bff66f8be0e4661028f88c7831';

/// See also [gymRemoteData].
@ProviderFor(gymRemoteData)
final gymRemoteDataProvider =
    AutoDisposeProvider<GymRemoteDataProvider>.internal(
  gymRemoteData,
  name: r'gymRemoteDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gymRemoteDataHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GymRemoteDataRef = AutoDisposeProviderRef<GymRemoteDataProvider>;
String _$resetScheduleHash() => r'208905e463bf02692347c4b056f3e48f8b539069';

/// See also [resetSchedule].
@ProviderFor(resetSchedule)
final resetScheduleProvider =
    AutoDisposeFutureProvider<List<ResetModel>>.internal(
  resetSchedule,
  name: r'resetScheduleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resetScheduleHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ResetScheduleRef = AutoDisposeFutureProviderRef<List<ResetModel>>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
