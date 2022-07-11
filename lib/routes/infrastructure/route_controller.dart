import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';

class RouteController extends StateNotifier<AsyncValue<List<RouteModel>>> {
  RouteController({required this.routeApi}) : super(const AsyncValue.data([]));
  final RouteApi routeApi;
}

final routeControllerProvider =
    StateNotifierProvider.autoDispose<RouteController, AsyncValue>((ref) {
  final routeApi = ref.watch(routeApiProvider);
  return RouteController(routeApi: routeApi);
});
