import 'package:premium_pay_seller/core/extensions/number_extensions.dart';
import 'package:premium_pay_seller/export_files.dart';

tableArea(List productList) {
  return Column(
    children: [
      Table(
        border: TableBorder.all(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.r),
            topRight: Radius.circular(10.r),
          ),
          color: AppConstant.blackColor,
          width: 0.1,
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: AppConstant.primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              ),
            ),
            children: [
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Название',
                    color: AppConstant.whiteColor,
                    size: 12,
                    weight: FontWeight.w400,
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Цена',
                    color: AppConstant.whiteColor,
                    size: 12,
                    weight: FontWeight.w400,
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Количество',
                    color: AppConstant.whiteColor,
                    size: 12,
                    weight: FontWeight.w400,
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: CustomText(
                    text: 'Сумма (сум)',
                    color: AppConstant.whiteColor,
                    size: 12,
                    weight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          ...List.generate(
            productList.length,
            (index) => TableRow(
              children: [
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: CustomText(
                      text: productList[index]['product'],
                      color: AppConstant.blackColor,
                      size: 12,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: CustomText(
                      text: (productList[index]['price'] as num?).toMoney(),
                      color: AppConstant.blackColor,
                      size: 12,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: CustomText(
                      text: productList[index]['quantity'].toString(),
                      color: AppConstant.blackColor,
                      size: 12,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.w),
                    child: CustomText(
                      text: ((productList[index]['price'] *
                              productList[index]['quantity']) as num?)
                          .toMoney(),
                      color: AppConstant.blackColor,
                      size: 12,
                      weight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      Table(
        border: TableBorder.all(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.r),
            bottomRight: Radius.circular(10.r),
          ),
          color: AppConstant.blackColor,
          width: 0.1,
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: AppConstant.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10.r),
                bottomRight: Radius.circular(10.r),
              ),
            ),
            children: [
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Center(
                    child: CustomText(
                      text: 'Общая сумма (сум)',
                      color: AppConstant.whiteColor,
                      size: 12,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              TableCell(
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Center(
                    child: CustomText(
                      text: '31 000 000',
                      color: AppConstant.whiteColor,
                      size: 12,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
