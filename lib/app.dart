import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/app/all/all_bloc.dart';
import 'package:premium_pay_seller/bloc/app/single/single_app_bloc.dart';
import 'package:premium_pay_seller/bloc/login/login_bloc.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/widgets/build/material_builder.dart';

class PremiumPaySeller extends StatelessWidget {
  const PremiumPaySeller({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390.0, 845.0),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(create:(context)=>LoginBloc(),),
           BlocProvider<AllAppBloc>(create:(context)=>AllAppBloc(),),
            BlocProvider<SingleAppBloc>(create:(context)=>SingleAppBloc(),),
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
