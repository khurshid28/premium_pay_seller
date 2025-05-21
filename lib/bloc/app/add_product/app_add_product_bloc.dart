import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/bloc/app/add_product/app_add_product_state.dart';
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AppAddProductBloc extends Cubit<AppAddProductState> {
  DioClient dioClient = DioClient();
  AppAddProductBloc() : super(AppAddProductIntialState());

  Future add({
    required int id,
    required List<Map<String,dynamic>> products,
  }) async {
    emit(AppAddProductWaitingState());
    dio.Response response =
        await dioClient.post("${Endpoints.app}/add-product", data: {
      "id": id,
      "products": products,
  
    });

    if (response.statusCode == 200) {
      emit(AppAddProductSuccessState(data: response.data));
    } else {
      emit(
        AppAddProductErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }
}
