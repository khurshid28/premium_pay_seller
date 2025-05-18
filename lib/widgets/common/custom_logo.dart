import 'package:premium_pay_seller/export_files.dart';

customLogo<Widget>(bool isLoading) {
  return Image.asset(
    isLoading
        ? 'assets/images/premiumpay.PNG'
        : 'assets/images/premiumpay1.PNG',
    width: isLoading ? 70.w : 300.w,
    color: AppConstant.primaryColor,
  );
}
