import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/toast.dart';

// ignore: must_be_immutable
class AddProductArea extends StatefulWidget {
  AddProductArea({super.key, required this.data});
  final data;

  @override
  State<AddProductArea> createState() => _AddProductModalState();
}

class _AddProductModalState extends State<AddProductArea> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // keyboard ga moslashadi
        ),
      child: IntrinsicHeight(
        // heightFactor: 0.4,
        child: StatefulBuilder(
          builder: (context, sets) {
              bool isValid =     widget.data.entries.map(
                    (e)=>e.value).every((item)=>item["controller"].text.toString().isNotEmpty) ;

            return Padding(
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
                              onChanged:(v)=> sets((){}),
                              textEditingController: e.value["controller"],
                              hintText: e.value["title"],
                              keyboardType: e.value["keyboardType"],
                              inputFormatters:e.value["masks"] ??  <TextInputFormatter>[],
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
                    color: isValid ?AppConstant.primaryColor  : AppConstant.greyColor1,
                    onTap: () {
                

                     if (isValid) {
                       if ((int.tryParse(widget.data["price"]["controller"].text.toString().replaceAll(" ", '')) ?? 0 )>= 1000) {
                          context.pop(widget.data);
                       } else {
                         ToastService().error(message: "Минимальная сумма 1000 сум");
                       }
                     }
                      // print(data["name"]["controller"].text);
                    },
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
