import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_beta/routes/cubit/route_cubit.dart';
import 'package:free_beta/routes/infrastructure/route_local_data_provider.dart';
import 'package:free_beta/routes/infrastructure/route_remote_data_provider.dart';
import 'package:free_beta/routes/infrastructure/route_repository.dart';
import 'package:free_beta/routes/infrastructure/route_service_facade.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class RouteDomain {
  static List<SingleChildWidget> get dependencies => [
        Provider<RouteRemoteDataProvider>.value(
          value: RouteRemoteDataProvider(),
        ),
        Provider<RouteLocalDataProvider>.value(
          value: RouteLocalDataProvider(),
        ),
        ProxyProvider2<RouteRemoteDataProvider, RouteLocalDataProvider,
            RouteRepository>(
          update: (
            _,
            routeRemoteDataProvider,
            routeLocalDataProvider,
            __,
          ) =>
              RouteRepository(
            routeRemoteDataProvider: routeRemoteDataProvider,
            routeLocalDataProvider: routeLocalDataProvider,
          ),
        ),
        ProxyProvider<RouteRepository, RouteServiceFacade>(
          update: (_, routeRepository, __) => RouteServiceFacade(
            routeRepository: routeRepository,
          ),
        ),
        BlocProvider(
          create: (context) => RouteCubit(
            routeServiceFacade: context.read<RouteServiceFacade>(),
          ),
        ),
      ];
}
