import 'package:premium_pay_seller/export_files.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        customLogo(true),
        SizedBox(
          height: 70.w,
          width: 70.w,
          child: CircularProgressIndicator(
            color: AppConstant.primaryColor,
            strokeWidth: 3.w,
          ),
        ),
      ],
    );
  }
}
