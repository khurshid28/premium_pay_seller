import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/bloc/app/cancel/app_cancel_state.dart';
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppCancelBloc extends Cubit<AppCancelState> {
  DioClient dioClient = DioClient();
  AppCancelBloc() : super(AppCancelIntialState());

  Future cancel({
    required int id,
    required String canceled_reason,
  }) async {
    emit(AppCancelWaitingState());
    dio.Response response =
        await dioClient.put("${Endpoints.app}/cancel", data: {
      "id": id,
      "canceled_reason": canceled_reason,
    });

    if (response.statusCode == 200) {
      emit(AppCancelSuccessState(data: response.data));
    } else {
      emit(
        AppCancelErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }
}
