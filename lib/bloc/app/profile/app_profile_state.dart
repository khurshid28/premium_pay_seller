abstract class AppProfileState {}

class AppProfileIntialState extends AppProfileState {}

class AppProfileWaitingState extends AppProfileState {}

class AppProfileSuccessState extends AppProfileState {
  dynamic data;
  AppProfileSuccessState({required this.data});
}

class AppProfileErrorState extends AppProfileState {
  String? title;
  String? message;
  int? statusCode;
  AppProfileErrorState(
      {required this.message, required this.title, required this.statusCode});
}
