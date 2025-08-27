import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_add_detail_state.dart';

class AppAddDetailBloc extends Cubit<AppAddDetailState> {
  DioClient dioClient = DioClient();
  AppAddDetailBloc() : super(AppAddDetailIntialState());

  Future add({
    required int id,
    required String phone,
    required String phone2,
     required String? relation,
      required String? relationName,
  }) async {
    emit(AppAddDetailWaitingState());
    dio.Response response =
        await dioClient.put("${Endpoints.app}/add-detail", data: {
      "id": id,
      "phone": phone,
      "phone2": phone2,
      "relation"  : relation,
      "relationName" :relationName
    });

    if (response.statusCode == 200) {
      emit(AppAddDetailSuccessState(data: response.data));
    } else {
      emit(
        AppAddDetailErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }
}
