import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/bloc/app/finish/app_finish_state.dart';
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppFinishBloc extends Cubit<AppFinishState> {
  DioClient dioClient = DioClient();
  AppFinishBloc() : super(AppFinishIntialState());

  Future finish({
    required int id,
  }) async {
    emit(AppFinishWaitingState());
    dio.Response response =
        await dioClient.put("${Endpoints.app}/finish", data: {
      "id": id,
  
    });

    if (response.statusCode == 200) {
      emit(AppFinishSuccessState(data: response.data));
    } else {
      emit(
        AppFinishErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }
}
