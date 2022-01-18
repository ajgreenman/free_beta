import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:free_beta/app/enums/enums.dart';
import 'package:free_beta/app/theme.dart';
import 'package:free_beta/routes/infrastructure/models/route_form_model.dart';
import 'package:free_beta/routes/infrastructure/models/route_model.dart';
import 'package:free_beta/routes/infrastructure/route_api.dart';
import 'package:free_beta/routes/presentation/route_color_icon.dart';
import 'package:free_beta/user/user_route_model.dart';
import 'package:intl/intl.dart';

class RouteDetailScreen extends ConsumerStatefulWidget {
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

class _RouteDetailScreenState extends ConsumerState<RouteDetailScreen> {
  late RouteFormModel _formModel;
  bool dirtyForm = false;

  @override
  void initState() {
    super.initState();
    _formModel = RouteFormModel(
      isAttempted: widget.routeModel.userRouteModel?.isAttempted ?? false,
      isCompleted: widget.routeModel.userRouteModel?.isCompleted ?? false,
      isFavorited: widget.routeModel.userRouteModel?.isFavorited ?? false,
      rating: widget.routeModel.userRouteModel?.rating,
      notes: widget.routeModel.userRouteModel?.notes,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: _onBack,
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
                ..._buildRouteInfo(),
                Padding(
                  padding: FreeBetaPadding.lAll,
                  child: Divider(
                    height: 2,
                    thickness: 2,
                  ),
                ),
                ..._buildImages(),
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

  List<Widget> _buildImages() {
    if (widget.routeModel.images.isEmpty) return [Text('No available images')];

    return widget.routeModel.images
        .map(
          (image) => ClipRRect(
            child: Image.network(image),
          ),
        )
        .toList();
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
          value: _formModel.isAttempted,
          onChanged: (value) {
            if (value == null || value == _formModel.isAttempted) return;
            dirtyForm = true;

            setState(() {
              _formModel.isAttempted = value;
              if (!value) {
                _formModel.isCompleted = false;
                _formModel.isFavorited = false;
              }
            });
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
          value: _formModel.isCompleted,
          onChanged: (value) {
            if (value == null || value == _formModel.isCompleted) return;
            dirtyForm = true;

            setState(() {
              _formModel.isCompleted = value;
              if (value) {
                _formModel.isAttempted = true;
              }
            });
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
          value: _formModel.isFavorited,
          onChanged: (value) {
            if (value == null || value == _formModel.isFavorited) return;
            dirtyForm = true;

            setState(() {
              _formModel.isFavorited = value;
              if (value) {
                _formModel.isAttempted = true;
              }
            });
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
            dirtyForm = true;
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
              dirtyForm = true;
              setState(() {
                _formModel.rating = value;
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
              dirtyForm = true;
              setState(() {
                _formModel.rating = value;
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
              dirtyForm = true;
              setState(() {
                _formModel.rating = value;
              });
            }
          },
        ),
      ],
    );
  }

  void _onBack() async {
    if (!dirtyForm) {
      Navigator.of(context).pop();
      return;
    }

    await showDialog(
      context: context,
      builder: (_) => _AreYouSureDialog(),
    );
  }

  Future<void> _onSave() async {
    await ref.read(routeApiProvider).saveRoute(
          UserRouteModel(
            routeId: widget.routeModel.id,
            isAttempted: _formModel.isAttempted,
            isCompleted: _formModel.isCompleted,
            isFavorited: _formModel.isFavorited,
            rating: _formModel.rating,
            notes: _formModel.notes,
          ),
        );
    ref.refresh(fetchRoutesProvider);

    dirtyForm = false;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            Text('Saved!'),
            Spacer(),
            Icon(Icons.check),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRouteInfo() {
    return [
      _buildRow(
        'Name',
        Text(widget.routeModel.name),
      ),
      SizedBox(height: FreeBetaSizes.l),
      _buildRow(
        'Difficulty',
        Text(widget.routeModel.difficulty),
      ),
      SizedBox(height: FreeBetaSizes.l),
      _buildRow(
        'Type',
        Text(widget.routeModel.climbType.displayName),
      ),
      SizedBox(height: FreeBetaSizes.l),
      _buildRow(
        'Color',
        RouteColorIcon.byColor(
          routeColor: widget.routeModel.routeColor,
        ),
      ),
      SizedBox(height: FreeBetaSizes.l),
      _buildRow(
        'Created',
        Text(DateFormat('MM/dd').format(widget.routeModel.creationDate)),
      ),
      if (widget.routeModel.removalDate != null) ...[
        SizedBox(height: FreeBetaSizes.l),
        _buildRow(
          'Removed',
          Text(DateFormat('MM/dd').format(widget.routeModel.removalDate!)),
        ),
      ]
    ];
  }

  Widget _buildRow(String label, Widget value) => Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: FreeBetaTextStyle.h4,
            ),
          ),
          value,
        ],
      );
}

class _AreYouSureDialog extends StatelessWidget {
  const _AreYouSureDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content:
          Text("You have unsaved changes, are you sure you want to leave?"),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Leave'),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
