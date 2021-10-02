import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/enums/route_rating.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/presentation/route_color_icon.dart';

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
      isAttempted: widget.routeModel.userRouteModel?.isAttempted,
      isCompleted: widget.routeModel.userRouteModel?.isCompleted,
      isFavorited: widget.routeModel.userRouteModel?.isFavorited,
      rating: widget.routeModel.userRouteModel?.rating ?? RouteRating.noRating,
      notes: widget.routeModel.userRouteModel?.notes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Padding(
          padding: FreeBetaPadding.xxlAll,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Difficulty',
                        style: FreeBetaTextStyle.h4,
                      ),
                    ),
                    Text(widget.routeModel.difficulty),
                  ],
                ),
                SizedBox(height: FreeBetaSizes.l),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Type',
                        style: FreeBetaTextStyle.h4,
                      ),
                    ),
                    Text(widget.routeModel.climbType.displayName),
                  ],
                ),
                SizedBox(height: FreeBetaSizes.l),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Color',
                        style: FreeBetaTextStyle.h4,
                      ),
                    ),
                    RouteColorIcon.byColor(
                      routeColor: widget.routeModel.routeColor,
                    ),
                  ],
                ),
                Padding(
                  padding: FreeBetaPadding.lAll,
                  child: Divider(
                    height: 2,
                    thickness: 2,
                  ),
                ),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAttempted(),
                      _buildCompleted(),
                      _buildFavorite(),
                      SizedBox(height: FreeBetaSizes.m),
                      ..._buildNotes(),
                      SizedBox(height: FreeBetaSizes.m),
                      _buildRating(),
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
        ),
      ),
    );
  }

  Widget _buildAttempted() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Attempted',
            style: FreeBetaTextStyle.h4,
          ),
        ),
        Checkbox(
          activeColor: FreeBetaColors.blueDark,
          value: _formModel.isAttempted ?? false,
          onChanged: (value) {
            if (value != _formModel.isAttempted) {
              setState(() {
                _formModel.isAttempted = value;
                if (!(value ?? false)) {
                  _formModel.isCompleted = false;
                  _formModel.isFavorited = false;
                }
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildCompleted() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Completed',
            style: FreeBetaTextStyle.h4,
          ),
        ),
        Checkbox(
          activeColor: FreeBetaColors.blueDark,
          value: _formModel.isCompleted ?? false,
          onChanged: (value) {
            if (value != _formModel.isCompleted) {
              setState(() {
                _formModel.isCompleted = value;
              });
            }
          },
        ),
      ],
    );
  }

  Widget _buildFavorite() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Favorited',
            style: FreeBetaTextStyle.h4,
          ),
        ),
        Checkbox(
          activeColor: FreeBetaColors.blueDark,
          value: _formModel.isFavorited ?? false,
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
    );
  }

  List<Widget> _buildNotes() {
    return [
      Text(
        'Notes',
        style: FreeBetaTextStyle.h4,
      ),
      SizedBox(height: FreeBetaSizes.m),
      TextFormField(
        maxLength: 600,
        maxLines: 6,
        style: FreeBetaTextStyle.body5,
        initialValue: _formModel.notes,
        onChanged: (value) {
          if (value != _formModel.notes) {
            setState(() {
              _formModel.notes = value;
            });
          }
        },
        decoration: InputDecoration(
          contentPadding: FreeBetaPadding.mlAll,
          hintText: 'Enter notes here:\n\nex. flag your left foot',
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: FreeBetaColors.blueDark,
              width: 2.0,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: FreeBetaColors.blueDark,
              width: 2.0,
            ),
          ),
        ),
      ),
    ];
  }

  Widget _buildRating() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            'Rating',
            style: FreeBetaTextStyle.h4,
          ),
        ),
        Radio<RouteRating>(
          toggleable: true,
          value: RouteRating.one,
          groupValue: _formModel.rating,
          onChanged: (value) {
            if (value != _formModel.rating) {
              setState(() {
                _formModel.rating = value ?? RouteRating.noRating;
              });
            }
          },
        ),
        Radio<RouteRating>(
          toggleable: true,
          value: RouteRating.two,
          groupValue: _formModel.rating,
          onChanged: (value) {
            if (value != _formModel.rating) {
              setState(() {
                _formModel.rating = value ?? RouteRating.noRating;
              });
            }
          },
        ),
        Radio<RouteRating>(
          toggleable: true,
          value: RouteRating.three,
          groupValue: _formModel.rating,
          onChanged: (value) {
            if (value != _formModel.rating) {
              setState(() {
                _formModel.rating = value ?? RouteRating.noRating;
              });
            }
          },
        ),
      ],
    );
  }

  void _onSave() {
    log('Saved!');
    log(_formModel.toString());
  }
}
