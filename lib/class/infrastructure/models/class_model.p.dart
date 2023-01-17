import 'package:free_beta/class/infrastructure/models/class_model.dart';

extension ClassModelExtensions on ClassModel {
  Map<String, dynamic> toJson() => {
        'name': name,
        'classType': classType.name,
        'instructor': instructor,
        'day': day.name,
        'hour': hour,
        'minute': minute,
      };
}
