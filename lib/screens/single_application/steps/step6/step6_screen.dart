import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/app/finish/app_finish_bloc.dart';
import 'package:premium_pay_seller/bloc/app/finish/app_finish_state.dart';
import 'package:premium_pay_seller/bloc/app/select/app_select_bloc.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/loading.dart';
import 'package:premium_pay_seller/service/toast.dart';
import 'package:premium_pay_seller/widgets/common/custom_loading.dart';

// ignore: must_be_immutable
class Step6Screen extends StatefulWidget {
  Step6Screen({super.key, required this.app});
  dynamic app;

  @override
  State<Step6Screen> createState() => _Step6ScreenState();
}

class _Step6ScreenState extends State<Step6Screen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

    LoadingService loadingService = LoadingService();
  ToastService toastService = ToastService();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: "Договор",
          isLeading: true,
          isHome: false,
        ),
      ),
      scaffoldKey: scaffoldKey,
      customBody: step6ScreenBody(),
    );
  }

  step6ScreenBody() {
    if (widget.app["status"] == "WAITING_BANK_UPDATE") {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomLoading(),
            SizedBox(
              height: 16.h,
            ),
            CustomText(
              text: 'Ждем ответа от банка, подождите пожалуйста...',
              color: AppConstant.blackColor,
              size: 16,
              weight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (widget.app["status"] == "WAITING_BANK_CONFIRM") {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomLoading(),
            SizedBox(
              height: 16.h,
            ),
            CustomText(
              text: 'Подтвердите заявку через приложение банка',
              color: AppConstant.blackColor,
              size: 16,
              weight: FontWeight.w400,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            BlocListener<AppFinishBloc, AppFinishState>(
                  child: const SizedBox(),
                  listener: (context, state) async {
                    if (state is AppFinishWaitingState) {
                      loadingService.showLoading(context);
                    } else if (state is AppFinishErrorState) {
                      loadingService.closeLoading(context);
                      toastService.error(
                          message: state.message ?? "Xatolik Bor");
                      print(state.message ?? "Xatolik Bor");
                    } else if (state is AppFinishSuccessState) {
                      loadingService.closeLoading(context);

                      if (mounted) {
                          AppContoller.refreshAll(context,
                           );
                        AppContoller.refreshSingle(context,
                            id: int.tryParse(widget.app["id"].toString()) ?? 0);
                        context.replace(
                          '/application',
                          extra: {
                            'app': state.data,
                          },
                        );
                      }
                      toastService.success(message: "Muvafaqqiyatli Tugatildi");

                      print("Successfully Post data");
                    }
                  },
                ),
               
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/images/finished.png",
                width: 0.85.sw,
                height: 320.h,
              ),
              SizedBox(height: 16.h,),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 16.w),
                child: CustomText(
                  text: 'Оформления прошли успешно, клиент может забрать товар.',
                  color: AppConstant.blackColor,
                  size: 16,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          Padding(
            padding:  EdgeInsets.only(bottom: 16.h),
            child: CustomButton(
              text: 'Закончить',
              onTap: () {
                 AppContoller.finish(context,
                      id: int.tryParse(widget.app["id"].toString()) ?? 0,
                    );
              },
            ),
          ),
        ],
      ),
    );
  }
}
