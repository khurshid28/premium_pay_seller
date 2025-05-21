import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'myid_code_state.dart';

class MyidCodeBloc extends Cubit<MyidCodeState> {
  DioClient dioClient = DioClient();
  MyidCodeBloc() : super(MyidCodeIntialState());

  Future sendCode({
    required String? code,
     required String? passport,
     required double comparison_value,

  }) async {
    emit(MyidCodeWaitingState());
    dio.Response response =
        await dioClient.post("${Endpoints.myid}/code", data: {
      "code": code,
       "passport": passport,
       "comparison_value" :comparison_value
    });

    if (response.statusCode == 200) {
      emit(MyidCodeSuccessState(data: response.data));
    } else {
      emit(
        MyidCodeErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }
}
