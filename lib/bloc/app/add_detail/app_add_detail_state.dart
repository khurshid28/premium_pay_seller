abstract class AppAddDetailState {}

class AppAddDetailIntialState extends AppAddDetailState {}

class AppAddDetailWaitingState extends AppAddDetailState {}

class AppAddDetailSuccessState extends AppAddDetailState {
  dynamic data;
  AppAddDetailSuccessState({required this.data});
}

class AppAddDetailErrorState extends AppAddDetailState {
  String? title;
  String? message;
  int? statusCode;
  AppAddDetailErrorState(
      {required this.message, required this.title, required this.statusCode});
}
