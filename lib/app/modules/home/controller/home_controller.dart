import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/entities/project_status.dart';
import 'package:job_timer/app/services/projects/project_service.dart';
import 'package:job_timer/app/view_models/project_model.dart';

part 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProjectService _projectService;

  HomeController({required ProjectService projectService})
      : _projectService = projectService,
        super(HomeState.inital());

  Future<void> loadProjects() async {
    try {
      final projects = await _projectService.findByStatus(state.projectFilter);
      emit(state.copyWith(status: HomeStatus.complete, projects: projects));
    } catch (e, s) {
      log('Erro ao buscar os projetos', error: e, stackTrace: s);
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }

  Future<void> filter(ProjectStatus status) async {
    //deixar o status como carregando
    emit(
      state.copyWith(
        status: HomeStatus.loading,
        projects: [],
      ),
    );
// buscar novemente com status desejado
    final projectsFilter = await _projectService.findByStatus(status);

    //deixar o status como completo, carregar os projetos e alterar o filtro;
    emit(
      state.copyWith(
          status: HomeStatus.complete,
          projects: projectsFilter,
          projectFilter: status),
    );
  }

  void updateList() => filter(state.projectFilter);
}
