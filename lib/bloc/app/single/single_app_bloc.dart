import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'single_app_state.dart';

class SingleAppBloc extends Cubit<SingleAppState> {
  DioClient dioClient = DioClient();
  SingleAppBloc() : super(SingleAppIntialState());

  Future get({
    required int id
  }) async {
    emit(SingleAppWaitingState());
    dio.Response response = await dioClient.get("${Endpoints.app}/$id");

    if (response.statusCode == 200) {
      emit(SingleAppSuccessState(data: response.data));
    } else {
      emit(
        SingleAppErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }

 


}
