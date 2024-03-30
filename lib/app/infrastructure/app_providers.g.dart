// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mediaApiHash() => r'2eef553ccf21bf9a4cf93e756cdbee43dd60ddc1';

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

typedef MediaApiRef = AutoDisposeProviderRef<MediaApi>;
String _$emailApiHash() => r'cf5e1523afb6512710ee6a4bb1bcd3b707ef1a8e';

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

typedef EmailApiRef = AutoDisposeProviderRef<EmailApi>;
String _$crashlyticsApiHash() => r'6366ff27fa3a8ed4007bcb0b6623b027df841378';

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

typedef CrashlyticsApiRef = AutoDisposeProviderRef<CrashlyticsApi>;
String _$messagingApiHash() => r'6b460e5dc3d976a32212a7e6c72b18ac404b711c';

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

typedef MessagingApiRef = AutoDisposeProviderRef<MessagingApi>;
String _$cacheManagerHash() => r'f5ac2ca7279ca01ff12f56ddba40c3f5e012f9ba';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
