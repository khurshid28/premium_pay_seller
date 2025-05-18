import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/core/network/dio_client.dart';
import '../../core/endpoints/endpoints.dart';
import '../../export_files.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  DioClient dioClient = DioClient();
  LoginBloc() : super(LoginIntialState());

  Future postData({
    required String login,
    required String password,
  }) async {
    emit(LoginWaitingState());
    dio.Response response = await dioClient.post(
      Endpoints.login,
      data: {
        "login": login,
        "password": password,
      },
    );
  

    if (response.statusCode == 200) {
      emit(LoginSuccessState(data: response.data));
    } else {
      emit(
        LoginErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }
}
