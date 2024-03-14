// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routeApiHash() => r'a4571fb5da01f1d1b9d2e9952632e54551d50eb7';

/// See also [routeApi].
@ProviderFor(routeApi)
final routeApiProvider = AutoDisposeProvider<RouteApi>.internal(
  routeApi,
  name: r'routeApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$routeApiHash,
  dependencies: <ProviderOrFamily>[routeRepositoryProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    routeRepositoryProvider,
    ...?routeRepositoryProvider.allTransitiveDependencies
  },
);

typedef RouteApiRef = AutoDisposeProviderRef<RouteApi>;
String _$routeGraphApiHash() => r'd17e6ad152e49e0269ac123ee42e43c359970fef';

/// See also [routeGraphApi].
@ProviderFor(routeGraphApi)
final routeGraphApiProvider = AutoDisposeProvider<RouteGraphApi>.internal(
  routeGraphApi,
  name: r'routeGraphApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routeGraphApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RouteGraphApiRef = AutoDisposeProviderRef<RouteGraphApi>;
String _$routeRepositoryHash() => r'9a570b74e60035ed0275ec81b8cf67aebe1f5d9b';

/// See also [routeRepository].
@ProviderFor(routeRepository)
final routeRepositoryProvider = AutoDisposeProvider<RouteRepository>.internal(
  routeRepository,
  name: r'routeRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routeRepositoryHash,
  dependencies: <ProviderOrFamily>[
    routeRemoteDataProvider,
    authenticationStreamProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    routeRemoteDataProvider,
    ...?routeRemoteDataProvider.allTransitiveDependencies,
    authenticationStreamProvider,
    ...?authenticationStreamProvider.allTransitiveDependencies
  },
);

typedef RouteRepositoryRef = AutoDisposeProviderRef<RouteRepository>;
String _$routeRemoteDataHash() => r'7686c05ad9d83a3f3786abe0b63aff68957e933a';

/// See also [routeRemoteData].
@ProviderFor(routeRemoteData)
final routeRemoteDataProvider =
    AutoDisposeProvider<RouteRemoteDataProvider>.internal(
  routeRemoteData,
  name: r'routeRemoteDataProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routeRemoteDataHash,
  dependencies: <ProviderOrFamily>[crashlyticsApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    crashlyticsApiProvider,
    ...?crashlyticsApiProvider.allTransitiveDependencies
  },
);

typedef RouteRemoteDataRef = AutoDisposeProviderRef<RouteRemoteDataProvider>;
String _$fetchUserStatsHash() => r'42c921fec02927e33836b5c21aa2dcfca04e1ca8';

/// See also [fetchUserStats].
@ProviderFor(fetchUserStats)
final fetchUserStatsProvider =
    AutoDisposeFutureProvider<UserStatsModel>.internal(
  fetchUserStats,
  name: r'fetchUserStatsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchUserStatsHash,
  dependencies: <ProviderOrFamily>[routeApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    routeApiProvider,
    ...?routeApiProvider.allTransitiveDependencies
  },
);

typedef FetchUserStatsRef = AutoDisposeFutureProviderRef<UserStatsModel>;
String _$fetchAllRoutesHash() => r'575dfeb020f2d9730747b22decc903edf1f49d4e';

/// See also [fetchAllRoutes].
@ProviderFor(fetchAllRoutes)
final fetchAllRoutesProvider =
    AutoDisposeFutureProvider<List<RouteModel>>.internal(
  fetchAllRoutes,
  name: r'fetchAllRoutesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAllRoutesHash,
  dependencies: <ProviderOrFamily>[routeApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    routeApiProvider,
    ...?routeApiProvider.allTransitiveDependencies
  },
);

typedef FetchAllRoutesRef = AutoDisposeFutureProviderRef<List<RouteModel>>;
String _$fetchActiveRoutesHash() => r'9092109ebf76139fa5a3155535c03b10cb5aa360';

/// See also [fetchActiveRoutes].
@ProviderFor(fetchActiveRoutes)
final fetchActiveRoutesProvider =
    AutoDisposeFutureProvider<List<RouteModel>>.internal(
  fetchActiveRoutes,
  name: r'fetchActiveRoutesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchActiveRoutesHash,
  dependencies: <ProviderOrFamily>[routeApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    routeApiProvider,
    ...?routeApiProvider.allTransitiveDependencies
  },
);

typedef FetchActiveRoutesRef = AutoDisposeFutureProviderRef<List<RouteModel>>;
String _$fetchRemovedRoutesHash() =>
    r'c32ca1cb90303fb9f9425622c22f4b25f9e00116';

/// See also [fetchRemovedRoutes].
@ProviderFor(fetchRemovedRoutes)
final fetchRemovedRoutesProvider =
    AutoDisposeFutureProvider<List<RouteModel>>.internal(
  fetchRemovedRoutes,
  name: r'fetchRemovedRoutesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchRemovedRoutesHash,
  dependencies: <ProviderOrFamily>[routeApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    routeApiProvider,
    ...?routeApiProvider.allTransitiveDependencies
  },
);

typedef FetchRemovedRoutesRef = AutoDisposeFutureProviderRef<List<RouteModel>>;
String _$fetchFilteredRoutesHash() =>
    r'475af9df31e1e1c8cb44d46113aa7490d5585b3e';

/// See also [fetchFilteredRoutes].
@ProviderFor(fetchFilteredRoutes)
final fetchFilteredRoutesProvider =
    AutoDisposeFutureProvider<RouteFilterModel>.internal(
  fetchFilteredRoutes,
  name: r'fetchFilteredRoutesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchFilteredRoutesHash,
  dependencies: <ProviderOrFamily>[routeApiProvider, fetchActiveRoutesProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    routeApiProvider,
    ...?routeApiProvider.allTransitiveDependencies,
    fetchActiveRoutesProvider,
    ...?fetchActiveRoutesProvider.allTransitiveDependencies
  },
);

typedef FetchFilteredRoutesRef = AutoDisposeFutureProviderRef<RouteFilterModel>;
String _$fetchFilteredRemovedRoutesHash() =>
    r'7fc35014aea3b98f86a7d8a87f423c3cbb61d0d4';

/// See also [fetchFilteredRemovedRoutes].
@ProviderFor(fetchFilteredRemovedRoutes)
final fetchFilteredRemovedRoutesProvider =
    AutoDisposeFutureProvider<RouteFilterModel>.internal(
  fetchFilteredRemovedRoutes,
  name: r'fetchFilteredRemovedRoutesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchFilteredRemovedRoutesHash,
  dependencies: <ProviderOrFamily>[
    routeApiProvider,
    fetchRemovedRoutesProvider
  ],
  allTransitiveDependencies: <ProviderOrFamily>{
    routeApiProvider,
    ...?routeApiProvider.allTransitiveDependencies,
    fetchRemovedRoutesProvider,
    ...?fetchRemovedRoutesProvider.allTransitiveDependencies
  },
);

typedef FetchFilteredRemovedRoutesRef
    = AutoDisposeFutureProviderRef<RouteFilterModel>;
String _$fetchLocationFilteredRoutesHash() =>
    r'47e8a0e3ae8d4fac424c3727a13b5a268b584d00';

/// See also [fetchLocationFilteredRoutes].
@ProviderFor(fetchLocationFilteredRoutes)
final fetchLocationFilteredRoutesProvider =
    AutoDisposeFutureProvider<RouteFilterModel>.internal(
  fetchLocationFilteredRoutes,
  name: r'fetchLocationFilteredRoutesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchLocationFilteredRoutesHash,
  dependencies: <ProviderOrFamily>[routeApiProvider, fetchActiveRoutesProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    routeApiProvider,
    ...?routeApiProvider.allTransitiveDependencies,
    fetchActiveRoutesProvider,
    ...?fetchActiveRoutesProvider.allTransitiveDependencies
  },
);

typedef FetchLocationFilteredRoutesRef
    = AutoDisposeFutureProviderRef<RouteFilterModel>;
String _$fetchRatingUserGraphHash() =>
    r'5818761231e882d4e1a94188bbfaec724aca1ebd';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchRatingUserGraph].
