abstract class LoginState {}

class LoginIntialState extends LoginState {}

class LoginWaitingState extends LoginState {}

class LoginSuccessState extends LoginState {
  dynamic data;
  LoginSuccessState({required this.data});
}

class LoginErrorState extends LoginState {
  String? title;
  String? message;
  int? statusCode;
  LoginErrorState(
      {required this.message, required this.title, required this.statusCode});
}
