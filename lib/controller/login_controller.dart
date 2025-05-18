// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/login/login_bloc.dart';
import 'package:premium_pay_seller/bloc/login/login_state.dart';
import 'package:premium_pay_seller/core/network/dio_exception.dart';
import 'package:premium_pay_seller/export_files.dart';

class LoginController {
  static Future<void> postdata(BuildContext context,
      {required String login, required String password}) async {
    try {
      await BlocProvider.of<LoginBloc>(context).postData(
        login: login,
        password: password,
      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      if (e is DioExceptions) {
        var err = e;

        // ignore: invalid_use_of_protected_member
        BlocProvider.of<LoginBloc>(context).emit(
          LoginErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }
}
