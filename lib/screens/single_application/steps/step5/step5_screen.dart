import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/app/add_product/app_add_product_bloc.dart';
import 'package:premium_pay_seller/bloc/app/cancel/app_cancel_bloc.dart';
import 'package:premium_pay_seller/bloc/app/cancel/app_cancel_state.dart';
import 'package:premium_pay_seller/bloc/app/select/app_select_bloc.dart';
import 'package:premium_pay_seller/bloc/app/select/app_select_state.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/core/extensions/number_extensions.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/screens/single_application/steps/step5/components/cancel_area.dart';
import 'package:premium_pay_seller/service/loading.dart';
import 'package:premium_pay_seller/service/toast.dart';
import 'package:premium_pay_seller/widgets/common/custom_modal.dart';

// ignore: must_be_immutable
class Step5Screen extends StatefulWidget {
  Step5Screen({super.key, required this.app});
  dynamic app;

  @override
  State<Step5Screen> createState() => _Step5ScreenState();
}

class _Step5ScreenState extends State<Step5Screen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = true;
  num? Amount;
  List products = [];
  int selectedIndex = 0;
  List months = [];

  LoadingService loadingService = LoadingService();
  ToastService toastService = ToastService();
  @override
  void initState() {
    super.initState();
    months = ((widget.app["fillial"]["expired_months"] ?? []) as List)
        .where(((item) => item["active"]))
        .toList();
    Amount = widget.app["amount"];
    products = widget.app["products"] ?? [];
  }

  int GettotalCount() {
    int res = 0;
    for (var item in products) {
      res += int.tryParse((item["count"] ?? 0).toString()) ?? 0;
    }
    return res;
  }

  int GetPaymentAmount() {
    return (((widget.app["amount"] ?? 0) *
            ((100 +
                (num.tryParse(
                        months[selectedIndex ?? 0]["percent"].toString()) ??
                    0)))) ~/
        100);
  }

  int GetPaymentAmountInMonth() {
    int PaymentAmount = GetPaymentAmount();

    return PaymentAmount ~/
        (num.tryParse(months[selectedIndex]["month"].toString()) ?? 0);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: 'Оформление',
          isLeading: true,
          isHome: false,
        ),
      ),
      scaffoldKey: scaffoldKey,
      customBody: step5ScreenBody(),
    );
  }

  step5ScreenBody() {
    num limit = widget.app["limit"] ?? 0;
    int totalCount = GettotalCount();
    int PaymentAmount = GetPaymentAmount();
    int PaymentAmountInMonth = GetPaymentAmountInMonth();
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 1.sw,
          minHeight: 1.sh - 87.h,
        ),
        child: IntrinsicHeight(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                CustomContainer(
                  width: 1.sw,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
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
                                  text: '${Amount.toMoney()} сум',
                                  color: AppConstant.blackColor,
                                  size: 14,
                                  weight: FontWeight.w600,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      ExpansionTile(
                        shape: Border.all(style: BorderStyle.none),
                        childrenPadding: EdgeInsets.symmetric(horizontal: 16.w),
                        title: CustomText(
                          text: 'Состав заказа',
                          color: AppConstant.blackColor,
                          size: 14,
                          weight: FontWeight.w600,
                        ),
                        iconColor: AppConstant.primaryColor,
                        children: List.generate(
                          products.length,
                          (i) => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(
                                products[i]["count"] ?? 0,
                                (_i) => Column(
                                      children: [
                                        customDivider(),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.h),
                                          child: SizedBox(
                                            height: 30.h,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomText(
                                                  text: products[i]["name"]
                                                      .toString(),
                                                  color: AppConstant.blackColor,
                                                  size: 14,
                                                  weight: FontWeight.w400,
                                                ),
                                                CustomText(
                                                  text:
                                                      '${num.tryParse(products[i]["price"].toString()).toMoney()} сум',
                                                  color: AppConstant.blackColor,
                                                  size: 14,
                                                  weight: FontWeight.w400,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        height: 70.h,
                        width: 70.w,
                        color: selectedIndex == index
                            ? AppConstant.primaryColor
                            : Colors.transparent,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomText(
                              text: '${months[index]["month"]} ',
                              color: selectedIndex == index
                                  ? AppConstant.whiteColor
                                  : AppConstant.blackColor,
                              size: 18,
                              weight: FontWeight.w600,
                            ),
                            CustomText(
                              text: 'МЕС',
                              color: selectedIndex == index
                                  ? AppConstant.whiteColor
                                  : AppConstant.blackColor,
                              size: 12,
                              weight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                CustomContainer(
                  margin: EdgeInsets.only(top: 16.h),
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    children: [
                      CustomIcon(
                        icon: 'assets/icons/checkmark.svg',
                        color: AppConstant.greenColor,
                        width: 30,
                      ),
                      CustomText(
                        text:
                            'Оформление рассрочки на вибранный период возможно',
                        color: AppConstant.blackColor,
                        size: 14,
                        weight: FontWeight.w600,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16.h),
                      customDivider(),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Ежемесячный платеж',
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                          CustomText(
                            text: '${PaymentAmountInMonth.toMoney()} сум',
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: 'Общая сумма рассрочки',
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                          CustomText(
                            text: '${PaymentAmount.toMoney()} сум',
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                CustomText(
                  text:
                      "Расчеты произведены на основе данных предоставленных клиентом и могут отличаться от расчетов произведенных в банке",
                  color: AppConstant.blackColor,
                  size: 14,
                  weight: FontWeight.w400,
                  textAlign: TextAlign.center,
                ),
                BlocListener<AppSelectBloc, AppSelectState>(
                  child: const SizedBox(),
                  listener: (context, state) async {
                    if (state is AppSelectWaitingState) {
                      loadingService.showLoading(context);
                    } else if (state is AppSelectErrorState) {
                      loadingService.closeLoading(context);
                      toastService.error(
                          message: state.message ?? "Xatolik Bor");
                     if (kDebugMode)   print(state.message ?? "Xatolik Bor");
                    } else if (state is AppSelectSuccessState) {
                      loadingService.closeLoading(context);

                      if (mounted) {
                        AppContoller.refreshSingle(context,
                            id: int.tryParse(widget.app["id"].toString()) ?? 0);
                        context.replace(
                          '/singleApplication/step6',
                          extra: {
                            'app': state.data,
                          },
                        );
                      }
                      toastService.success(message: "Muvafaqqiyatli qo'shildi");

                    if (kDebugMode)    print("Successfully Post data");
                    }
                  },
                ),
                BlocListener<AppCancelBloc, AppCancelState>(
                  child: const SizedBox(),
                  listener: (context, state) async {
                    if (state is AppCancelWaitingState) {
                      loadingService.showLoading(context);
                    } else if (state is AppCancelErrorState) {
                      loadingService.closeLoading(context);
                      toastService.error(
                          message: state.message ?? "Xatolik Bor");
                    if (kDebugMode)    print(state.message ?? "Xatolik Bor");
                    } else if (state is AppCancelSuccessState) {
                      loadingService.closeLoading(context);
                      if (mounted) {
                        AppContoller.refreshSingle(context,
                            id: int.tryParse(widget.app["id"].toString()) ?? 0);
                        context.pushReplacement(
                          '/application',
                          extra: {
                            "id": int.tryParse(state.data["id"].toString()) ?? 0
                          },
                        );
                      }
                      toastService.success(message: "Muvafaqqiyatli bekor qilindi");

                    if (kDebugMode)    print("Successfully Post data");
                    }
                  },
                ),
                const Spacer(),
              
                CustomButton(
                  text: 'Оформить',
                  onTap: () {
                    if (limit < PaymentAmount) {
                      toastService.error(
                          message: "Ваш лимит ${limit.toMoney()} сум");
                    } else {
                      AppContoller.select(context,
                          id: int.tryParse(widget.app["id"].toString()) ?? 0,
                          expired_month:
                              months[selectedIndex]["month"].toString());
                    }
                  },
                ),
                SizedBox(height: 16.h),
                  Padding(
        padding: EdgeInsets.only(bottom: 32.h),
                  child: CustomButton(
                    color: AppConstant.redColor,
                    text: 'Отменить заявка',
                    onTap: () async {
                      var data = await showCustomModal(
                        context,
                        CancelArea(),
                      );
                      if (data != null) {
                         await AppContoller.cancel(context, id: int.tryParse(widget.app["id"].toString()) ?? 0, canceled_reason: data.toString());
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
}
