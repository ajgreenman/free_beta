// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mediaApiHash() => r'29dbdae2a721c79ba25adce83da4695f2ee55513';

/// See also [mediaApi].
@ProviderFor(mediaApi)
final mediaApiProvider = AutoDisposeProvider<MediaApi>.internal(
  mediaApi,
  name: r'mediaApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$mediaApiHash,
  dependencies: <ProviderOrFamily>[crashlyticsApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    crashlyticsApiProvider,
    ...?crashlyticsApiProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MediaApiRef = AutoDisposeProviderRef<MediaApi>;
String _$emailApiHash() => r'db7a8e772440b5d4da432b7c13040d79f5e5e69c';

/// See also [emailApi].
@ProviderFor(emailApi)
final emailApiProvider = AutoDisposeProvider<EmailApi>.internal(
  emailApi,
  name: r'emailApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$emailApiHash,
  dependencies: <ProviderOrFamily>[crashlyticsApiProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    crashlyticsApiProvider,
    ...?crashlyticsApiProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EmailApiRef = AutoDisposeProviderRef<EmailApi>;
String _$crashlyticsApiHash() => r'69047fdb278febb3e418b700ac7224c515c90e95';

/// See also [crashlyticsApi].
@ProviderFor(crashlyticsApi)
final crashlyticsApiProvider = AutoDisposeProvider<CrashlyticsApi>.internal(
  crashlyticsApi,
  name: r'crashlyticsApiProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$crashlyticsApiHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CrashlyticsApiRef = AutoDisposeProviderRef<CrashlyticsApi>;
String _$messagingApiHash() => r'3ba1d7aa1331f295c7c21e33f26a599797a82140';

/// See also [messagingApi].
@ProviderFor(messagingApi)
final messagingApiProvider = AutoDisposeProvider<MessagingApi>.internal(
  messagingApi,
  name: r'messagingApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$messagingApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MessagingApiRef = AutoDisposeProviderRef<MessagingApi>;
String _$cacheManagerHash() => r'aceabf7ce09ee4387ce2c7f5c8c458b260b7bb1b';

/// See also [cacheManager].
@ProviderFor(cacheManager)
final cacheManagerProvider = AutoDisposeProvider<BaseCacheManager>.internal(
  cacheManager,
  name: r'cacheManagerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$cacheManagerHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CacheManagerRef = AutoDisposeProviderRef<BaseCacheManager>;
String _$bottomNavHash() => r'1d7bed45d76287bac36ac5a76ab8cfd0356174b0';

/// See also [BottomNav].
@ProviderFor(BottomNav)
final bottomNavProvider = AutoDisposeNotifierProvider<BottomNav, int>.internal(
  BottomNav.new,
  name: r'bottomNavProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$bottomNavHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BottomNav = AutoDisposeNotifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
