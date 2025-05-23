import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:premium_pay_seller/bloc/app/single/single_app_bloc.dart';
import 'package:premium_pay_seller/bloc/app/single/single_app_state.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/core/extensions/number_extensions.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/screens/application/components/graphic_area.dart';
import 'package:premium_pay_seller/screens/application/components/qrcode_area.dart';
import 'package:premium_pay_seller/screens/application/components/table_area.dart';
import 'package:premium_pay_seller/widgets/common/custom_loading.dart';

class ApplicationScreen extends StatefulWidget {
  int? id;
  ApplicationScreen({super.key, required this.id});

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  // List<Map<String, String>> commonAreaList = [
  //   {
  //     'title': 'Имя',
  //     'data': 'Алишер',
  //   },
  //   {
  //     'title': 'Фамилия',
  //     'data': 'Баҳодиров',
  //   },
  //   {
  //     'title': 'Номер телефона',
  //     'data': '+998901234567',
  //   },
  //   {
  //     'title': 'Дата',
  //     'data': '24/12/2024',
  //   },
  // ];

 

 @override
  void initState() {
    AppContoller.getSingle(context, id: widget.id ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: 'ID: ${widget.id}',
          isLeading: true,
          isHome: false,
        ),
      ),
      customBody: BlocBuilder<SingleAppBloc, SingleAppState>(
        builder: (context, state) {
          if (state is SingleAppSuccessState) {
            if (state.data.isEmpty) {
              return Center(
                child: Text(
                  "Заявкa недоступн",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppConstant.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }

            return applicationScreenBody(state.data);
          } else if (state is SingleAppWaitingState) {
            return const Center(
              child: CustomLoading(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      scaffoldKey: scaffoldKey,
    );
  }

  applicationScreenBody<Widget>(data) {
    String fullname = data["fullname"].toString();
    String formatted = DateFormat('dd/MM/yyyy')
        .format(DateTime.parse(data["createdAt"].toString()));
    List<Map<String, String>> commonAreaList;

    if (data["status"] == "FINISHED") {
      commonAreaList = [
        {
          'title': 'Имя',
          'data': fullname.split(" ")[0].toString(),
        },
        {
          'title': 'Фамилия',
          'data': fullname.split(" ").length > 0
              ? fullname.split(" ")[1].toString()
              : "",
        },
        {
          'title': 'Номер телефона',
          'data': data["phone"].toString(),
        },
        {
          'title': 'Дата',
          'data': formatted,
        },
      ];
    } else {
      String whom = "";
      if (data["status"]=="CANCELED_BY_CLIENT") {
        whom ="Клиент";
      }else   if (data["status"]=="CANCELED_BY_SCORING") {
        whom ="Банк";
      }else {
        whom ="Система";
      }

      commonAreaList = [
        {
          'title': 'Имя',
          'data': fullname.split(" ")[0].toString(),
        },
        {
          'title': 'Фамилия',
          'data': fullname.split(" ").length > 1
              ? fullname.split(" ")[1].toString()
              : "",
        },
        {
          'title': 'Номер телефона',
          'data': data["phone"].toString(),
        },
        {
          'title': 'Дата',
          'data': formatted,
        },

         {
          'title': 'Кем',
          'data': whom,
        },
        {
          'title': 'Причина',
          'data':whom =="Система" ? "Автоматический" : (data["canceled_reason"] ?? ""),
        },
      ];
    }

    List<Map<String, dynamic>> productList = ((data["products"] ?? []) as List)
        .map((item) => {
              'product': item["name"] ?? "",
              'price': num.tryParse(item["price"].toString()),
              'quantity': int.tryParse(item["count"].toString()) ?? 1,
            })
        .toList();

    return SingleChildScrollView(
      child: Column(
        children: [
          commonArea(commonAreaList),
          data["status"] == "FINISHED"
              ? successArea(productList, data)
              : const SizedBox(),
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


  successArea(List productList, data) {

   

  int GetPaymentAmountInMonth() {
   

    return (num.tryParse((data["payment_amount"] ?? 0).toString()) ?? 0) ~/
    
         (num.tryParse(
                       data["expired_month"].toString()) ??
                    12);
  }
  
    List<Map<String, dynamic>> graphicAreaList = [
      {
        'title': 'Срок оплаты',
        'subtitle': '${data["expired_month"]} месяцев',
        'icon': 'assets/icons/clock.svg',
        'onTap': false,
      },
      {
        'title': 'Сумма рассрочки',
        'subtitle':
            '${num.tryParse(data["payment_amount"].toString()).toMoney()} сум',
        'icon': 'assets/icons/money.svg',
        'onTap': false,
      },
      {
        'title': 'График платежей',
        'subtitle': '${GetPaymentAmountInMonth().toMoney()} сум в месяц',
        'icon': 'assets/icons/calendar.svg',
        'onTap': true,
      },
    ];

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
          tableArea(productList,num.tryParse(data["amount"].toString())),
          graphicArea(graphicAreaList, data,context,),
          // qrcodeArea(context),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
