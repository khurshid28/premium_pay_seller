abstract class AppScoringState {}

class AppScoringIntialState extends AppScoringState {}

class AppScoringWaitingState extends AppScoringState {}

class AppScoringSuccessState extends AppScoringState {
  dynamic data;
  AppScoringSuccessState({required this.data});
}

class AppScoringErrorState extends AppScoringState {
  String? title;
  String? message;
  int? statusCode;
  AppScoringErrorState(
      {required this.message, required this.title, required this.statusCode});
}
