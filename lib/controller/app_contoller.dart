// ignore_for_file: invalid_use_of_visible_for_testing_member, use_build_context_synchronously

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/app/add_detail/app_add_detail_bloc.dart';
import 'package:premium_pay_seller/bloc/app/add_detail/app_add_detail_state.dart';
import 'package:premium_pay_seller/bloc/app/add_product/app_add_product_bloc.dart';
import 'package:premium_pay_seller/bloc/app/add_product/app_add_product_state.dart';
import 'package:premium_pay_seller/bloc/app/all/all_bloc.dart';
import 'package:premium_pay_seller/bloc/app/all/all_state.dart';
import 'package:premium_pay_seller/bloc/app/cancel/app_cancel_bloc.dart';
import 'package:premium_pay_seller/bloc/app/cancel/app_cancel_state.dart';
import 'package:premium_pay_seller/bloc/app/create/app_create_bloc.dart';
import 'package:premium_pay_seller/bloc/app/create/app_create_state.dart';
import 'package:premium_pay_seller/bloc/app/finish/app_finish_bloc.dart';
import 'package:premium_pay_seller/bloc/app/finish/app_finish_state.dart';
import 'package:premium_pay_seller/bloc/app/profile/app_profile_bloc.dart';
import 'package:premium_pay_seller/bloc/app/profile/app_profile_state.dart';
import 'package:premium_pay_seller/bloc/app/scoring/app_scoring_bloc.dart';
import 'package:premium_pay_seller/bloc/app/scoring/app_scoring_state.dart';
import 'package:premium_pay_seller/bloc/app/select/app_select_bloc.dart';
import 'package:premium_pay_seller/bloc/app/select/app_select_state.dart';
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
      // if (e is DioExceptions) {
      //   var err = e;

      //   // ignore: invalid_use_of_protected_member
      //   BlocProvider.of<AllAppBloc>(context).emit(
      //     AllAppErrorState(
      //       message: err.message,
      //       title: err.message,
      //       statusCode: 500,
      //     ),
      //   );
      // }
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


static Future<void> refreshSingle(BuildContext context,
{
    required int id
  }
      ) async {
    try {
      await BlocProvider.of<SingleAppBloc>(context).refresh(
        id: id
      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      // if (e is DioExceptions) {
      //   var err = e;

      //   // ignore: invalid_use_of_protected_member
      //   BlocProvider.of<SingleAppBloc>(context).emit(
      //     SingleAppErrorState(
      //       message: err.message,
      //       title: err.message,
      //       statusCode: 500,
      //     ),
      //   );
      // }
    }
  }




static Future<void> getProfile(BuildContext context,
{
    required int id
  }
      ) async {
    try {
      await BlocProvider.of<AppProfileBloc>(context).get(
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
        BlocProvider.of<AppProfileBloc>(context).emit(
          AppProfileErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }



static Future<void> addDetail(BuildContext context,
{
    required int id,
    required String phone,
    required String phone2,
    required String? relation,
  }
      ) async {
    try {
      await BlocProvider.of<AppAddDetailBloc>(context).add(
        id: id,
        phone2: phone2,
        phone: phone,
        relation : relation,

      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      if (e is DioExceptions) {
        var err = e;

        // ignore: invalid_use_of_protected_member
        BlocProvider.of<AppAddDetailBloc>(context).emit(
          AppAddDetailErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }



static Future<void> scoring(BuildContext context,
{
    required int id,
    required int dayOfPayment,

  }
      ) async {
    try {
      await BlocProvider.of<AppScoringBloc>(context).post(
        id: id,
        dayOfPayment: dayOfPayment,
      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      if (e is DioExceptions) {
        var err = e;

        // ignore: invalid_use_of_protected_member
        BlocProvider.of<AppScoringBloc>(context).emit(
          AppScoringErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }


static Future<void> addProduct(BuildContext context,
{
    required int id,
    required List<Map<String,dynamic>> products,
  }
      ) async {
    try {
      await BlocProvider.of<AppAddProductBloc>(context).add(
        id: id,
       products: products
      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      if (e is DioExceptions) {
        var err = e;

        // ignore: invalid_use_of_protected_member
        BlocProvider.of<AppAddProductBloc>(context).emit(
          AppAddProductErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }



static Future<void> select(BuildContext context,
{
    required int id,
    required String expired_month,
  }
      ) async {
    try {
      await BlocProvider.of<AppSelectBloc>(context).select(
        id: id,
       expired_month: expired_month
      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      if (e is DioExceptions) {
        var err = e;

        // ignore: invalid_use_of_protected_member
        BlocProvider.of<AppSelectBloc>(context).emit(
          AppSelectErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }



static Future<void> finish(BuildContext context,
{
    required int id,
  }
      ) async {
    try {
      await BlocProvider.of<AppFinishBloc>(context).finish(
        id: id,
      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      if (e is DioExceptions) {
        var err = e;

        // ignore: invalid_use_of_protected_member
        BlocProvider.of<AppFinishBloc>(context).emit(
          AppFinishErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }



static Future<void> create(BuildContext context,
{
    required String passport,
  }
      ) async {
    try {
      await BlocProvider.of<AppCreateBloc>(context).create(
        passport: passport,
      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      if (e is DioExceptions) {
        var err = e;

        // ignore: invalid_use_of_protected_member
        BlocProvider.of<AppCreateBloc>(context).emit(
          AppCreateErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }



static Future<void> cancel(BuildContext context,
{
     required int id,
    required String canceled_reason,
  }
      ) async {
    try {
      await BlocProvider.of<AppCancelBloc>(context).cancel(
        id: id,
        canceled_reason: canceled_reason
      );
    } catch (e, track) {
      if (kDebugMode) {
        print("Controller Error >>$e");
        print("Controller track >>$track");
      }
      if (e is DioExceptions) {
        var err = e;
        // ignore: invalid_use_of_protected_member
        BlocProvider.of<AppCancelBloc>(context).emit(
          AppCancelErrorState(
            message: err.message,
            title: err.message,
            statusCode: 500,
          ),
        );
      }
    }
  }


}
