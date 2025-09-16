import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:premium_pay_seller/bloc/app/finish/app_finish_bloc.dart';
import 'package:premium_pay_seller/bloc/app/finish/app_finish_state.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/core/extensions/date_extensions.dart';
import 'package:premium_pay_seller/core/extensions/number_extensions.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/loading.dart';
import 'package:premium_pay_seller/service/toast.dart';
import 'package:premium_pay_seller/widgets/common/custom_tile_single.dart';

// ignore: must_be_immutable
class SingleCard extends StatefulWidget {
  SingleCard({super.key, required this.cardList, required this.data});
  List cardList;
  dynamic data;

  @override
  State<SingleCard> createState() => _SingleCardState();
}

class _SingleCardState extends State<SingleCard> {
  LoadingService loadingService = LoadingService();
  ToastService toastService = ToastService();
  AppPermission permission(String link) {
    //check qiliw kk
    //  return AppPermission(allowed: true, passed: true);
    String status = widget.data["status"] ?? "";
    switch (status) {
      case "CREATED":
        if (link == "step1") {
          return AppPermission(allowed: false, passed: true);
        } else if (link == "step2") {
          return AppPermission(allowed: true, passed: false);
        }
        break;

      case "ADDED_DETAIL":
        if (link == "step1" || link == "step2") {
          return AppPermission(allowed: false, passed: true);
        } else if (link == "step3") {
          return AppPermission(allowed: true, passed: false);
        }
        break;

      case "WAITING_SCORING":
        if (link == "step1" || link == "step2") {
          return AppPermission(allowed: false, passed: true);
        } else if (link == "step3") {
          return AppPermission(allowed: true, passed: true);
        }
        break;

      case "LIMIT":
        if (link == "step1" || link == "step2" || link == "step3") {
          return AppPermission(allowed: false, passed: true);
        } else if (link == "step4") {
          return AppPermission(allowed: true, passed: false);
        }
        break;
      case "ADDED_PRODUCT":
        if (link == "step1" || link == "step2" || link == "step3") {
          return AppPermission(allowed: false, passed: true);
        } else if (link == "step4") {
          return AppPermission(allowed: true, passed: true);
        } else if (link == "step5") {
          return AppPermission(allowed: true, passed: false);
        }
        break;

      case "WAITING_BANK_UPDATE":
        if (link == "step1" ||
            link == "step2" ||
            link == "step3" ||
            link == "step4" ||
            link == "step5") {
          return AppPermission(allowed: false, passed: true);
        } else if (link == "step6") {
          return AppPermission(allowed: true, passed: false);
        }
        break;

      case "WAITING_BANK_CONFIRM":
        if (link == "step1" ||
            link == "step2" ||
            link == "step3" ||
            link == "step4" ||
            link == "step5") {
          return AppPermission(allowed: false, passed: true);
        } else if (link == "step6") {
          return AppPermission(allowed: true, passed: false);
        }
        break;

      case "CONFIRMED":
        //changed now
        return AppPermission(allowed: false, passed: true);

      case "FINISHED":
        return AppPermission(allowed: false, passed: true);

      default:
    }
    return AppPermission(allowed: false, passed: false);
  }

  String getSubtitle(AppPermission appPermission, String link) {
    if (appPermission.passed) {
      switch (link) {
        case "step1":
          return "Имя: ${widget.data["fullname"].toString().split(" ").take(2).toList().join(" ")}";
        case "step2":
          return "Номер телефона: ${widget.data['phone']}";
        case "step3":
          if (widget.data["status"] == "WAITING_SCORING") {
            return "Ожидающий";
          }
          num? limit = num.tryParse(widget.data['limit'].toString());

          return "Лимит: ${limit.toMoney()} сум";
        case "step4":
          List products = widget.data["products"] ?? [];
          num? amount = num.tryParse(widget.data['amount'].toString());
          return "Товаров: ${products.length}︱${amount.toMoney()} сум";
        case "step5":
          num? payment_amount =
              num.tryParse(widget.data['payment_amount'].toString());
          return "Месяцев: ${widget.data['expired_month']}︱${payment_amount.toMoney()} сум";
        case "step6":
          return "Дата погашения: ${DateFormat("d MMMM y 'г'", 'ru').formatUtc5(DateTime.parse(widget.data["createdAt"].toString()))}";

        default:
          return "";
      }
    }
    return "";
  }

  bool IsConfirmed() {
    return widget.data['status'].toString() == "CONFIRMED";
  }

  @override
  Widget build(BuildContext context) {
    bool isConfirmed = IsConfirmed();
    return RefreshIndicator(
      color: AppConstant.primaryColor,
      displacement: 40.h,
      elevation: 0,
      onRefresh: () => AppContoller.refreshSingle(context,
          id: int.tryParse(widget.data["id"].toString()) ?? 0),
      backgroundColor: Colors.transparent,
      child: BlocListener<AppFinishBloc, AppFinishState>(
        child: ListView.builder(
            itemCount: widget.cardList.length + (isConfirmed ? 1 : 0),
            physics: const AlwaysScrollableScrollPhysics(),
            primary: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              if (isConfirmed && index == widget.cardList.length) {
                return Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 8.h,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 8.h),
                        child: CustomText(
                          text:
                              'Оформления прошли успешно, клиент может забрать товар.',
                          color: AppConstant.primaryColor,
                          size: 14,
                          weight: FontWeight.w400,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      CustomButton(
                        text: 'Закончить',
                        onTap: () {
                          AppContoller.finish(
                            context,
                            id: int.tryParse(widget.data["id"].toString()) ?? 0,
                          );
                        },
                      ),
                    ],
                  ),
                );
              }
              AppPermission appPermission =
                  permission(widget.cardList[index]['link'].toString());
              String subtitle = getSubtitle(
                  appPermission, widget.cardList[index]['link'].toString());
              return Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: index == 0 ? 8.w : 0,
                  bottom: 8.w,
                ),
                child: CustomTileSingle(
                  title: widget.cardList[index]['title'],
                  subtitle: subtitle,
                  leadingIcon: widget.cardList[index]['icon'],
                  index: index,
                  isHomeCard: false,
                  isTrailing: true,
                  permission: appPermission,
                  status: widget.cardList[index]['status'].toString(),
                  onTap: () {
                    context.pushNamed(
                      widget.cardList[index]['link'],
                      extra: {
                        'title': widget.cardList[index]['title'],
                        'app': widget.data,
                      },
                    );
                  },
                ),
              );
            }),
        listener: (context, state) async {
          if (state is AppFinishWaitingState) {
            loadingService.showLoading(context);
          } else if (state is AppFinishErrorState) {
            loadingService.closeLoading(context);
            toastService.error(message: state.message ?? "Xatolik Bor");
            if (kDebugMode) print(state.message ?? "Xatolik Bor");
          } else if (state is AppFinishSuccessState) {
            loadingService.closeLoading(context);

            if (mounted) {
              int id = int.tryParse(widget.data["id"].toString()) ?? 0;
              AppContoller.refreshSingle(context, id: id);
              context.go(
                '/application',
                extra: {
                  'id': id,
                },
              );
            }
            toastService.success(message: "Muvafaqqiyatli Tugatildi");

            if (kDebugMode) print("Successfully Post data");
          }
        },
      ),
    );
  }
}

class AppPermission {
  bool allowed = false;
  bool passed = false;
  AppPermission({required this.allowed, required this.passed});
}
