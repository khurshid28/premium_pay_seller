import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class CustomIcon extends StatelessWidget {
  CustomIcon({
    super.key,
    required this.icon,
    required this.color,
    required this.width,
  });
  String icon;
  Color color;
  double width;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      width: width.w,
      colorFilter: ColorFilter.mode(
        color,
        BlendMode.srcIn,
      ),
      fit: BoxFit.scaleDown,
    );
  }
}
