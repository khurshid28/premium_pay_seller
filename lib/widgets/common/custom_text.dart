import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class CustomText extends StatelessWidget {
  CustomText({
    super.key,
    required this.text,
    required this.color,
    required this.size,
    required this.weight,
    this.textAlign,
  });
  String text;
  Color color;
  double size;
  FontWeight weight;
  TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size.sp,
        fontWeight: weight,
      ),
      textAlign: textAlign,
    );
  }
}
