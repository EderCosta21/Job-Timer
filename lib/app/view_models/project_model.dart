import 'package:job_timer/app/entities/project.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/view_models/project_task_model.dart';

class ProjectModel {
  final int? id;
  final String name;
  final int estimative;
  final ProjectStatus status;
  final List<ProjectTaskModel> tasks;
  ProjectModel({
    this.id,
    required this.name,
    required this.estimative,
    required this.status,
    required this.tasks,
  });

  factory ProjectModel.fromEntity(Project project) {
    //carregar todas as tasks para retorno
    project.tasks.loadSync();

    return ProjectModel(
      id: project.id,
      name: project.name,
      estimative: project.estimate,
      status: project.status,
      tasks: project.tasks.map(ProjectTaskModel.fromEntity).toList(),
    );
  }
}
