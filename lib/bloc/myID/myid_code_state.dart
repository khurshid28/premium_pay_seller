abstract class MyidCodeState {}

class MyidCodeIntialState extends MyidCodeState {}

class MyidCodeWaitingState extends MyidCodeState {}

class MyidCodeSuccessState extends MyidCodeState {
  dynamic data;
  MyidCodeSuccessState({required this.data});
}

class MyidCodeErrorState extends MyidCodeState {
  String? title;
  String? message;
  int? statusCode;
  MyidCodeErrorState(
      {required this.message, required this.title, required this.statusCode});
}
