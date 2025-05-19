import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_profile_state.dart';


class AppProfileBloc extends Cubit<AppProfileState> {
  DioClient dioClient = DioClient();
  AppProfileBloc() : super(AppProfileIntialState());

  Future get({
    required int id
  }) async {
    emit(AppProfileWaitingState());
    dio.Response response = await dioClient.get("${Endpoints.app}/profile/$id");

    if (response.statusCode == 200) {
      emit(AppProfileSuccessState(data: response.data));
    } else {
      emit(
        AppProfileErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }

 
 

}
