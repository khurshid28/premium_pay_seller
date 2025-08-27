import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/app/add_product/app_add_product_bloc.dart';
import 'package:premium_pay_seller/bloc/app/add_product/app_add_product_state.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/core/extensions/number_extensions.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/formatters/thousand_formatter.dart';
import 'package:premium_pay_seller/service/loading.dart';
import 'package:premium_pay_seller/service/toast.dart';
import 'package:premium_pay_seller/widgets/common/custom_modal.dart';

// ignore: must_be_immutable
class Step4Screen extends StatefulWidget {
  Step4Screen({super.key, required this.app});
  final app;

  @override
  State<Step4Screen> createState() => _Step4ScreenState();
}

class _Step4ScreenState extends State<Step4Screen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  List<Map> addProductData = [];
  // Map<String, dynamic> defaultItem = ;

  bool isSelected = true;
  int? selectedIndex;
  List months = [];

  int GettotalPrice() {
    int res = 0;
    for (var item in addProductData) {
      res += int.parse(
              item['price']['controller'].text.toString().replaceAll(" ", "")) *
          int.parse(
              item['count']['controller'].text.toString().replaceAll(" ", ""));
    }
    return res;
  }

  int GettotalCount() {
    int res = 0;
    for (var item in addProductData) {
      res += int.parse(item['count']['controller'].text.toString());
    }
    return res;
  }

  @override
  void initState() {
    super.initState();
    months = ((widget.app["fillial"]["expired_months"] ?? []) as List)
        .where(((item) => item["active"]))
        .toList();
   addProductData = ((widget.app["products"] ?? [])as List).map((e)=>{
     "name": {
                  'title': 'Название продукта',
                  'controller': TextEditingController(text: e["name"]),
                },
                "price": {
                  'title': 'Цена продукта',
                  'controller': TextEditingController(text: e["price"].toString()),
                  'keyboardType': TextInputType.number,
                  'masks': [ThousandsSeparatorInputFormatter()]
                },
                "count": {
                  'title': 'Количество продукта',
                  'keyboardType': TextInputType.number,
                  'controller': TextEditingController(text: e["count"].toString()),
                },
   }).toList();
    
  }

  LoadingService loadingService = LoadingService();
  ToastService toastService = ToastService();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: "Покупка",
          isLeading: true,
          isHome: false,
        ),
      ),
      scaffoldKey: scaffoldKey,
      customBody: step4ScreenBody(),
      resizeToAvoidBottomInset: true,
      floatingActionButtonPadding: addProductData.isNotEmpty ? 66.h : 0,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () async {
          var data = await showCustomModal(
            context,
            AddProductArea(
              data: {
                "name": {
                  'title': 'Название продукта',
                  'controller': TextEditingController(text: ""),
                },
                "price": {
                  'title': 'Цена продукта',
                  'controller': TextEditingController(text: ""),
                  'keyboardType': TextInputType.number,
                  'masks': [ThousandsSeparatorInputFormatter()]
                },
                "count": {
                  'title': 'Количество продукта',
                  'keyboardType': TextInputType.number,
                  'controller': TextEditingController(text: "1"),
                },
              },
            ),
          );
          if (data != null) {
            addProductData.add(data);
            setState(() {});
          }
        },
        child: CustomIcon(
          icon: 'assets/icons/cart.svg',
          color: AppConstant.whiteColor,
          width: 30,
        ),
      ),
    );
  }

  step4ScreenBody() {
    return addProductData.isNotEmpty ? addedProductArea() : congratsArea();
  }

  addedProductArea() {
    int totalPrice = GettotalPrice();
    int totalCount = GettotalCount();
    num PaymentAmount = ((totalPrice *
            ((100 +
                (num.tryParse(
                        months[selectedIndex ?? 0]["percent"].toString()) ??
                    0)))) ~/
        100);
    num limit = widget.app["limit"] ?? 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 1.sw,
            minHeight: 1.sh - 87.h,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomContainer(
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Все товары',
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                          CustomContainer(
                            height: 30.h,
                            width: 30.w,
                            color: AppConstant.primaryColor,
                            child: Center(
                              child: CustomText(
                                text: totalCount.toString(),
                                color: AppConstant.whiteColor,
                                size: 14,
                                weight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Общая сумма',
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                          CustomText(
                            text: '${totalPrice.toMoney()} сум',
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                CustomContainer(
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'Выберите период',
                        color: AppConstant.blackColor,
                        size: 14,
                        weight: FontWeight.w600,
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          months.length,
                          (index) => GestureDetector(
                            onTap: () {
                              selectedIndex = index;
                              setState(() {
                                isSelected = !isSelected;
                              });
                            },
                            child: CustomContainer(
                              height: 30.h,
                              width: 60.w,
                              color: selectedIndex == index
                                  ? AppConstant.primaryColor
                                  : Colors.transparent,
                              padding: EdgeInsets.only(right: 6.w),
                              margin: EdgeInsets.only(right: 16.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomIcon(
                                    icon: 'assets/icons/calendar.svg',
                                    color: selectedIndex == index
                                        ? AppConstant.whiteColor
                                        : AppConstant.primaryColor,
                                    width: 30,
                                  ),
                                  CustomText(
                                    text: '${months[index]["month"]} ',
                                    color: selectedIndex == index
                                        ? AppConstant.whiteColor
                                        : AppConstant.blackColor,
                                    size: 14,
                                    weight: FontWeight.w600,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                      CustomContainer(
                        height: 40.h,
                        width: 1.sw,
                        color: AppConstant.primaryColor,
                        padding: EdgeInsets.symmetric(horizontal: 8.w),
                        child: selectedIndex == null
                            ? Center(
                                child: CustomText(
                                  text: 'Выберите период',
                                  color: AppConstant.whiteColor,
                                  size: 14,
                                  weight: FontWeight.w400,
                                ),
                              )
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      CustomIcon(
                                        icon: 'assets/icons/calendar.svg',
                                        color: AppConstant.whiteColor,
                                        width: 30,
                                      ),
                                      CustomText(
                                        text:
                                            '${months[selectedIndex ?? 0]["month"]} месяц',
                                        color: AppConstant.whiteColor,
                                        size: 14,
                                        weight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                  CustomText(
                                    text: PaymentAmount.toMoney(),
                                    color: AppConstant.whiteColor,
                                    size: 14,
                                    weight: FontWeight.w400,
                                  ),
                                ],
                              ),
                      ),
                    ],
                  ),
                ),
                ...List.generate(
                  addProductData.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      bottom: 16.h,
                      top: index == 0 ? 16.h : 0,
                    ),
                    child: GestureDetector(
                      onTap: () async {
                        var data = await showCustomModal(
                          context,
                          AddProductArea(
                            data: addProductData[index],
                          ),
                        );
                        if (data != null) {
                          addProductData[index] = data;
                          // totalPrice += (int.parse(data['price']['controller'].text.toString().replaceAll(" ", "")) * int.parse(data['count']['controller'].text));
                          // totalCount += int.parse(data['count']['controller'].text);
                          setState(() {});
                        }
                      },
                      child: CustomContainer(
                        // height: 50.h,
                        width: 1.sw,
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 190.w,
                                  child: CustomText(
                                    text: addProductData[index]["name"]
                                            ["controller"]
                                        .text,
                                    color: AppConstant.blackColor,
                                    size: 14,
                                    weight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(
                                  height: 4.h,
                                ),
                                CustomContainer(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  color: AppConstant.primaryColor,
                                  child: CustomText(
                                    text: "x" +
                                        addProductData[index]["count"]
                                                ["controller"]
                                            .text,
                                    color: AppConstant.whiteColor,
                                    size: 12,
                                    weight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            CustomText(
                              text:
                                  '${int.tryParse((addProductData[index]["price"]["controller"].text).toString().replaceAll(" ", "")).toMoney()} сум',
                              color: AppConstant.blackColor,
                              size: 14,
                              weight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                BlocListener<AppAddProductBloc, AppAddProductState>(
                  child: const SizedBox(),
                  listener: (context, state) async {
                    if (state is AppAddProductWaitingState) {
                      loadingService.showLoading(context);
                    } else if (state is AppAddProductErrorState) {
                      loadingService.closeLoading(context);
                      toastService.error(
                          message: state.message ?? "Xatolik Bor");
                     if (kDebugMode)   print(state.message ?? "Xatolik Bor");
                    } else if (state is AppAddProductSuccessState) {
                      loadingService.closeLoading(context);

                      if (mounted) {
                        AppContoller.refreshSingle(context,
                            id: int.tryParse(widget.app["id"].toString()) ?? 0);
                        context.replace(
                          '/singleApplication/step5',
                          extra: {
                            'app':state.data,
                          },
                        );
                      }
                      toastService.success(message: "Muvafaqqiyatli qo'shildi");

                    if (kDebugMode)    print("Successfully Post data");
                    }
                  },
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: CustomButton(
                    text: 'Подтвердить информация',
                    color: selectedIndex != null && addProductData.isNotEmpty
                        ? AppConstant.primaryColor
                        : AppConstant.greyColor1,
                    onTap: () {
                      if (totalPrice < 500000) {
                        toastService.error(message: "Минимум 500 000 сум");
                      } else if (limit < PaymentAmount) {
                        toastService.error(
                            message: "Ваш лимит ${limit.toMoney()} сум");
                      } else {
                        if (selectedIndex != null &&
                            addProductData.isNotEmpty) {
                          AppContoller.addProduct(context,
                              id: int.tryParse(widget.app["id"].toString()) ??
                                  0,
                              products: addProductData
                                  .map((e) => {
                                        "name": e["name"]["controller"]
                                            .text
                                            .toString(),
                                        "price": int.tryParse(e["price"]
                                                ["controller"]
                                            .text
                                            .toString()
                                            .replaceAll(" ", "")),
                                        "count": int.tryParse(e["count"]
                                                ["controller"]
                                            .text
                                            .toString()),
                                      })
                                  .toList());
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  congratsArea() {
    return Column(
      children: [
        CustomIcon(
          icon: 'assets/icons/bags.svg',
          color: AppConstant.primaryColor,
          width: 1.sw,
        ),
        CustomText(
          text: 'Успешный!',
          color: AppConstant.blackColor,
          size: 24,
          weight: FontWeight.w400,
        ),
        CustomText(
          text: 'Добавьте ваши любимые продукты',
          color: AppConstant.greyColor,
          size: 14,
          weight: FontWeight.w200,
        ),
      ],
    );
  }
}

// Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: List.generate(
//               4,
//               (index) => CustomContainer(
//                 color:
//                     index == 3 ? AppConstant.greenColor : AppConstant.redColor,
//                 height: 50.h,
//                 width: 50.w,
//                 child: Center(
//                   child: CustomText(
//                     text: '${(index + 1) * 3}',
//                     color: AppConstant.whiteColor,
//                     size: 14,
//                     weight: FontWeight.w400,
//                   ),
//                 ),
//               ),
//             ),
//           ),
