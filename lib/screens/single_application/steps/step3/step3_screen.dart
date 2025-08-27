import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:premium_pay_seller/bloc/app/scoring/app_scoring_bloc.dart';
import 'package:premium_pay_seller/bloc/app/scoring/app_scoring_state.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/core/extensions/date_extensions.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/loading.dart';
import 'package:premium_pay_seller/service/toast.dart';
import 'package:premium_pay_seller/widgets/common/custom_loading.dart';

// ignore: must_be_immutable
class Step3Screen extends StatefulWidget {
  final app;
  // String? title;
  Step3Screen({
    super.key,
    required this.app,
  });

  @override
  State<Step3Screen> createState() => _Step3ScreenState();
}

class _Step3ScreenState extends State<Step3Screen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelect = false;
  int selectedDay = 1;

  LoadingService loadingService = LoadingService();
  ToastService toastService = ToastService();

  @override
  void initState() {
    isSelect = widget.app["status"] == "WAITING_SCORING";
    super.initState();
  }

  bool hasExtra() {
    return (DateTime.parse(widget.app["createdAt"].toString())..add(const Duration(hours: 5))).day > 14;
  }

  String formatDateFull(int day) {
    DateTime now = DateTime.parse(widget.app["createdAt"].toString())..add(const Duration(hours: 5));
    int extraMonth = hasExtra() ? 2 : 1;
    int year = now.year;
    int month = now.month + extraMonth;
    if (month > 12) {
      month = month % 12;
      year += 1;
    }
    return DateFormat('dd/MM/yyyy').format(new DateTime(year,month,day));
  }






 

  

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: "Скоринг",
          isLeading: true,
          isHome: false,
        ),
      ),
      scaffoldKey: scaffoldKey,
      customBody: step3ScreenBody(),
    );
  }

  step3ScreenBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: isSelect == false ? body1() : body2(),
    );
  }

  body1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 16.h),
        CustomText(
          text: 'Выберите удобную для вас дату платежа',
          color: AppConstant.blackColor,
          size: 14,
          weight: FontWeight.w400,
        ),
        SizedBox(height: 16.h),
        CustomContainer(
          height: 200.h,
          child: CupertinoPicker(
            itemExtent: 40.h,
            scrollController:
                FixedExtentScrollController(initialItem: selectedDay - 1),
            onSelectedItemChanged: (index) {
              setState(() {
                selectedDay = index + 1;
              });
            },
            children: List.generate(
              14,
              (index) => Center(
                child: CustomText(
                  text:  formatDateFull(index+1),
                  color: AppConstant.blackColor,
                  size: 16,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Вы платите за приобретенную продукцию ',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppConstant.blackColor,
              fontWeight: FontWeight.w400,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '$selectedDay',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: '-го числа каждого месяца!'),
            ],
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Первый платёж -  ',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppConstant.blackColor,
              fontWeight: FontWeight.w400,
            ),
            children: <TextSpan>[
              TextSpan(
                text: '${formatDateFull(selectedDay)}',
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        BlocListener<AppScoringBloc, AppScoringState>(
          child: const SizedBox(),
          listener: (context, state) async {
            if (state is AppScoringWaitingState) {
              loadingService.showLoading(context);
            } else if (state is AppScoringErrorState) {
              loadingService.closeLoading(context);
              toastService.error(message: state.message ?? "Xatolik Bor");
              if (kDebugMode) print(state.message ?? "Xatolik Bor");
            } else if (state is AppScoringSuccessState) {
              loadingService.closeLoading(context);

              if (mounted) {
                isSelect = !isSelect;
                setState(() {});
                AppContoller.refreshSingle(context,
                    id: int.tryParse(widget.app["id"].toString()) ?? 0);
                await Future.delayed(const Duration(seconds: 8));
                if (mounted) {
                  context.pop();
                }
              }
              toastService.success(message: "Muvafaqqiyatli yuborildi");

              if (kDebugMode) print("Successfully Post data");
            }
          },
        ),
        SizedBox(height: 16.h),
        CustomButton(
          text: "Отправить на Скоринг",
          onTap: () {
            AppContoller.scoring(context,
                id: int.tryParse(widget.app["id"].toString()) ?? 0,
                dayOfPayment: selectedDay);
          },
        ),
        SizedBox(height: 16.h),
      ],
    );
  }

  body2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const CustomLoading(),
        SizedBox(
          height: 16.h,
        ),
        CustomText(
          text: 'Мы почти закончили! Ваша информация обрабатывается...',
          color: AppConstant.blackColor,
          size: 16,
          weight: FontWeight.w400,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
