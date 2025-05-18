import 'package:premium_pay_seller/export_files.dart';

class FilterArea extends StatefulWidget {
  const FilterArea({super.key});

  @override
  State<FilterArea> createState() => _FilterAreaState();
}

class _FilterAreaState extends State<FilterArea> {
  List<String> statusString = [
    'Завершен',
    'Ожидающий',
    'Отказано',
  ];
  List<Color> color = [
    AppConstant.greenColor,
    AppConstant.blueColor,
    AppConstant.redColor,
  ];
  List<bool> check1 = [false, false, false];
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8.h,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            filterHeader(),
            customDivider(),
            statusFilter(),
            dateFilter(),
            CustomButton(
              text: 'Применить',
              onTap: () {
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  filterHeader<Widget>() {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            text: 'Филтер',
            color: AppConstant.blackColor,
            size: 18,
            weight: FontWeight.w500,
          ),
          GestureDetector(
            onTap: () {
              check1 = [false, false, false];
              setState(() {});
            },
            child: CustomText(
              text: 'Очистить',
              color: AppConstant.primaryColor,
              size: 14,
              weight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }

  statusFilter<Widget>() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        3,
        (index) => CustomContainer(
          margin: EdgeInsets.only(bottom: 16.h, top: index == 0 ? 16.h : 0),
          child: CheckboxListTile(
            activeColor: AppConstant.primaryColor,
            side: BorderSide(width: 0.2.w),
            controlAffinity: ListTileControlAffinity.leading,
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            title: CustomText(
              text: statusString[index],
              color: color[index],
              size: 16,
              weight: FontWeight.w400,
            ),
            value: check1[index],
            onChanged: (value) {
              check1[index] = value!;
              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  dateFilter<Widget>() {
    return CustomContainer(
      padding: EdgeInsets.all(5.w),
      margin: EdgeInsets.only(bottom: 16.h),
      child: SfDateRangePicker(
        showActionButtons: false,
        view: DateRangePickerView.month,
        monthViewSettings: const DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
        selectionMode: DateRangePickerSelectionMode.range,
        backgroundColor: AppConstant.whiteColor,
        headerStyle: const DateRangePickerHeaderStyle(
          backgroundColor: AppConstant.whiteColor,
          textAlign: TextAlign.center,
        ),
        headerHeight: 50.h,
        rangeSelectionColor: AppConstant.primaryColor.withOpacity(0.1),
        startRangeSelectionColor: AppConstant.primaryColor,
        endRangeSelectionColor: AppConstant.primaryColor,
        todayHighlightColor: AppConstant.primaryColor,
        monthCellStyle: DateRangePickerMonthCellStyle(
          todayTextStyle: const TextStyle(
            color: AppConstant.blackColor,
            fontWeight: FontWeight.w600,
          ),
          todayCellDecoration: BoxDecoration(
            border: Border.all(
              style: BorderStyle.none,
            ),
          ),
        ),
        rangeTextStyle: TextStyle(
          fontSize: 14.sp,
          color: AppConstant.blackColor,
        ),
        selectionTextStyle: TextStyle(
          fontSize: 14.sp,
          color: AppConstant.whiteColor,
        ),
      ),
    );
  }
}
