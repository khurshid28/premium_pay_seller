import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/toast.dart';

// ignore: must_be_immutable
class RelationArea extends StatefulWidget {
  RelationArea({super.key, required this.relation});
  String? relation;

  @override
  State<RelationArea> createState() => _RelationAreaState();
}

class _RelationAreaState extends State<RelationArea> {
  Map relations = {
    "FATHER": "Отец",
    "MOTHER": "Мать",
    "BROTHER/SISTER": "Брат или сестра",
    "FRIEND": "Друг/подруга",
    "OTHER": "Другой"
  };
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
                CustomText(
                  text: "Кем приходится ?",
                  color: AppConstant.blackColor,
                  size: 14,
                  weight: FontWeight.w400,
                ),
                SizedBox(
                  height: 16.h,
                ),
                ...(relations.entries.map(
                  (e) {
                    print(e);
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Row(
                        children: [
                          Radio(
                            value: e.key,
                            groupValue: widget.relation,
                            activeColor: AppConstant.primaryColor,
                            onChanged: (value) {
                              context.pop(value);
                            },
                          ),
                          CustomText(
                            text: e.value,
                            color: AppConstant.blackColor,
                            size: 16,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    );
                  },
                )),
              ],
            ),
          );
        }),
      ),
    );
  }
}
