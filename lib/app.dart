import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/app/add_detail/app_add_detail_bloc.dart';
import 'package:premium_pay_seller/bloc/app/add_product/app_add_product_bloc.dart';
import 'package:premium_pay_seller/bloc/app/all/all_bloc.dart';
import 'package:premium_pay_seller/bloc/app/cancel/app_cancel_bloc.dart';
import 'package:premium_pay_seller/bloc/app/create/app_create_bloc.dart';
import 'package:premium_pay_seller/bloc/app/finish/app_finish_bloc.dart';
import 'package:premium_pay_seller/bloc/app/profile/app_profile_bloc.dart';
import 'package:premium_pay_seller/bloc/app/scoring/app_scoring_bloc.dart';
import 'package:premium_pay_seller/bloc/app/select/app_select_bloc.dart';
import 'package:premium_pay_seller/bloc/app/single/single_app_bloc.dart';
import 'package:premium_pay_seller/bloc/login/login_bloc.dart';
import 'package:premium_pay_seller/bloc/myID/myid_code_bloc.dart';
import 'package:premium_pay_seller/bloc/version/version_bloc.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/widgets/build/material_builder.dart';

class PremiumPaySeller extends StatelessWidget {
  const PremiumPaySeller({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390.0, 845.0),
      // minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(),
            lazy: true,
          ),
          BlocProvider<AllAppBloc>(
            create: (context) => AllAppBloc(),
            lazy: true,
          ),
          BlocProvider<SingleAppBloc>(
            create: (context) => SingleAppBloc(),
            lazy: true,
          ),
          BlocProvider<AppProfileBloc>(
            create: (context) => AppProfileBloc(),
            lazy: true,
          ),
          BlocProvider<AppAddDetailBloc>(
            create: (context) => AppAddDetailBloc(),
            lazy: true,
          ),
          BlocProvider<AppScoringBloc>(
            create: (context) => AppScoringBloc(),
            lazy: true,
          ),
          BlocProvider<AppAddProductBloc>(
            create: (context) => AppAddProductBloc(),
            lazy: true,
          ),
          BlocProvider<AppSelectBloc>(
            create: (context) => AppSelectBloc(),
            lazy: true,
          ),
           BlocProvider<AppFinishBloc>(
            create: (context) => AppFinishBloc(),
            lazy: true,
          ),
            BlocProvider<MyidCodeBloc>(
            create: (context) => MyidCodeBloc(),
            lazy: true,
          ),


            BlocProvider<AppCreateBloc>(
            create: (context) => AppCreateBloc(),
            lazy: true,
          ),

           BlocProvider<VersionBloc>(
            create: (context) => VersionBloc(),
            lazy: true,
          ),
           BlocProvider<AppCancelBloc>(
            create: (context) => AppCancelBloc(),
            lazy: true,
          ),
        ],
        child: MaterialApp.router(
          title: 'Premium Pay',
          debugShowCheckedModeBanner: false,
          builder: MaterialAppCustomBuilder.builder,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppConstant.primaryColor,
              primary: AppConstant.whiteColor,
              dynamicSchemeVariant: DynamicSchemeVariant.content,
              surfaceTint: AppConstant.whiteColor,
            ),
            textTheme: GoogleFonts.robotoTextTheme(
              Typography.englishLike2021.apply(
                fontSizeFactor: 1,
                bodyColor: AppConstant.blackColor,
              ),
            ),
            useMaterial3: true,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          routerConfig: AppRouter().router,
        ),
      ),
    );
  }
}
