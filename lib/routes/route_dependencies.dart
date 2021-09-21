import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_beta/routes/cubit/route_cubit.dart';
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
        ProxyProvider<RouteRemoteDataProvider, RouteRepository>(
          update: (_, routeRemoteDataProvider, __) => RouteRepository(
            routeRemoteDataProvider: routeRemoteDataProvider,
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
