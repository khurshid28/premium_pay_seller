import 'package:intl/intl.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/core/extensions/date_extensions.dart';
import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class AllAppCard extends StatelessWidget {
  AllAppCard({super.key, required this.cardList});
  List cardList;
  var format = DateFormat('dd.MM.yyyy');

  List<Map> sortedData() {
    if (cardList.isEmpty) {
      return [];
    }
    List<Map> res = [
      {
        "date":
            format.formatUtc5(DateTime.parse(cardList[0]["createdAt"].toString())),
        "items": [cardList[0]]
      }
    ];
    for (int i = 1; i < cardList.length; i++) {
      var old = res.last;

      if (format
          .parse(format
              .formatUtc5(DateTime.parse(cardList[i]["createdAt"].toString())))
          .isBefore(format.parse(old["date"].toString()))) {
        res.add({
          "date": format
              .formatUtc5(DateTime.parse(cardList[i]["createdAt"].toString())),
          "items": [cardList[i]]
        });
      } else {
        res.last["items"] = [...res.last["items"], cardList[i]];
      }
    }
    return res;
  }

  bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  @override
  Widget build(BuildContext context) {
    List<Map> sorted = sortedData();
    return RefreshIndicator(
      color: AppConstant.primaryColor,
      displacement: 40.h,
      onRefresh: () => AppContoller.refreshAll(context),
      child: SingleChildScrollView(
        
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...List.generate(sorted.length,(index)=>  Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: index == 0 ? 8.w : 0,
            bottom: 8.w,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (!isToday(format.parse(sorted[index]["date"].toString())))
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: customDivider(),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: CustomText(
                            text: sorted[index]["date"].toString(),
                            color: AppConstant.primaryColor,
                            size: 14,
                            weight: FontWeight.w600,
                          ),
                        ),
                        Expanded(
                          child: customDivider(),
                        ),
                      ],
                    ),
                    // SizedBox(height: 8.h)
                  ],
                ),
              ...List.generate((sorted[index]["items"] ?? []).length, (i) {
                var item = sorted[index]["items"][i];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomTile(
                      app: item,
                      title: (item["fullname"] ?? "").toString(),
                      subtitle: DateFormat.Hm()
                          .formatUtc5(DateTime.parse(item["createdAt"].toString())),
                      leadingIcon: 'assets/icons/person.svg',
                      index: index,
                      status: item["status"] ?? "",
                      isHomeCard: true,
                      isTrailing: true,
                      onTap: () {
                        if ([
                          "FINISHED",
                          "CANCELED_BY_CLIENT",
                          "CANCELED_BY_SCORING",
                          "CANCELED_BY_DAILY"
                        ].contains(item["status"])) {
                          context.push('/application', extra: {
                            "id": int.tryParse(item["id"].toString()) ?? 0
                          });
                        } else {
                          context.push('/singleApplication',
                              extra: {"id": item["id"]});
                        }
                      },
                    ),
                    // if (i != (sorted[index]["items"] ?? []).length - 1)
                      // SizedBox(height: 8.h)
                  ],
                );
              }),
            ],
          ),
        ),
    )
          ],
        ),
      )
        
    );
  }
}
