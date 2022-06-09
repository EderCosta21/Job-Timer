part of 'login_controller.dart';

enum LoginStatus { inital, loading, failure }

class LoginState extends Equatable {
  final LoginStatus status;

  final String? errorMessage;

  const LoginState._({
    required this.status,
    this.errorMessage,
  });

  const LoginState.initial() : this._(status: LoginStatus.inital);

  @override
  List<Object?> get props => [status, errorMessage];

  LoginState copyWith({
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState._(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
