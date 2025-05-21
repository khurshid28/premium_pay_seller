abstract class AppAddProductState {}

class AppAddProductIntialState extends AppAddProductState {}

class AppAddProductWaitingState extends AppAddProductState {}

class AppAddProductSuccessState extends AppAddProductState {
  dynamic data;
  AppAddProductSuccessState({required this.data});
}

class AppAddProductErrorState extends AppAddProductState {
  String? title;
  String? message;
  int? statusCode;
  AppAddProductErrorState(
      {required this.message, required this.title, required this.statusCode});
}
