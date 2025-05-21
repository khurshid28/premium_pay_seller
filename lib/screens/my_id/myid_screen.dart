import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:premium_pay_seller/bloc/app/create/app_create_bloc.dart';
import 'package:premium_pay_seller/bloc/app/create/app_create_state.dart';
import 'package:premium_pay_seller/bloc/myID/myid_code_bloc.dart';
import 'package:premium_pay_seller/bloc/myID/myid_code_state.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/controller/myid_controller.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/loading.dart';
import 'package:premium_pay_seller/service/my_id.dart';
import 'package:premium_pay_seller/service/toast.dart';

// ignore: must_be_immutable
class MyIdScreen extends StatefulWidget {
  MyIdScreen({super.key});

  @override
  State<MyIdScreen> createState() => _MyIdScreenState();
}

class _MyIdScreenState extends State<MyIdScreen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController passportController = TextEditingController();

  TextEditingController dateController = TextEditingController();

  final passportMaskFormatter = MaskTextInputFormatter(
    mask: 'AA#######',
    filter: {"#": RegExp(r'[0-9]'), "A": RegExp(r'[A-Z]')},
    type: MaskAutoCompletionType.lazy,
  );

  final dateMaskFormatter = MaskTextInputFormatter(
    mask: '##/##/####', // Format: 01/04/2025
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  bool isChecked = false;
  List<Map<String, String>> step1TextField = [
    {
      'icon': 'assets/icons/passport.svg',
      'title': 'Серия и номер паспорта',
      'hint': 'AB 1231212',
    },
    {
      'icon': 'assets/icons/calendar.svg',
      'title': 'Год рождения',
      'hint': '10/07/1997',
    },
  ];

  LoadingService loadingService = LoadingService();
  ToastService toastService = ToastService();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: 'Идентификация',
          isLeading: true,
          isHome: false,
        ),
      ),
      scaffoldKey: scaffoldKey,
      customBody: myIdScreenBody(),
    );
  }

  myIdScreenBody() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: step1TextField.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: step1TextField[index]['title'].toString(),
                    color: AppConstant.blackColor,
                    size: 16,
                    weight: FontWeight.w400,
                  ),
                  SizedBox(height: 16.h),
                  CustomTextfield(
                    textCapitalization: [
                      TextCapitalization.characters,
                      null
                    ][index],
                    inputFormatters: [
                      [
                        FilteringTextInputFormatter.allow(RegExp(r'[A-Z0-9]')),
                        passportMaskFormatter
                      ],
                      [
                        dateMaskFormatter,
                      ]
                    ][index],
                    onChanged: (v) => setState(() {}),
                    textEditingController: [
                      passportController,
                      dateController
                    ][index],
                    keyboardType: [
                      TextInputType.text,
                      TextInputType.number,
                    ][index],
                    prefixIcon: CustomIcon(
                      icon: step1TextField[index]['icon'].toString(),
                      color: AppConstant.primaryColor,
                      width: 5.w,
                    ),
                    hintText: step1TextField[index]['hint'],
                  ),
                ],
              ),
            ),
          ),
          BlocListener<MyidCodeBloc, MyidCodeState>(
            child: const SizedBox(),
            listener: (context, state) async {
              if (state is MyidCodeWaitingState) {
                loadingService.showLoading(context);
              } else if (state is MyidCodeErrorState) {
                loadingService.closeLoading(context);
                toastService.error(message: state.message ?? "Xatolik Bor");
                print(state.message ?? "Xatolik Bor");
              } else if (state is MyidCodeSuccessState) {
                loadingService.closeLoading(context);

                if (mounted) {
                   AppContoller.create(context, passport: passportController.text);
                }
               

                print("Successfully Post data");
              }
            },
          ),
          BlocListener<AppCreateBloc, AppCreateState>(
            child: const SizedBox(),
            listener: (context, state) async {
              if (state is AppCreateWaitingState) {
                loadingService.showLoading(context);
              } else if (state is AppCreateErrorState) {
                loadingService.closeLoading(context);
                toastService.error(message: state.message ?? "Xatolik Bor");
                print(state.message ?? "Xatolik Bor");
              } else if (state is AppCreateSuccessState) {
                loadingService.closeLoading(context);
                 print("STATE DATA : ");
                 print(state.data);
                if (mounted) {
                  AppContoller.refreshAll(context);
                  context.replace('/singleApplication', extra: {
                    'id': state.data?["id"],
                  });
                }
                toastService.success(message: "Muvafaqqiyatli Yaratildi");

                print("Successfully Post data");
              }
            },
          ),
          const Spacer(),
          CustomIcon(
            icon: 'assets/icons/myid.svg',
            color: AppConstant.primaryColor,
            width: 300,
          ),
          const Spacer(),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.all(0),
            value: isChecked,
            activeColor: AppConstant.primaryColor,
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            onChanged: (value) {
              setState(
                () {
                  isChecked = value!;
                },
              );
            },
            title: CustomText(
              text: 'Я ознакомился с публичной офертой и согласен со всем',
              color: AppConstant.blackColor,
              size: 14,
              weight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 16.h),
          CustomButton(
            text: 'Поиск',
            color: passportController.text.length == 9 &&
                    dateController.text.length == 10 &&
                    isChecked
                ? AppConstant.primaryColor
                : AppConstant.greyColor1,
            onTap: () async {
              if (passportController.text.length == 9 &&
                  dateController.text.length == 10 &&
                  isChecked) {
                MyIdResult? data = await MyIdService().scan(
                    passport: passportController.text,
                    birthdate: dateController.text.replaceAll("/", "."));

                for (var i = 0; i < 100; i++) {
                  print("++++++++++++++++++++++++++++++++++++++++++++");
                }
                print(data.toString());

                if (data != null && data.code != null) {
                  print(data.comparison);
                  print(data.code);
                  await MyidController.code(context,
                      code: data.code,
                      passport: passportController.text.replaceAll(" ", ""),
                      comparison_value:
                          double.tryParse(data.comparison.toString()) ?? 0);
                } else {
                  toastService.error(message: "Tanib bo'lmadi");
                }
              }
            },
          ),
        ],
      ),
    );
  }
}
