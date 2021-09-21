import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_beta/routes/infrastructure/route_service_facade.dart';
import 'package:free_beta/routes/cubit/route_state.dart';
import 'package:remote_state/remote_state.dart';

class RouteCubit extends Cubit<RouteState> {
  RouteServiceFacade routeServiceFacade;

  RouteCubit({
    required this.routeServiceFacade,
  }) : super(RouteState.initial());

  Future<void> getRoutes() async {
    emit(state.copyWith(routes: RemoteState.loading()));

    var routes = await routeServiceFacade.getRoutes();

    emit(state.copyWith(routes: routes));
  }
}
