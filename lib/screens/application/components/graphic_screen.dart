import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class GraphicScreen extends StatefulWidget {
  GraphicScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.graphicScreenList,
  });
  String? title;
  String? subtitle;
  List? graphicScreenList;

  @override
  State<GraphicScreen> createState() => _GraphicScreenState();
}

class _GraphicScreenState extends State<GraphicScreen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: 'График платежей',
          isLeading: true,
          isHome: false,
        ),
      ),
      customBody: graphicScreenBody(),
      scaffoldKey: scaffoldKey,
    );
  }

  graphicScreenBody<Widget>() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            CustomContainer(
              height: 50.h,
              width: 1.sw,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              margin: EdgeInsets.symmetric(vertical: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: widget.title!,
                    color: AppConstant.blackColor,
                    size: 14,
                    weight: FontWeight.w400,
                  ),
                  CustomText(
                    text: widget.subtitle!,
                    color: AppConstant.blackColor,
                    size: 14,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: 'Дата платежа',
                    color: AppConstant.blackColor,
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                  CustomText(
                    text: 'Сумма платежа',
                    color: AppConstant.blackColor,
                    size: 14,
                    weight: FontWeight.w500,
                  ),
                ],
              ),
            ),
            ...List.generate(
              widget.graphicScreenList!.length,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: widget.graphicScreenList![index]['title'],
                            color: AppConstant.blackColor,
                            size: 12,
                            weight: FontWeight.w400,
                          ),
                          CustomText(
                            text: widget.graphicScreenList![index]['subtitle'],
                            color: AppConstant.blackColor,
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      CustomText(
                        text: widget.graphicScreenList![index]['trailing'],
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
}
