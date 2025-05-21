import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class CustomExpansionTile extends StatelessWidget {
  CustomExpansionTile({
    super.key,
    required this.title,
    required this.leadingIcon,
    required this.fields,
    required this.index,
    this.onChanged
 
  });
  String title;
  String leadingIcon;
  List<Map<String, dynamic>> fields;
  int index;
  void Function(String)? onChanged;

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
          fields.length,
          (i) => Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: CustomTextfield(
              onChanged: onChanged,
              keyboardType:fields[i]["keyboardType"],
              readOnly: fields[i]["disable"] ?? false,
              inputFormatters: fields[i]["masks"] ?? <TextInputFormatter>[] ,
              textEditingController: fields[i]["controller"],
              hintText: fields[i]["title"],
              prefixIcon: fields[i]["prefix"] == null
                  ? null
                  : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only( left: 10.w),
                        child: Text(
                            fields[i]["prefix"].toString(),
                            style: TextStyle(
                              color: AppConstant.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                      ),
                    ],
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
