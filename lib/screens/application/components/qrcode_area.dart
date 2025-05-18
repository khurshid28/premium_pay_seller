import 'package:premium_pay_seller/export_files.dart';

qrcodeArea(BuildContext context) {
  return Row(
    children: [
      GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Center(
              child: CustomContainer(
                color: AppConstant.whiteColor,
                child: CustomIcon(
                  icon: 'assets/icons/qrcode.svg',
                  color: AppConstant.primaryColor,
                  width: 1.sw / 1.2,
                ),
              ),
            ),
          );
        },
        child: CustomContainer(
          child: CustomIcon(
            icon: 'assets/icons/qrcode.svg',
            color: AppConstant.primaryColor,
            width: 100,
          ),
        ),
      ),
      SizedBox(width: 16.w),
      Expanded(
        child: CustomText(
          text: "Скачать договор можно, отсканировав QR-код.",
          color: AppConstant.blackColor,
          size: 14,
          weight: FontWeight.w400,
        ),
      ),
      CustomContainer(
        height: 40.h,
        width: 40.w,
        color: AppConstant.primaryColor,
        child: CustomIcon(
          icon: 'assets/icons/download.svg',
          color: AppConstant.whiteColor,
          width: 50,
        ),
      ),
    ],
  );
}
