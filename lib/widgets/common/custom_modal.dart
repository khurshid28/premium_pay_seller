import 'package:premium_pay_seller/export_files.dart';

showCustomModal(BuildContext context, StatefulWidget builder,{bool isDismissible = true}) async {
  return await showModalBottomSheet(
    isScrollControlled: true,
    isDismissible: isDismissible,
    barrierColor: AppConstant.blackColor.withOpacity(0.3),
    backgroundColor: AppConstant.whiteColor,
    context: context,
    showDragHandle: true,
    builder: (context) => builder,
  );
}