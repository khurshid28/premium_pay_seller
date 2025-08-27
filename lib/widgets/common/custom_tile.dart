import 'package:flutter/foundation.dart';
import 'package:premium_pay_seller/core/extensions/number_extensions.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/screens/single_application/components/single_card.dart';

// ignore: must_be_immutable
class CustomTile extends StatelessWidget {
  CustomTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.leadingIcon,
    required this.index,
    required this.isHomeCard,
    required this.isTrailing,
    required this.onTap,
    required this.status,
    this.app,
  });
  String title;
  String subtitle;
  String leadingIcon;
  String status;
  Map? app;
  int index;
  bool isHomeCard;
  bool isTrailing;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      // height: isHomeCard ? 50.h : 70.h,
      width: 1.sw,
      child: ListTile(
        onTap: onTap,
        minTileHeight: isHomeCard ? 50.h : 70.h,
        horizontalTitleGap: 10.w,
        isThreeLine: false,
        leading: isHomeCard
            ? CustomIcon(
                icon: leadingIcon,
                color: AppConstant.primaryColor,
                width: 30,
              )
            : CircleAvatar(
                radius: 20.r,
                backgroundColor:
                    AppConstant.primaryColor.withOpacity(index == 0 ? 1 : 0.3),
                child: CustomIcon(
                  icon: leadingIcon,
                  color: AppConstant.whiteColor,
                  width: 25,
                ),
              ),
        title: CustomText(
          text: title,
          color: AppConstant.blackColor,
          size: isHomeCard ? 14.sp : 16.sp,
          weight: FontWeight.w400,
        ),
        subtitle: isTrailing
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (app?["limit"] != null && app?["status"] == "LIMIT")
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text:
                                "ЛИМИТ : ${num.tryParse((app?["limit"] ?? "").toString()).toMoney()}",
                            color: AppConstant.greenColor,
                            size: 12.sp,
                            weight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                        ]),
                  if (app?["status"] == "WAITING_SCORING")
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: "Скоринг",
                            color: AppConstant.blueColor,
                            size: 12.sp,
                            weight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                        ]),
                  if (app?["status"] == "WAITING_BANK_UPDATE")
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: "Ожидание в банке",
                            color: AppConstant.blueColor,
                            size: 12.sp,
                            weight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                        ]),
                  if (app?["status"] == "WAITING_BANK_CONFIRM")
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: "Ожидание в банковском приложении",
                            color: AppConstant.blueColor,
                            size: 12.sp,
                            weight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                        ]),
                  if (app?["status"] == "CONFIRMED")
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: " Закoнчить заявку",
                            color: AppConstant.blueColor,
                            size: 12.sp,
                            weight: FontWeight.w400,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                        ]),
                  CustomText(
                    text: subtitle,
                    color: AppConstant.blackColor,
                    size: isHomeCard ? 10.sp : 12.sp,
                    weight: FontWeight.w200,
                  ),
                ],
              )
            : null,
        trailing: isTrailing
            ? CustomIcon(
                icon: 'assets/icons/${statusIcon(status)}.svg',
                color: statusColor(status),
                width: isHomeCard ? 25 : 30,
              )
            : null,
      ),
    );
  }

  statusIcon<String>(String statusCode) {
    if (kDebugMode)  print(statusCode);
    if (statusCode == "FINISHED") {
      return 'checkmark';
    } else if ([
      "CANCELED_BY_SCORING",
      "CANCELED_BY_CLIENT",
      "CANCELED_BY_DAILY",
    ].contains(statusCode)) {
      return 'xmark';
    } else {
      return 'waitmark';
    }
  }

  statusColor<Color>(String statusCode) {
    if (statusCode == "FINISHED") {
      return AppConstant.greenColor;
    } else if ([
      "CANCELED_BY_SCORING",
      "CANCELED_BY_CLIENT",
      "CANCELED_BY_DAILY",
    ].contains(statusCode)) {
      return AppConstant.redColor;
    } else {
      return AppConstant.blueColor;
    }
  }
}
