// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$classApiHash() => r'b2d3d52736ab6ec2b1eb713b99c9be217f93e661';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClassApiRef = AutoDisposeProviderRef<ClassApi>;
String _$classRepositoryHash() => r'371307d4863a2c2fcb34c94961e78941a240f08c';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClassRepositoryRef = AutoDisposeProviderRef<ClassRepository>;
String _$classRemoteDataHash() => r'e754f30a708259726872ae46345ee779ab7f63c9';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ClassRemoteDataRef = AutoDisposeProviderRef<ClassRemoteDataProvider>;
String _$fetchClassesHash() => r'520d8203457c322b8703b978fcbe3c5031364e17';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchClassesRef = AutoDisposeFutureProviderRef<List<ClassModel>>;
String _$fetchDaysHash() => r'ea0c93f65fea85fa5e4d90d8de3a334ef75f6097';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchDaysRef = AutoDisposeFutureProviderRef<List<DayModel>>;
String _$getClassScheduleHash() => r'5e5523d2d06e773148bda83a3abeafe70dad7ae4';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetClassScheduleRef
    = AutoDisposeFutureProviderRef<List<ClassScheduleModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
