abstract class AppSelectState {}

class AppSelectIntialState extends AppSelectState {}

class AppSelectWaitingState extends AppSelectState {}

class AppSelectSuccessState extends AppSelectState {
  dynamic data;
  AppSelectSuccessState({required this.data});
}

class AppSelectErrorState extends AppSelectState {
  String? title;
  String? message;
  int? statusCode;
  AppSelectErrorState(
      {required this.message, required this.title, required this.statusCode});
}
