import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_scoring_state.dart';


class AppScoringBloc extends Cubit<AppScoringState> {
  DioClient dioClient = DioClient();
  AppScoringBloc() : super(AppScoringIntialState());

  Future post({
    required int id,
    required int dayOfPayment,
  
  }) async {
    emit(AppScoringWaitingState());
    dio.Response response =
        await dioClient.post("${Endpoints.app}/scoring", data: {
      "id": id,
      "dayOfPayment": dayOfPayment,
  
    });

    if (response.statusCode == 200) {
      emit(AppScoringSuccessState(data: response.data));
    } else {
      emit(
        AppScoringErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }
}