@ProviderFor(fetchRatingUserGraph)
const fetchRatingUserGraphProvider = FetchRatingUserGraphFamily();

/// See also [fetchRatingUserGraph].
class FetchRatingUserGraphFamily
    extends Family<AsyncValue<List<UserRatingModel>>> {
  /// See also [fetchRatingUserGraph].
  const FetchRatingUserGraphFamily();

  /// See also [fetchRatingUserGraph].
  FetchRatingUserGraphProvider call({
    required ClimbType climbType,
  }) {
    return FetchRatingUserGraphProvider(
      climbType: climbType,
    );
  }

  @override
  FetchRatingUserGraphProvider getProviderOverride(
    covariant FetchRatingUserGraphProvider provider,
  ) {
    return call(
      climbType: provider.climbType,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[
    fetchAllRoutesProvider,
    fetchActiveRoutesProvider
  ];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies =
      <ProviderOrFamily>{
    fetchAllRoutesProvider,
    ...?fetchAllRoutesProvider.allTransitiveDependencies,
    fetchActiveRoutesProvider,
    ...?fetchActiveRoutesProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchRatingUserGraphProvider';
}

/// See also [fetchRatingUserGraph].
class FetchRatingUserGraphProvider
    extends AutoDisposeFutureProvider<List<UserRatingModel>> {
  /// See also [fetchRatingUserGraph].
  FetchRatingUserGraphProvider({
    required ClimbType climbType,
  }) : this._internal(
          (ref) => fetchRatingUserGraph(
            ref as FetchRatingUserGraphRef,
            climbType: climbType,
          ),
          from: fetchRatingUserGraphProvider,
          name: r'fetchRatingUserGraphProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchRatingUserGraphHash,
          dependencies: FetchRatingUserGraphFamily._dependencies,
          allTransitiveDependencies:
              FetchRatingUserGraphFamily._allTransitiveDependencies,
          climbType: climbType,
        );

  FetchRatingUserGraphProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.climbType,
  }) : super.internal();

  final ClimbType climbType;

  @override
  Override overrideWith(
    FutureOr<List<UserRatingModel>> Function(FetchRatingUserGraphRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchRatingUserGraphProvider._internal(
        (ref) => create(ref as FetchRatingUserGraphRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        climbType: climbType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<UserRatingModel>> createElement() {
    return _FetchRatingUserGraphProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchRatingUserGraphProvider &&
        other.climbType == climbType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, climbType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchRatingUserGraphRef
    on AutoDisposeFutureProviderRef<List<UserRatingModel>> {
  /// The parameter `climbType` of this provider.
  ClimbType get climbType;
}

class _FetchRatingUserGraphProviderElement
    extends AutoDisposeFutureProviderElement<List<UserRatingModel>>
    with FetchRatingUserGraphRef {
  _FetchRatingUserGraphProviderElement(super.provider);

  @override
  ClimbType get climbType => (origin as FetchRatingUserGraphProvider).climbType;
}

String _$includeRemovedRoutesHash() =>
    r'cb0df3883752a1209bee67eaaaa487993f7f00e0';

/// See also [IncludeRemovedRoutes].
@ProviderFor(IncludeRemovedRoutes)
final includeRemovedRoutesProvider =
    AutoDisposeNotifierProvider<IncludeRemovedRoutes, bool>.internal(
  IncludeRemovedRoutes.new,
  name: r'includeRemovedRoutesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$includeRemovedRoutesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IncludeRemovedRoutes = AutoDisposeNotifier<bool>;
String _$includeGraphDetailsHash() =>
    r'6d45755a10fba63e46102ccbb097c532755faecc';

/// See also [IncludeGraphDetails].
@ProviderFor(IncludeGraphDetails)
final includeGraphDetailsProvider =
    AutoDisposeNotifierProvider<IncludeGraphDetails, bool>.internal(
  IncludeGraphDetails.new,
  name: r'includeGraphDetailsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$includeGraphDetailsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IncludeGraphDetails = AutoDisposeNotifier<bool>;
String _$routeTextFilterHash() => r'068d94e972b83ca124a0ebd065229b1189d23778';

/// See also [RouteTextFilter].
@ProviderFor(RouteTextFilter)
final routeTextFilterProvider =
    AutoDisposeNotifierProvider<RouteTextFilter, String?>.internal(
  RouteTextFilter.new,
  name: r'routeTextFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routeTextFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RouteTextFilter = AutoDisposeNotifier<String?>;
String _$routeClimbTypeFilterHash() =>
    r'dce455f3cf2d33380ec3da23037669c0c3886ab6';

/// See also [RouteClimbTypeFilter].
@ProviderFor(RouteClimbTypeFilter)
final routeClimbTypeFilterProvider =
    AutoDisposeNotifierProvider<RouteClimbTypeFilter, ClimbType?>.internal(
  RouteClimbTypeFilter.new,
  name: r'routeClimbTypeFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routeClimbTypeFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RouteClimbTypeFilter = AutoDisposeNotifier<ClimbType?>;
String _$routeColorFilterHash() => r'1edb95f9f3f67932e3bcd5ccf094e7b4d2f3b38e';

/// See also [RouteColorFilter].
@ProviderFor(RouteColorFilter)
final routeColorFilterProvider =
    AutoDisposeNotifierProvider<RouteColorFilter, RouteColor?>.internal(
  RouteColorFilter.new,
  name: r'routeColorFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routeColorFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RouteColorFilter = AutoDisposeNotifier<RouteColor?>;
String _$routeAttemptedFilterHash() =>
    r'ef27e21bfcc13d6f4866dcbf73e397a319d6c2f2';

/// See also [RouteAttemptedFilter].
@ProviderFor(RouteAttemptedFilter)
final routeAttemptedFilterProvider =
    AutoDisposeNotifierProvider<RouteAttemptedFilter, bool?>.internal(
  RouteAttemptedFilter.new,
  name: r'routeAttemptedFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routeAttemptedFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RouteAttemptedFilter = AutoDisposeNotifier<bool?>;
String _$routeWallLocationFilterHash() =>
    r'ad14acee0d1391c988ba52aedb33ece281a19283';

/// See also [RouteWallLocationFilter].
@ProviderFor(RouteWallLocationFilter)
final routeWallLocationFilterProvider =
    NotifierProvider<RouteWallLocationFilter, WallLocation?>.internal(
  RouteWallLocationFilter.new,
  name: r'routeWallLocationFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routeWallLocationFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RouteWallLocationFilter = Notifier<WallLocation?>;
String _$routeWallLocationIndexFilterHash() =>
    r'1e70fa7abd90206c8c7b4ab9300a7b48667dc76a';

/// See also [RouteWallLocationIndexFilter].
@ProviderFor(RouteWallLocationIndexFilter)
final routeWallLocationIndexFilterProvider =
    NotifierProvider<RouteWallLocationIndexFilter, int?>.internal(
  RouteWallLocationIndexFilter.new,
  name: r'routeWallLocationIndexFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routeWallLocationIndexFilterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RouteWallLocationIndexFilter = Notifier<int?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
