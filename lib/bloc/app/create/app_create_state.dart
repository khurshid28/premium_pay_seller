abstract class AppCreateState {}

class AppCreateIntialState extends AppCreateState {}

class AppCreateWaitingState extends AppCreateState {}

class AppCreateSuccessState extends AppCreateState {
  dynamic data;
  AppCreateSuccessState({required this.data});
}

class AppCreateErrorState extends AppCreateState {
  String? title;
  String? message;
  int? statusCode;
  AppCreateErrorState(
      {required this.message, required this.title, required this.statusCode});
}
