import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/bloc/app/all/all_state.dart';
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllAppBloc extends Cubit<AllAppState> {
  DioClient dioClient = DioClient();
  AllAppBloc() : super(AllAppIntialState());

  Future getAllApp() async {
    emit(AllAppWaitingState());
    dio.Response response = await dioClient.get(Endpoints.allApp);

    if (response.statusCode == 200) {
      emit(AllAppSuccessState(data: response.data));
    } else {
      emit(
        AllAppErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }

    Future refreshAll() async {

    dio.Response response = await dioClient.get(Endpoints.allApp);
    if (response.statusCode == 200) {
      emit(AllAppSuccessState(data: response.data));
    } else {
      // emit(
      //   AllAppErrorState(
      //       title: response.data["error"].toString(),
      //       message: response.data["message"].toString(),
      //       statusCode: response.statusCode),
      // );
    }

    return response.data;
  }


}
