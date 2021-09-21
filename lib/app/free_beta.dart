import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:free_beta/routes/presentation/route_card.dart';
import 'package:free_beta/routes/cubit/route_cubit.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/cubit/route_state.dart';

class FreeBeta extends StatelessWidget {
  const FreeBeta({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('free-beta-home'),
      appBar: AppBar(
        title: Text('Free Beta'),
      ),
      body: BlocBuilder<RouteCubit, RouteState>(
        builder: (_, state) => state.routes.maybeWhen(
          success: (routes) => _onSuccess(routes),
          error: (_, __) => _onError(),
          loading: () => CircularProgressIndicator(),
          orElse: () => SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _onSuccess(List<RouteModel> routes) {
    return ListView.separated(
      itemBuilder: (_, index) {
        return RouteCard(route: routes[index]);
      },
      separatorBuilder: (_, __) {
        return Divider(height: 1, thickness: 1);
      },
      itemCount: routes.length,
    );
  }

  Widget _onError() {
    return Text('Sorry, an error occured.');
  }
}
