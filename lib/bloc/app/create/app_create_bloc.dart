import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/bloc/app/create/app_create_state.dart';
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppCreateBloc extends Cubit<AppCreateState> {
  DioClient dioClient = DioClient();
  AppCreateBloc() : super(AppCreateIntialState());

  Future create({
     required String? passport,

  }) async {
    emit(AppCreateWaitingState());
    dio.Response response =
        await dioClient.post("${Endpoints.app}/create", data: {
       "passport": passport,
    });

    if (response.statusCode == 201) {
      emit(AppCreateSuccessState(data: response.data));
    } else {
      emit(
        AppCreateErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }
}
