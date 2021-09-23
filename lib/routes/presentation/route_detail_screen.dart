import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';

class RouteDetailScreen extends StatefulWidget {
  static Route<dynamic> route(RouteModel routeModel) {
    return MaterialPageRoute<dynamic>(builder: (context) {
      return RouteDetailScreen(routeModel: routeModel);
    });
  }

  final RouteModel routeModel;

  const RouteDetailScreen({Key? key, required this.routeModel})
      : super(key: key);

  @override
  _RouteDetailScreenState createState() => _RouteDetailScreenState();
}

class _RouteDetailScreenState extends State<RouteDetailScreen> {
  late RouteFormModel _formModel;

  @override
  void initState() {
    super.initState();
    _formModel = RouteFormModel(
      isAttempted: widget.routeModel.userRouteModel.isAttempted,
      isCompleted: widget.routeModel.userRouteModel.isCompleted,
      isFavorited: widget.routeModel.userRouteModel.isFavorited,
      rating: widget.routeModel.userRouteModel.rating,
      notes: widget.routeModel.userRouteModel.notes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(
            Icons.keyboard_arrow_left,
            size: FreeBetaSizes.xxl,
            color: FreeBetaColors.white,
          ),
        ),
      ),
      body: Padding(
        padding: FreeBetaPadding.xxlAll,
        child: Column(
          children: [
            Text('Route'),
            Form(
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: Text('Attempted?')),
                      Checkbox(
                        activeColor: FreeBetaColors.blueDark,
                        value: _formModel.isAttempted,
                        onChanged: (value) {
                          if (value != _formModel.isAttempted) {
                            setState(() {
                              _formModel.isAttempted = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('Completed?')),
                      Checkbox(
                        activeColor: FreeBetaColors.blueDark,
                        value: _formModel.isCompleted,
                        onChanged: (value) {
                          if (value != _formModel.isCompleted) {
                            setState(() {
                              _formModel.isCompleted = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('Favorited?')),
                      Checkbox(
                        activeColor: FreeBetaColors.blueDark,
                        value: _formModel.isFavorited,
                        onChanged: (value) {
                          log(value.toString());
                          if (value != _formModel.isFavorited) {
                            setState(() {
                              _formModel.isFavorited = value;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: Text('Notes')),
                      Expanded(
                        child: TextFormField(
                          initialValue: _formModel.notes,
                          onChanged: (value) {
                            if (value != _formModel.notes) {
                              setState(() {
                                _formModel.notes = value;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _onSave,
                    child: Text('Save'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onSave() {
    log('Saved!');
    log(_formModel.toString());
  }
}
