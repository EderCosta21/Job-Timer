import 'dart:developer' as developer;

import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:bloc/bloc.dart';

import 'package:job_timer/app/services/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';
import 'package:job_timer/app/view_models/project_task_model.dart';

part 'task_state.dart';

class TaskController extends Cubit<TaskStatus> {
  late final ProjectModel _projectModel;
  final ProjectService _projectService;

  TaskController({
    required ProjectService projectService,
  })  : _projectService = projectService,
        super(TaskStatus.initial);

  void setProject(ProjectModel projectModel) => _projectModel = projectModel;

  Future<void> register(String name, int duration) async {
    print('task ${_projectModel.estimative}');

    final total = _projectModel.estimative;
    final totalTask = _projectModel.tasks.fold<int>(0, (totalValue, task) {
      return totalValue += task.duration;
    });
    final _restante = (total - totalTask);
    final task = ProjectTaskModel(
      name: name,
      duration: duration,
    );

    if (_restante <= 0 || _restante < task.duration) {
      emit(TaskStatus.failure);
      AsukaSnackbar.alert('Limite do projeto excedido').show();
    } else {
      try {
        emit(TaskStatus.loading);

        await _projectService.addTask(_projectModel.id!, task);
        emit(TaskStatus.success);
      } catch (e, s) {
        developer.log('Erro ao salvar a task', error: e, stackTrace: s);
        emit(TaskStatus.failure);
      }
    }
  }
}
