import 'dart:math';

import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/screens/single_application/steps/step2/components/relation_area.dart';
import 'package:premium_pay_seller/widgets/common/custom_modal.dart';

// ignore: must_be_immutable
class CustomExpansionTile extends StatelessWidget {
  CustomExpansionTile(
      {super.key,
      required this.title,
      required this.leadingIcon,
      required this.fields,
      this.onChanged,
      this.onChangedRelation,
      this.relation});

  Map relations = {
    "FATHER": "Отец",
    "MOTHER": "Мать",
    "BROTHER/SISTER": "Брат или сестра",
    "FRIEND": "Друг/подруга",
    "OTHER": "Другой"
  };
  String title;
  String leadingIcon;
  List<Map<String, dynamic>> fields;
  void Function(String)? onChanged;

  void Function(String)? onChangedRelation;
  String? relation;

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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (fields[i]["relation"] != null)
                  Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              CustomIcon(
                                icon: "assets/icons/person.svg",
                                color: AppConstant.primaryColor,
                                width: 30.w,
                              ),
                              SizedBox(
                                width: 8.w,
                              ),
                              CustomText(
                                text: "Кем приходится ?",
                                color: AppConstant.blackColor,
                                size: 16,
                                weight: FontWeight.w400,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          CustomTextfield(
                            textEditingController:
                                TextEditingController(text: relations[relation ?? ""] ?? ""),
                            hintText: relation ?? "Выберите близкого человека",
                            readOnly: true,
                            onTap: () async {
                              var data = await showCustomModal(
                                context,
                                RelationArea(relation: relation),
                              );
                              if (data != null) {
                                onChangedRelation!(data!.toString());
                              }
                            },
                            suffixIcon: Transform.rotate(
                              angle: -pi / 2,
                              child: CustomIcon(
                                icon: "assets/icons/chevronleft.svg",
                                color: AppConstant.primaryColor,
                                width: 30.w,
                              ),
                            ),
                          ),
                        ],
                      )),
                CustomTextfield(
                  onChanged: onChanged,
                  keyboardType: fields[i]["keyboardType"],
                  readOnly: fields[i]["disable"] ?? false,
                  inputFormatters: fields[i]["masks"] ?? <TextInputFormatter>[],
                  textEditingController: fields[i]["controller"],
                  hintText: fields[i]["title"],
                  prefixIcon: fields[i]["prefix"] == null
                      ? null
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10.w),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
