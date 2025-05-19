import 'package:intl/intl.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/core/extensions/number_extensions.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/widgets/common/custom_tile_single.dart';

// ignore: must_be_immutable
class SingleCard extends StatelessWidget {
  SingleCard({super.key, required this.cardList, required this.data});
  List cardList;
  dynamic data;
  AppPermission permission(String link) {
    String status = data["status"] ?? "";
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
        if (link == "step1" || link == "step2" || link == "step3") {
          return AppPermission(allowed: false, passed: true);
        } else if (link == "step4") {
          return AppPermission(allowed: true, passed: false);
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

      case "WAITING_BANK_COMFIRM":
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

      case "FINISHED":
        return AppPermission(allowed: true, passed: true);

      default:
    }
    return AppPermission(allowed: false, passed: false);
  }

  String getSubtitle(AppPermission appPermission, String link) {
    if (appPermission.passed) {

      
  
         
      switch (link) {
        case "step1":
          return  "Имя: ${data["fullname"].toString().split(" ").take(2).toList().join(" ")}";
        case "step2":
          return  "Номер телефона: ${data['phone']}";
        case "step3":
        num? limit = num.tryParse(data['limit'].toString());
    
          return "Лимит: ${ limit.toMoney()} сум";
        case "step4":
        List products = data["products"] ?? [];
        num? amount = num.tryParse(data['amount'].toString());
          return  "Товаров: ${products.length}︱${amount.toMoney()} сум";
        case "step5":
         num? payment_amount = num.tryParse(data['payment_amount'].toString());
          return  "Месяцев: ${data['expired_month']}︱${payment_amount.toMoney()} сум";
        case "step6":
          return  "Дата погашения: ${DateFormat("d MMMM y 'г'", 'ru').format(DateTime.parse(data["createdAt"].toString()))}";

        default:
          return "";
      }
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
  
    return RefreshIndicator(
      color: AppConstant.primaryColor,
      displacement: 40.h,
      elevation: 0,
      onRefresh: () => AppContoller.refreshSingle(context,
          id: int.tryParse(data["id"].toString()) ?? 0),
      backgroundColor: Colors.transparent,
      child: ListView.builder(
        itemCount: cardList.length,
          physics:const AlwaysScrollableScrollPhysics(),
          primary: true,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
            AppPermission appPermission  = permission(cardList[index]['link'].toString());
            String subtitle = getSubtitle(appPermission, cardList[index]['link'].toString());
          return   Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: index == 0 ? 16.w : 0,
            bottom: 16.w,
          ),
          child: CustomTileSingle(
            title: cardList[index]['title'],
            subtitle: subtitle,
            leadingIcon: cardList[index]['icon'],
            index: index,
            isHomeCard: false,
            isTrailing: true,
            permission: appPermission,
            status: cardList[index]['status'].toString(),
            onTap: () {
              context.pushNamed(
                cardList[index]['link'],
                extra: {
                  'title': cardList[index]['title'],
                   'app': data,
                },
              );
            },
          ),
        );
     
        }
        
        ),
    );
  }
}

class AppPermission {
  bool allowed = false;
  bool passed = false;
  AppPermission({required this.allowed, required this.passed});
}
