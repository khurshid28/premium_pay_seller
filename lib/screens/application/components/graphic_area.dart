import 'package:premium_pay_seller/export_files.dart';

graphicArea(List graphicAreaList, BuildContext context, List graphicScreenList) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: [
      ...List.generate(
        graphicAreaList.length,
        (index) => Padding(
          padding: EdgeInsets.only(
            bottom: 16.h,
            top: index == 0 ? 16.h : 0,
          ),
          child: CustomContainer(
            height: 50.h,
            width: 1.sw,
            child: ListTile(
              minTileHeight: 50.h,
              horizontalTitleGap: 10.w,
              isThreeLine: false,
              onTap: graphicAreaList[index]['onTap']
                  ? () {
                      context.pushNamed(
                        'graphic',
                        extra: {
                          'graphicScreenList': graphicScreenList,
                        },
                        queryParameters: {
                          'title': graphicAreaList[index]['title'],
                          'subtitle': graphicAreaList[index]['subtitle'],
                        },
                      );
                    }
                  : () {},
              leading: CustomContainer(
                height: 30.h,
                width: 30.w,
                color: AppConstant.primaryColor,
                child: CustomIcon(
                  icon: graphicAreaList[index]['icon'],
                  color: AppConstant.whiteColor,
                  width: 25,
                ),
              ),
              title: CustomText(
                text: graphicAreaList[index]['title'],
                color: AppConstant.blackColor,
                size: 14,
                weight: FontWeight.w400,
              ),
              subtitle: CustomText(
                text: graphicAreaList[index]['subtitle'],
                color: AppConstant.primaryColor,
                size: 12,
                weight: FontWeight.w400,
              ),
              trailing: graphicAreaList[index]['onTap']
                  ? CustomIcon(
                      icon: 'assets/icons/chevronright.svg',
                      color: AppConstant.primaryColor,
                      width: 20,
                    )
                  : const SizedBox(),
            ),
          ),
        ),
      ),
    ],
  );
}
