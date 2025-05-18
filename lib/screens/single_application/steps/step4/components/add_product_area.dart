import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class AddProductArea extends StatefulWidget {
  AddProductArea({super.key, required this.data});
  Map<String, dynamic> data;

  @override
  State<AddProductArea> createState() => _AddProductModalState();
}

class _AddProductModalState extends State<AddProductArea> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.4.h,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...(widget.data.entries.map(
              (e) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: e.value["title"].toString(),
                        color: AppConstant.blackColor,
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                      SizedBox(height: 5.h),
                      CustomTextfield(
                        textEditingController: e.value["controller"],
                        hintText: e.value["title"],
                        minlines: 1,
                        maxlines: 1,
                      ),
                      // Text(e.value.toString())
                    ],
                  ),
                );
              },
            )),
            CustomButton(
              text: 'Применить',
              onTap: () {
                context.pop(widget.data);
                // print(data["name"]["controller"].text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
