import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  CustomButton({
    super.key,
    required this.text,
    required this.onTap,
    this.color,
  });
  String text;
  Color? color;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? AppConstant.primaryColor,
        fixedSize: Size(1.sw, 50.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        foregroundColor: color ?? AppConstant.primaryColor,
      ),
      onPressed: onTap,
      child: CustomText(
        text: text,
        color: AppConstant.whiteColor,
        size: 16,
        weight: FontWeight.w400,
      ),
    );
  }
}
