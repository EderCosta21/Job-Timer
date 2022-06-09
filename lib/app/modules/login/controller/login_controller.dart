// ignore_for_file: avoid_print, unused_field

import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_timer/app/services/auth/auth_service.dart';

part 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthService _authService;

  LoginController({required AuthService authService})
      : _authService = authService,
        super(const LoginState.initial());

  Future<void> singIn() async {
    //alterar um novo estado
    try {
      emit(state.copyWith(status: LoginStatus.loading));
      await _authService.SignIn();
    } catch (e, s) {
      log('Erro ao realizar o login', error: e, stackTrace: s);
      emit(state.copyWith(
          status: LoginStatus.failure,
          errorMessage: 'Erro ao realizar o login'));
    }
  }
}
