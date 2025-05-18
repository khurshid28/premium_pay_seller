import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class Step5Screen extends StatefulWidget {
  Step5Screen({super.key, required this.title});
  String title;

  @override
  State<Step5Screen> createState() => _Step5ScreenState();
}

class _Step5ScreenState extends State<Step5Screen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = true;
  int? selectedIndex;
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
      customBody: step5ScreenBody(),
    );
  }

  step5ScreenBody() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 1.sw,
          minHeight: 1.sh - 87.h,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomContainer(
                  width: 1.sw,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Все товары',
                                  color: AppConstant.blackColor,
                                  size: 14,
                                  weight: FontWeight.w600,
                                ),
                                CustomContainer(
                                  height: 30.h,
                                  width: 30.w,
                                  color: AppConstant.primaryColor,
                                  child: Center(
                                    child: CustomText(
                                      text: '4',
                                      color: AppConstant.whiteColor,
                                      size: 14,
                                      weight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Общая сумма',
                                  color: AppConstant.blackColor,
                                  size: 14,
                                  weight: FontWeight.w600,
                                ),
                                CustomText(
                                  text: '12 600 000 сум',
                                  color: AppConstant.blackColor,
                                  size: 14,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ExpansionTile(
                        shape: Border.all(style: BorderStyle.none),
                        childrenPadding: EdgeInsets.symmetric(horizontal: 16.w),
                        title: CustomText(
                          text: 'Состав заказа',
                          color: AppConstant.blackColor,
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                        iconColor: AppConstant.primaryColor,
                        children: List.generate(
                          4,
                          (index1) => Column(
                            children: [
                              customDivider(),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: SizedBox(
                                  height: 30.h,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: 'Артель ТВ',
                                        color: AppConstant.blackColor,
                                        size: 14,
                                        weight: FontWeight.w400,
                                      ),
                                      CustomText(
                                        text: '3 150 000 сум',
                                        color: AppConstant.blackColor,
                                        size: 14,
                                        weight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                    (index) => GestureDetector(
                      onTap: () {
                        selectedIndex = index;
                        setState(() {
                          isSelected = !isSelected;
                        });
                      },
                      child: CustomContainer(
                        height: 70.h,
                        width: 70.w,
                        color: selectedIndex == index
                            ? AppConstant.primaryColor
                            : Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              text: '${(index + 1) * 3} ',
                              color: selectedIndex == index
                                  ? AppConstant.whiteColor
                                  : AppConstant.blackColor,
                              size: 18,
                              weight: FontWeight.w600,
                            ),
                            CustomText(
                              text: 'МЕС',
                              color: selectedIndex == index
                                  ? AppConstant.whiteColor
                                  : AppConstant.blackColor,
                              size: 12,
                              weight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                CustomContainer(
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      CustomIcon(
                        icon: 'assets/icons/checkmark.svg',
                        color: AppConstant.greenColor,
                        width: 30,
                      ),
                      CustomText(
                        text:
                            'Оформление рассрочки на вибранный период возможно',
                        color: AppConstant.blackColor,
                        size: 14,
                        weight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      customDivider(),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Ежемесячный платеж',
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                          CustomText(
                            text: '1 350 000 сум',
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Общая сумма рассрочки',
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                          CustomText(
                            text: '14 350 000 сум',
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                CustomText(
                  text:
                      "Расчеты произведены на основе данных предоставленных клиентом и могут отличаться от расчетов произведенных в банке",
                  color: AppConstant.blackColor,
                  size: 14,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                SizedBox(height: 16.h),
                CustomButton(
                  text: 'Оформить',
                  onTap: () {},
                ),
                SizedBox(height: 16.h),
                CustomButton(
                  color: AppConstant.redColor,
                  text: 'Отменить заявка',
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
