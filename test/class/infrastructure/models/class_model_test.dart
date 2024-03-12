import 'package:flutter_test/flutter_test.dart';
import 'package:free_beta/app/enums/class_type.dart';
import 'package:free_beta/app/enums/day.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';

void main() {
  group('ClassModel', () {
    test('fromFirebase parses json into a model', () {
      var json = {
        'name': '',
        'notes': '',
        'classType': ClassType.yoga.name,
        'instructor': '',
        'day': Day.sunday.name,
        'hour': 0,
        'minute': 0,
        'isDeleted': false,
      };

      var classModel = ClassModel.fromFirebase('', json);

      expect(classModel.name, '');
      expect(classModel.day, Day.sunday);
      expect(classModel.classType, ClassType.yoga);
      expect(classModel.hour, 0);
      expect(classModel.minute, 0);
    });

    test('compareTo sorts classes correctly', () {
      classes.sort((a, b) => b.compareTo(a));

      expect(classes[0], class3);
      expect(classes[1], class4);
      expect(classes[2], class2);
      expect(classes[3], class1);
    });
  });

  group('ClassFormModel', () {
    test('fromClassModel creates ClassFormModel correctly', () {
      var classFormModel = ClassFormModel.fromClassModel(class1);

      expect(classFormModel.name, class1.name);
      expect(classFormModel.day, class1.day);
      expect(classFormModel.classType, class1.classType);
      expect(classFormModel.hour, class1.hour);
      expect(classFormModel.minute, class1.minute);
    });

    test('toString parses correctly', () {
      var classFormModel = ClassFormModel.fromClassModel(class1);

      var string = classFormModel.toString();

      expect(string,
          'ClassFormModel(name: ${classFormModel.name}, notes: ${classFormModel.notes}, classType: ${classFormModel.classType}, instructor: ${classFormModel.instructor}, day: ${classFormModel.day}, hour: ${classFormModel.hour}, minute: ${classFormModel.minute})');
    });
  });
}

var classes = [class1, class2, class3, class4];

var class1 = ClassModel(
  id: '',
  name: '',
  classType: ClassType.yoga,
  instructor: '',
  day: Day.tuesday,
  hour: 0,
  minute: 0,
  notes: 'note',
);

var class2 = ClassModel(
  id: '',
  name: '',
  classType: ClassType.yoga,
  instructor: '',
  day: Day.sunday,
  hour: 10,
  minute: 0,
  notes: 'note',
);

var class3 = ClassModel(
  id: '',
  name: '',
  classType: ClassType.yoga,
  instructor: '',
  day: Day.sunday,
  hour: 0,
  minute: 0,
  notes: 'note',
);

var class4 = ClassModel(
  id: '',
  name: '',
  classType: ClassType.yoga,
  instructor: '',
  day: Day.sunday,
  hour: 0,
  minute: 20,
  notes: 'note',
);
