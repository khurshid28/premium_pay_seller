abstract class AppFinishState {}

class AppFinishIntialState extends AppFinishState {}

class AppFinishWaitingState extends AppFinishState {}

class AppFinishSuccessState extends AppFinishState {
  dynamic data;
  AppFinishSuccessState({required this.data});
}

class AppFinishErrorState extends AppFinishState {
  String? title;
  String? message;
  int? statusCode;
  AppFinishErrorState(
      {required this.message, required this.title, required this.statusCode});
}
