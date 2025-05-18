abstract class SingleAppState {}

class SingleAppIntialState extends SingleAppState {}

class SingleAppWaitingState extends SingleAppState {}

class SingleAppSuccessState extends SingleAppState {
  dynamic data;
  SingleAppSuccessState({required this.data});
}

class SingleAppErrorState extends SingleAppState {
  String? title;
  String? message;
  int? statusCode;
  SingleAppErrorState(
      {required this.message, required this.title, required this.statusCode});
}
