// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/myID/myid_code_bloc.dart';
import 'package:premium_pay_seller/bloc/myID/myid_code_state.dart';
import 'package:premium_pay_seller/core/network/dio_exception.dart';
import 'package:premium_pay_seller/export_files.dart';

class MyidController {
  static Future<void> code(BuildContext context,
      {required String? code,required String? passport,
       required double comparison_value,}) async {
    try {
      await BlocProvider.of<MyidCodeBloc>(context).sendCode(
        code: code,
        passport: passport,
        comparison_value: comparison_value

      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      if (e is DioExceptions) {
        var err = e;

        // ignore: invalid_use_of_protected_member
        BlocProvider.of<MyidCodeBloc>(context).emit(
          MyidCodeErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }
}
