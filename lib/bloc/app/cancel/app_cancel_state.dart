abstract class AppCancelState {}

class AppCancelIntialState extends AppCancelState {}

class AppCancelWaitingState extends AppCancelState {}

class AppCancelSuccessState extends AppCancelState {
  dynamic data;
  AppCancelSuccessState({required this.data});
}

class AppCancelErrorState extends AppCancelState {
  String? title;
  String? message;
  int? statusCode;
  AppCancelErrorState(
      {required this.message, required this.title, required this.statusCode});
}
