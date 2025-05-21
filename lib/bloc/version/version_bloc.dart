import 'package:dio/dio.dart' as dio;
import 'package:premium_pay_seller/core/endpoints/endpoints.dart';
import 'package:premium_pay_seller/core/network/dio_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'version_state.dart';

class VersionBloc extends Cubit<VersionState> {
  DioClient dioClient = DioClient();
  VersionBloc() : super(VersionIntialState());

  Future getVersion() async {
    emit(VersionWaitingState());
    dio.Response response = await dioClient.get(Endpoints.version);

    if (response.statusCode == 200) {
      emit(VersionSuccessState(version: response.data["version"] ?? "1.0.0"));
    } else {
      emit(
        VersionErrorState(
            title: response.data["error"].toString(),
            message: response.data["message"].toString(),
            statusCode: response.statusCode),
      );
    }

    return response.data;
  }
}
