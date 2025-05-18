import 'package:premium_pay_seller/export_files.dart';

showCustomModal(BuildContext context, StatefulWidget builder) async {
  return await showModalBottomSheet(
    isScrollControlled: true,
    barrierColor: AppConstant.blackColor.withOpacity(0.3),
    backgroundColor: AppConstant.whiteColor,
    context: context,
    builder: (context) => builder,
  );
}