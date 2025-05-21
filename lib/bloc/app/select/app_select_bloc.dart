import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/bloc/app/select/app_select_state.dart';
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppSelectBloc extends Cubit<AppSelectState> {
  DioClient dioClient = DioClient();
  AppSelectBloc() : super(AppSelectIntialState());

  Future select({
    required int id,
    required String expired_month,
  }) async {
    emit(AppSelectWaitingState());
    dio.Response response =
        await dioClient.put("${Endpoints.app}/select", data: {
      "id": id,
      "expired_month": expired_month,
  
    });

    if (response.statusCode == 200) {
      emit(AppSelectSuccessState(data: response.data));
    } else {
      emit(
        AppSelectErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }
}
