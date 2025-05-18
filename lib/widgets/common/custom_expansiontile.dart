import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class CustomExpansionTile extends StatelessWidget {
  CustomExpansionTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.textFieldtitle,
    required this.index,
    required this.textEditingController,
  });
  String title;
  String leadingIcon;
  List<String> textFieldtitle;
  int index;
  TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: 1.sw,
      child: ExpansionTile(
        shape: Border.all(style: BorderStyle.none),
        childrenPadding: EdgeInsets.symmetric(horizontal: 16.w),
        leading: CustomIcon(
          icon: leadingIcon,
          color: AppConstant.primaryColor,
          width: 30.w,
        ),
        title: CustomText(
          text: title,
          color: AppConstant.blackColor,
          size: 16,
          weight: FontWeight.w400,
        ),
        iconColor: AppConstant.primaryColor,
        children: List.generate(
          textFieldtitle.length,
          (index1) => Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: CustomTextfield(
              textEditingController: textEditingController,
              hintText: textFieldtitle[index1],
            ),
          ),
        ),
      ),
    );
  }
}
