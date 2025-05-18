import 'dart:math';

import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/screens/application/components/graphic_area.dart';
import 'package:premium_pay_seller/screens/application/components/qrcode_area.dart';
import 'package:premium_pay_seller/screens/application/components/table_area.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({super.key});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSuccsess = true;
  List<Map<String, String>> commonAreaList = [
    {
      'title': 'Имя',
      'data': 'Алишер',
    },
    {
      'title': 'Фамилия',
      'data': 'Баҳодиров',
    },
    {
      'title': 'Номер телефона',
      'data': '+998901234567',
    },
    {
      'title': 'Дата',
      'data': '24/12/2024',
    },
  ];
  List<Map<String, dynamic>> productList = [
    {
      'product': 'Iphone 16 Pro Max',
      'price': 16000000,
      'quantity': 1,
    },
    {
      'product': 'Artel TV',
      'price': 6000000,
      'quantity': 2,
    },
    {
      'product': 'LG Muzlatgich',
      'price': 8000000,
      'quantity': 1,
    },
    {
      'product': 'Samsung A50',
      'price': 5000000,
      'quantity': 1,
    },
  ];
  List<Map<String, dynamic>> graphicAreaList = [
    {
      'title': 'Срок оплаты',
      'subtitle': '12 месяцев',
      'icon': 'assets/icons/clock.svg',
      'onTap': false,
    },
    {
      'title': 'Сумма рассрочки',
      'subtitle': '38 000 000 сум',
      'icon': 'assets/icons/money.svg',
      'onTap': false,
    },
    {
      'title': 'График платежей',
      'subtitle': '2 583 333 сум в месяц',
      'icon': 'assets/icons/calendar.svg',
      'onTap': true,
    },
  ];
  List<Map<String, String>> graphicScreenList = [
    {
      'title': '1-й месяц',
      'subtitle': '01/01/2025',
      'trailing': '2 583 333 сум',
    },
    {
      'title': '2-й месяц',
      'subtitle': '01/02/2025',
      'trailing': '2 583 333 сум',
    },
    {
      'title': '3-й месяц',
      'subtitle': '01/03/2025',
      'trailing': '2 583 333 сум',
    },
    {
      'title': '4-й месяц',
      'subtitle': '01/04/2025',
      'trailing': '2 583 333 сум',
    },
    {
      'title': '5-й месяц',
      'subtitle': '01/05/2025',
      'trailing': '2 583 333 сум',
    },
    {
      'title': '6-й месяц',
      'subtitle': '01/06/2025',
      'trailing': '2 583 333 сум',
    },
    {
      'title': '7-й месяц',
      'subtitle': '01/07/2025',
      'trailing': '2 583 333 сум',
    },
    {
      'title': '8-й месяц',
      'subtitle': '01/08/2025',
      'trailing': '2 583 333 сум',
    },
    {
      'title': '9-й месяц',
      'subtitle': '01/09/2025',
      'trailing': '2 583 333 сум',
    },
    {
      'title': '10-й месяц',
      'subtitle': '01/10/2025',
      'trailing': '2 583 333 сум',
    },
    {
      'title': '11-й месяц',
      'subtitle': '01/11/2025',
      'trailing': '2 583 333 сум',
    },
    {
      'title': '12-й месяц',
      'subtitle': '01/12/2025',
      'trailing': '2 583 333 сум',
    },
  ];


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: 'ID: ${Random().nextInt(99999 + 1000000)}',
          isLeading: true,
          isHome: false,
        ),
      ),
      customBody: applicationScreenBody(),
      scaffoldKey: scaffoldKey,
    );
  }

  applicationScreenBody<Widget>() {
    return SingleChildScrollView(
      child: Column(
        children: [
          commonArea(commonAreaList),
          isSuccsess ? successArea(productList) : const SizedBox(),
        ],
      ),
    );
  }

  commonArea(List commonAreaList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ...List.generate(
              commonAreaList.length,
              (index) => Padding(
                padding: EdgeInsets.only(
                  bottom: 16.h,
                  top: index == 0 ? 16.h : 0,
                ),
                child: CustomContainer(
                  height: 40.h,
                  width: 1.sw,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                        text: commonAreaList[index]['title'],
                        color: AppConstant.blackColor,
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                      CustomText(
                        text: commonAreaList[index]['data'],
                        color: AppConstant.blackColor,
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  successArea(List productList) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Продукты',
            color: AppConstant.blackColor,
            size: 14,
            weight: FontWeight.w600,
          ),
          SizedBox(height: 16.h),
          tableArea(productList),
          graphicArea(graphicAreaList, context, graphicScreenList),
          qrcodeArea(context),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
