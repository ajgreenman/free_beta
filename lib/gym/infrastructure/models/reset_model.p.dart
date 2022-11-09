import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:free_beta/gym/infrastructure/models/reset_model.dart';

extension ResetFormModelExtensions on ResetFormModel {
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
