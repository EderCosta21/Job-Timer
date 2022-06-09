import 'package:isar/isar.dart';
import 'package:job_timer/app/entities/project.dart';
import 'package:path_provider/path_provider.dart';

import '../../entities/project_task.dart';
import './database.dart';

Isar? _databaseInstance;

class DatabaseImpl implements Database {
  @override
  Future<Isar> openConnection() async {
    if (_databaseInstance == null) {
      final dir = await getApplicationSupportDirectory();
      _databaseInstance = await Isar.open(
        schemas: [ProjectTaskSchema, ProjectSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return _databaseInstance!;
  }
}
