import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/toast.dart';

// ignore: must_be_immutable
class CancelArea extends StatefulWidget {
  CancelArea({super.key});

  @override
  State<CancelArea> createState() => _CancelModalState();
}

class _CancelModalState extends State<CancelArea> {
  List<String> cancels = [
    'Клиент ушел с магазина',
    'Не хватало по лимита',
    'Клиент отказался',
    'Другой',
  ];
  String? selectText;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom:
            MediaQuery.of(context).viewInsets.bottom, // keyboard ga moslashadi
      ),
      child: IntrinsicHeight(
        // heightFactor: 0.4,
        child: StatefulBuilder(builder: (context, sets) {
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...(cancels.map(
                  (e) {
                    return GestureDetector(
                      onTap: () {
                        sets(() {
                          selectText = e;
                        });
                      },
                      child: Container(
                        width: 1.sw - 32.w,
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              selectText == e
                                  ?  CustomContainer(
                                      child:  Center(
                                        child: Icon(
                                          Icons.check,
                                          color: AppConstant.whiteColor,
                                          size: 15,
                                          weight: 0.4,
                                        ),
                                      ),
                                      width: 28.w,
                                      height: 28.w,
                                      color: AppConstant.primaryColor,
                                    )
                                  : CustomContainer(
                                      child: SizedBox(),
                                      width: 28.w,
                                      height: 28.w,
                                      bordercolor: AppConstant.greyColor1,
                                      borderWidth: 1.5,
                                    ),
                              SizedBox(
                                width: 10.w,
                              ),
                              CustomText(
                                text: e,
                                color: AppConstant.blackColor,
                                size: 14,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )),
                CustomButton(
                  text: 'Применить',
                  color: selectText != null
                      ? AppConstant.primaryColor
                      : AppConstant.greyColor1,
                  onTap: () {
                    if (selectText != null) {
                      context.pop(selectText);
                    }
                    // print(data["name"]["controller"].text);
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
