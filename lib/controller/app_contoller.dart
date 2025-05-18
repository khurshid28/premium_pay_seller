// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/app/all/all_bloc.dart';
import 'package:premium_pay_seller/bloc/app/all/all_state.dart';
import 'package:premium_pay_seller/bloc/app/single/single_app_bloc.dart';
import 'package:premium_pay_seller/bloc/app/single/single_app_state.dart';
import 'package:premium_pay_seller/core/network/dio_exception.dart';
import 'package:premium_pay_seller/export_files.dart';

class AppContoller {
  static Future<void> getAll(BuildContext context,
      ) async {
    try {
      await BlocProvider.of<AllAppBloc>(context).getAllApp(
      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      if (e is DioExceptions) {
        var err = e;

        // ignore: invalid_use_of_protected_member
        BlocProvider.of<AllAppBloc>(context).emit(
          AllAppErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }



 static Future<void> refreshAll(BuildContext context,
      ) async {
    try {
      await BlocProvider.of<AllAppBloc>(context).refreshAll(
      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      if (e is DioExceptions) {
        var err = e;

        // ignore: invalid_use_of_protected_member
        BlocProvider.of<AllAppBloc>(context).emit(
          AllAppErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }



static Future<void> getSingle(BuildContext context,
{
    required int id
  }
      ) async {
    try {
      await BlocProvider.of<SingleAppBloc>(context).get(
        id: id
      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      if (e is DioExceptions) {
        var err = e;

        // ignore: invalid_use_of_protected_member
        BlocProvider.of<SingleAppBloc>(context).emit(
          SingleAppErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }

}
