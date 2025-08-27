import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:premium_pay_seller/core/extensions/date_extensions.dart';
import 'package:premium_pay_seller/core/extensions/number_extensions.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/file_service.dart';
import 'package:premium_pay_seller/service/generate_dates.dart';
import 'package:premium_pay_seller/service/toast.dart';

// ignore: must_be_immutable
class GraphicScreen extends StatefulWidget {
  GraphicScreen(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.app});
  String? title;
  String? subtitle;
  dynamic app;

  @override
  State<GraphicScreen> createState() => _GraphicScreenState();
}

class _GraphicScreenState extends State<GraphicScreen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
 bool hasExtra(Map app){
    return (DateTime.parse(app["createdAt"].toString())..add(const Duration(hours: 5))).day > 14;
  }
  int GetPaymentAmountInMonth() {
    return (num.tryParse((widget.app["payment_amount"] ?? 0).toString()) ??
            0) ~/
         ((num.tryParse(widget.app["expired_month"].toString()) ?? 12) - (hasExtra(widget.app) ? 1 : 0));
  }


ToastService toastService = ToastService();
  @override
  Widget build(BuildContext context) {
    // for (var i = 0; i < 30; i++) {
    //   if(kDebugMode) {
    //     print(widget.app?["request"]);
    //   }
    // }
    List<DateTime> dates = getMonthlyDates(
        DateTime.parse(widget.app["createdAt"].toString()),
         int.tryParse(
                (widget.app?["request"]?["redemptionday"] ?? "").toString()) ??
            1,
        months: int.tryParse(widget.app["expired_month"].toString()) ?? 12);

    int amountInMonth = GetPaymentAmountInMonth();

    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: 'График платежей',
          isLeading: true,
          isHome: false,
          actions: [
            Padding(
              padding:  EdgeInsets.only(right: 10.w),
              child: IconButton(
                highlightColor: Colors.transparent,
                onPressed: () async {
                toastService.success(message: "Grafik yuklanmoqda ...");
                 await FileService().downloadAndShareFile(
                      int.tryParse(widget.app["id"].toString()));
                },
                icon: CustomIcon(
                  icon: 'assets/icons/share.svg',
                  color: AppConstant.primaryColor,
                  width: 24.w,
                ),
              ),
            )
          ],
        ),
      ),
      customBody: graphicScreenBody(dates, amountInMonth),
      scaffoldKey: scaffoldKey,
    );
  }

  graphicScreenBody<Widget>(List<DateTime> dates, int amountInMonth) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            CustomContainer(
              height: 50.h,
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              margin: EdgeInsets.symmetric(vertical: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: widget.title!,
                    color: AppConstant.blackColor,
                    size: 14,
                    weight: FontWeight.w400,
                  ),
                  CustomText(
                    text: widget.subtitle!,
                    color: AppConstant.blackColor,
                    size: 14,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Дата платежа',
                    color: AppConstant.blackColor,
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                  CustomText(
                    text: 'Сумма платежа',
                    color: AppConstant.blackColor,
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            ...List.generate(
              dates.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                  bottom: 16.h,
                  top: index == 0 ? 16.h : 0,
                ),
                child: CustomContainer(
                  height: 50.h,
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: "${index + 1}-й месяц",
                            color: AppConstant.blackColor,
                            size: 12,
                            weight: FontWeight.w500,
                          ),
                          CustomText(
                            text: DateFormat('dd/MM/yyyy').formatUtc5(dates[index]),
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      CustomText(
                        text:index ==0 && hasExtra(widget.app)  ? "${0.toMoney()} сум" :  "${amountInMonth.toMoney()} сум",
                        color: AppConstant.blackColor,
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
