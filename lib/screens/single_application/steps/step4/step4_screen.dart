import 'package:premium_pay_seller/core/extensions/number_extensions.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/widgets/common/custom_modal.dart';

// ignore: must_be_immutable
class Step4Screen extends StatefulWidget {
  Step4Screen({super.key, required this.title});
  String title;

  @override
  State<Step4Screen> createState() => _Step4ScreenState();
}

class _Step4ScreenState extends State<Step4Screen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAdd = false;

  List<Map<String, dynamic>> addProductData = [];
  // Map<String, dynamic> defaultItem = ;

  int totalPrice = 0;
  int totalCount = 0;
  bool isSelected = true;
  int? selectedIndex;

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
      customBody: step4ScreenBody(),
      resizeToAvoidBottomInset: false,
      floatingActionButtonPadding: isAdd ? 66.h : 0,
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
                },
                "count": {
                  'title': 'Количество продукта',
                  'controller': TextEditingController(text: "1"),
                },
              },
            ),
          );
          if (data != null) {
            isAdd = true;
            addProductData.add(data);
            totalPrice += int.parse(data['price']['controller'].text);
            totalCount += int.parse(data['count']['controller'].text);
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
                                text:totalCount.toString(),
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
                          4,
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
                                    text: '${(index + 1) * 3} ',
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
                                        text: '${(selectedIndex! + 1) * 3} месяц',
                                        color: AppConstant.whiteColor,
                                        size: 14,
                                        weight: FontWeight.w400,
                                      ),
                                    ],
                                  ),
                                  CustomText(
                                    text: (totalPrice * 1.41).toString(),
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
                    child: CustomContainer(
                      height: 50.h,
                      width: 1.sw,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: addProductData[index]["name"]["controller"]
                                .text,
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                          CustomText(
                            text:
                                '${int.tryParse((addProductData[index]["price"]["controller"].text).toString()).toMoney()} сум',
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: CustomButton(
                    text: 'Подтвердить информация',
                    onTap: () {},
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
