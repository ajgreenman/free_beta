import 'package:equatable/equatable.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:remote_state/remote_state.dart';

class RouteState extends Equatable {
  final RemoteState<List<RouteModel>> routes;

  RouteState({
    required this.routes,
  });

  RouteState.initial() : routes = RemoteState.initial();

  RouteState copyWith({
    RemoteState<List<RouteModel>>? routes,
  }) {
    return RouteState(
      routes: routes ?? this.routes,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [routes];
}
