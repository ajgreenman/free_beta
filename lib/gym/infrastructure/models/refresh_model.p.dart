import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/gym/infrastructure/models/refresh_model.dart';

extension RefreshFormModelExtensions on RefreshFormModel {
  Map<String, dynamic> toJson() {
    return {
      'date': Timestamp.fromDate(date!),
      'sections': sections
          .map(
            (section) => {
              'wallLocation': section.wallLocation.name,
              'wallSection': section.wallSection,
            },
          )
          .toList(),
    };
  }
}
