abstract class VersionState {}

class VersionIntialState extends VersionState {}

class VersionWaitingState extends VersionState {}

class VersionSuccessState extends VersionState {
  String version;
  VersionSuccessState({required this.version});
}

class VersionErrorState extends VersionState {
  String? title;
  String? message;
  int? statusCode;
  VersionErrorState(
      {required this.message, required this.title, required this.statusCode});
}
