import 'package:free_beta/class/infrastructure/class_repository.dart';
import 'package:free_beta/class/infrastructure/models/class_model.dart';

class ClassApi {
  final ClassRepository classRepository;

  ClassApi({required this.classRepository});

  Future<List<ClassModel>> getClassSchedule() async {
    return classRepository.getClassSchedule();
  }
}
