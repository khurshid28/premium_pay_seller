import 'package:flutter/cupertino.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/widgets/common/custom_loading.dart';

// ignore: must_be_immutable
class Step3Screen extends StatefulWidget {
  Step3Screen({super.key, required this.title});
  String title;

  @override
  State<Step3Screen> createState() => _Step3ScreenState();
}

class _Step3ScreenState extends State<Step3Screen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelect = false;
  int selectedDay = 1;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: widget.title,
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
              20,
              (index) => Center(
                child: CustomText(
                  text: '${index + 1}',
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
        SizedBox(height: 16.h),
        CustomButton(
          text: "Отправить на Скоринг",
          onTap: () {
            isSelect = !isSelect;
            setState(() {});
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
