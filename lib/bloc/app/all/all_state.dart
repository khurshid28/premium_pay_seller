abstract class AllAppState {}

class AllAppIntialState extends AllAppState {}

class AllAppWaitingState extends AllAppState {}

class AllAppSuccessState extends AllAppState {
  List data;
  AllAppSuccessState({required this.data});
}

class AllAppErrorState extends AllAppState {
  String? title;
  String? message;
  int? statusCode;
  AllAppErrorState(
      {required this.message, required this.title, required this.statusCode});
}
