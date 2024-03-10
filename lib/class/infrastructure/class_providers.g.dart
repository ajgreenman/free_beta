// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$classApiHash() => r'45fd44fa6f6e73fa5bcb46c20962b63b6c9217db';

/// See also [classApi].
@ProviderFor(classApi)
final classApiProvider = AutoDisposeProvider<ClassApi>.internal(
  classApi,
  name: r'classApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$classApiHash,
  dependencies: <ProviderOrFamily>[classRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    classRepositoryProvider,
    ...?classRepositoryProvider.allTransitiveDependencies
  },
);

typedef ClassApiRef = AutoDisposeProviderRef<ClassApi>;
String _$classRepositoryHash() => r'133278a30ebfaeb2942d4daa8ec39127d8ae1c48';

/// See also [classRepository].
@ProviderFor(classRepository)
final classRepositoryProvider = AutoDisposeProvider<ClassRepository>.internal(
  classRepository,
  name: r'classRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$classRepositoryHash,
  dependencies: <ProviderOrFamily>[classRemoteDataProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    classRemoteDataProvider,
    ...?classRemoteDataProvider.allTransitiveDependencies
  },
);

typedef ClassRepositoryRef = AutoDisposeProviderRef<ClassRepository>;
String _$classRemoteDataHash() => r'6973363c5ce65711357eec9dd26aac8ad1f82f6a';

/// See also [classRemoteData].
@ProviderFor(classRemoteData)
final classRemoteDataProvider =
    AutoDisposeProvider<ClassRemoteDataProvider>.internal(
  classRemoteData,
  name: r'classRemoteDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$classRemoteDataHash,
  dependencies: <ProviderOrFamily>[crashlyticsApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    crashlyticsApiProvider,
    ...?crashlyticsApiProvider.allTransitiveDependencies
  },
);

typedef ClassRemoteDataRef = AutoDisposeProviderRef<ClassRemoteDataProvider>;
String _$fetchClassesHash() => r'bfd53b6cd0b189f9965226fb880ea779b5a3f37a';

/// See also [fetchClasses].
@ProviderFor(fetchClasses)
final fetchClassesProvider =
    AutoDisposeFutureProvider<List<ClassModel>>.internal(
  fetchClasses,
  name: r'fetchClassesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchClassesHash,
  dependencies: <ProviderOrFamily>[classApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    classApiProvider,
    ...?classApiProvider.allTransitiveDependencies
  },
);

typedef FetchClassesRef = AutoDisposeFutureProviderRef<List<ClassModel>>;
String _$fetchDaysHash() => r'bf0dbb15e667355b8da5ea3ac376a48a61804ef0';

/// See also [fetchDays].
@ProviderFor(fetchDays)
final fetchDaysProvider = AutoDisposeFutureProvider<List<DayModel>>.internal(
  fetchDays,
  name: r'fetchDaysProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$fetchDaysHash,
  dependencies: <ProviderOrFamily>[classApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    classApiProvider,
    ...?classApiProvider.allTransitiveDependencies
  },
);

typedef FetchDaysRef = AutoDisposeFutureProviderRef<List<DayModel>>;
String _$getClassScheduleHash() => r'48507345b888a1971dc2651fcfa0d779e5840fa9';

/// See also [getClassSchedule].
@ProviderFor(getClassSchedule)
final getClassScheduleProvider =
    AutoDisposeFutureProvider<List<ClassScheduleModel>>.internal(
  getClassSchedule,
  name: r'getClassScheduleProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getClassScheduleHash,
  dependencies: <ProviderOrFamily>[fetchDaysProvider, fetchClassesProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    fetchDaysProvider,
    ...?fetchDaysProvider.allTransitiveDependencies,
    fetchClassesProvider,
    ...?fetchClassesProvider.allTransitiveDependencies
  },
);

typedef GetClassScheduleRef
    = AutoDisposeFutureProviderRef<List<ClassScheduleModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
