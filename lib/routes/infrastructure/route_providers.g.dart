// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$routeApiHash() => r'9781339c65d67887a6e05fe873e1372d67e4d2b3';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouteApiRef = AutoDisposeProviderRef<RouteApi>;
String _$routeGraphApiHash() => r'3484aae4ae12ed6da1755127969a598831784eb3';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouteGraphApiRef = AutoDisposeProviderRef<RouteGraphApi>;
String _$routeRepositoryHash() => r'154ace4ce516e8060ac663d1f8fc48e8749bc03f';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouteRepositoryRef = AutoDisposeProviderRef<RouteRepository>;
String _$routeRemoteDataHash() => r'8242acc5b2a1dd7431f3163fd50c8a9b61befe5e';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouteRemoteDataRef = AutoDisposeProviderRef<RouteRemoteDataProvider>;
String _$routeListScrollControllerHash() =>
    r'6fc16846eaf3e77d38fe6665581e0ea04af04df8';

/// See also [routeListScrollController].
@ProviderFor(routeListScrollController)
final routeListScrollControllerProvider =
    AutoDisposeProvider<RouteListScrollController>.internal(
  routeListScrollController,
  name: r'routeListScrollControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$routeListScrollControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RouteListScrollControllerRef
    = AutoDisposeProviderRef<RouteListScrollController>;
String _$fetchUserStatsHash() => r'e937d035bb8a69aabec05251ba3ea7e180ba9416';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchUserStatsRef = AutoDisposeFutureProviderRef<UserStatsModel>;
String _$fetchAllRoutesHash() => r'10a3bd738ea509ca2213f0b291293c51adcbb74f';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchAllRoutesRef = AutoDisposeFutureProviderRef<List<RouteModel>>;
String _$fetchActiveRoutesHash() => r'8a0a55f67c7edd1855cfbbab387ae7cf78a37def';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchActiveRoutesRef = AutoDisposeFutureProviderRef<List<RouteModel>>;
String _$fetchRemovedRoutesHash() =>
    r'518098a00b19f65d46ca993ab014ad5f73cd7020';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchRemovedRoutesRef = AutoDisposeFutureProviderRef<List<RouteModel>>;
String _$fetchFilteredRoutesHash() =>
    r'5d26ed9814f00ef060e12e0636b660bb25ed9e4f';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchFilteredRoutesRef = AutoDisposeFutureProviderRef<RouteFilterModel>;
String _$fetchFilteredRemovedRoutesHash() =>
    r'ca76f54ffa7d182ef024388c745b0b76ea95e4a6';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchFilteredRemovedRoutesRef
    = AutoDisposeFutureProviderRef<RouteFilterModel>;
String _$fetchLocationFilteredRoutesHash() =>
    r'0f00e61ec9acbac47ced44c4e87ef09df186f867';

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

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FetchLocationFilteredRoutesRef
    = AutoDisposeFutureProviderRef<RouteFilterModel>;
String _$fetchRatingUserGraphHash() =>
    r'7a0c9a0754b6836cddc4d9de4fd92b279a631465';

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
    required bool isBoulder,
  }) {
    return FetchRatingUserGraphProvider(
      isBoulder: isBoulder,
    );
  }

  @override
  FetchRatingUserGraphProvider getProviderOverride(
    covariant FetchRatingUserGraphProvider provider,
  ) {
    return call(
      isBoulder: provider.isBoulder,
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
    required bool isBoulder,
  }) : this._internal(
          (ref) => fetchRatingUserGraph(
            ref as FetchRatingUserGraphRef,
            isBoulder: isBoulder,
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
          isBoulder: isBoulder,
        );

  FetchRatingUserGraphProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.isBoulder,
  }) : super.internal();

  final bool isBoulder;

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
        isBoulder: isBoulder,
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
        other.isBoulder == isBoulder;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isBoulder.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchRatingUserGraphRef
    on AutoDisposeFutureProviderRef<List<UserRatingModel>> {
  /// The parameter `isBoulder` of this provider.
  bool get isBoulder;
}

class _FetchRatingUserGraphProviderElement
    extends AutoDisposeFutureProviderElement<List<UserRatingModel>>
    with FetchRatingUserGraphRef {
  _FetchRatingUserGraphProviderElement(super.provider);

  @override
  bool get isBoulder => (origin as FetchRatingUserGraphProvider).isBoulder;
}

String _$includedClimbTypesHash() =>
    r'e2aa3fbdf5bce98230e91402bf7d519e803c203b';

/// See also [includedClimbTypes].
@ProviderFor(includedClimbTypes)
final includedClimbTypesProvider =
    AutoDisposeProvider<List<ClimbType>>.internal(
  includedClimbTypes,
  name: r'includedClimbTypesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$includedClimbTypesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IncludedClimbTypesRef = AutoDisposeProviderRef<List<ClimbType>>;
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
    r'8756edf4a0328b20992be6d373b1c5e37f1c3968';

/// See also [IncludeGraphDetails].
@ProviderFor(IncludeGraphDetails)
final includeGraphDetailsProvider =
    AutoDisposeNotifierProvider<IncludeGraphDetails, bool>.internal(
  IncludeGraphDetails.new,
  name: r'includeGraphDetailsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$includeGraphDetailsHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

typedef _$IncludeGraphDetails = AutoDisposeNotifier<bool>;
String _$includeTopRopeInGraphHash() =>
    r'de3e20a4149d3a9b7f27da005507aa66c663a2d5';

/// See also [IncludeTopRopeInGraph].
@ProviderFor(IncludeTopRopeInGraph)
final includeTopRopeInGraphProvider =
    AutoDisposeNotifierProvider<IncludeTopRopeInGraph, bool>.internal(
  IncludeTopRopeInGraph.new,
  name: r'includeTopRopeInGraphProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$includeTopRopeInGraphHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IncludeTopRopeInGraph = AutoDisposeNotifier<bool>;
String _$includeAutoBelayInGraphHash() =>
    r'a664dbf33970386a11acfa00f793bffb0d37504c';

/// See also [IncludeAutoBelayInGraph].
@ProviderFor(IncludeAutoBelayInGraph)
final includeAutoBelayInGraphProvider =
    AutoDisposeNotifierProvider<IncludeAutoBelayInGraph, bool>.internal(
  IncludeAutoBelayInGraph.new,
  name: r'includeAutoBelayInGraphProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$includeAutoBelayInGraphHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IncludeAutoBelayInGraph = AutoDisposeNotifier<bool>;
String _$includeLeadInGraphHash() =>
    r'4c7281b1504d55289183ca2aa3162dd231086387';

/// See also [IncludeLeadInGraph].
@ProviderFor(IncludeLeadInGraph)
final includeLeadInGraphProvider =
    AutoDisposeNotifierProvider<IncludeLeadInGraph, bool>.internal(
  IncludeLeadInGraph.new,
  name: r'includeLeadInGraphProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$includeLeadInGraphHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IncludeLeadInGraph = AutoDisposeNotifier<bool>;
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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
