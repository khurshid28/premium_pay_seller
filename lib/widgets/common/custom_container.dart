import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  CustomContainer({
    super.key,
    this.height,
    this.width,
    this.padding,
    this.margin,
    this.color,
    this.bordercolor,
    required this.child,
  });
  double? height;
  double? width;
  Color? color;
  Color? bordercolor;
  Widget child;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? AppConstant.whiteColor,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: bordercolor ?? AppConstant.blackColor,
          width: 0.1,
        ),
      ),
      child: child,
    );
  }
}
