import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class CustomBuilder extends StatelessWidget {
  CustomBuilder({
    super.key,
    required this.itemCount,
    required this.child,
  });
  int itemCount;
  Widget child;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: index == 0 ? 16.w : 0,
          bottom: 16.w,
        ),
        child: child,
      ),
    );
  }
}
