import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class Step1Screen extends StatefulWidget {
  Step1Screen({super.key, required this.title});
  String title;

  @override
  State<Step1Screen> createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController step1Controller = TextEditingController();
  bool isChecked = false;
  List<Map<String, String>> step1TextField = [
    {
      'icon': 'assets/icons/passport.svg',
      'title': 'Серия и номер паспорта',
      'hint': 'AB 1231212',
    },
    {
      'icon': 'assets/icons/calendar.svg',
      'title': 'Год рождения',
      'hint': '10/07/1997',
    },
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: widget.title,
          isLeading: true,
          isHome: false,
        ),
      ),
      scaffoldKey: scaffoldKey,
      customBody: step1ScreenBody(),
    );
  }

  step1ScreenBody() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: step1TextField.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: step1TextField[index]['title'].toString(),
                    color: AppConstant.blackColor,
                    size: 16,
                    weight: FontWeight.w400,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextfield(
                    textEditingController: step1Controller,
                    keyboardType: TextInputType.phone,
                    prefixIcon: CustomIcon(
                      icon: step1TextField[index]['icon'].toString(),
                      color: AppConstant.primaryColor,
                      width: 5.w,
                    ),
                    hintText: step1TextField[index]['hint'],
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          CustomIcon(
            icon: 'assets/icons/myid.svg',
            color: AppConstant.primaryColor,
            width: 300,
          ),
          const Spacer(),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.all(0),
            value: isChecked,
            activeColor: AppConstant.primaryColor,
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            onChanged: (value) {
              setState(
                () {
                  isChecked = value!;
                },
              );
            },
            title: CustomText(
              text: 'Я ознакомился с публичной офертой и согласен со всем',
              color: AppConstant.blackColor,
              size: 14,
              weight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          CustomButton(
            text: 'Поиск',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
