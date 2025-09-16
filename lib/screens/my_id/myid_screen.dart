import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:premium_pay_seller/bloc/app/create/app_create_bloc.dart';
import 'package:premium_pay_seller/bloc/app/create/app_create_state.dart';
import 'package:premium_pay_seller/bloc/myID/myid_code_bloc.dart';
import 'package:premium_pay_seller/bloc/myID/myid_code_state.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/controller/myid_controller.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/date/date_validation.dart';
import 'package:premium_pay_seller/service/formatters/uppercase_formatter.dart';
import 'package:premium_pay_seller/service/loading.dart';
import 'package:premium_pay_seller/service/my_id.dart';
import 'package:premium_pay_seller/service/toast.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
      'hint': 'AB1231212',
    },
    {
      'icon': 'assets/icons/calendar.svg',
      'title': 'Год рождения',
      'hint': '10/07/1997',
    },
  ];

  LoadingService loadingService = LoadingService();
  ToastService toastService = ToastService();
  Future showOferta() async {
    return await showModalBottomSheet(
      isDismissible: true,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: Colors.white,
      context: context,
      builder: (builder) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 0.2.sh),
              child: SizedBox(
                  height: 0.8.sh,
                  child: SfPdfViewer.asset(
                    'assets/public-oferta.pdf',
                  )),
            ),
            Positioned(
                bottom: 36.0.h,
                left: 16.0,
                right: 16.0,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: CustomButton(
                      text: "Согласен",
                      onTap: () {
                        Navigator.pop(context, "success");
                      }),
                )

                // ElevatedButton(
                //   style: ElevatedButton.styleFrom(
                //     fixedSize: Size(
                //       MediaQuery.of(context).size.width,
                //       40.0,
                //     ),
                //   ),
                //   onPressed: () {

                //   },
                //   child: const Text('Qabul qildim'),
                // ),
                ),
          ],
        );
      },
    );
  }

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

  String selected = ''; // Да yoki Нет

  myIdScreenBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: "Вы имеете официальное место работы?",
            color: AppConstant.blackColor,
            size: 16,
            weight: FontWeight.w400,
          ),
          Row(
            children: [
              Radio(
                value: 'Да',
                groupValue: selected,
                activeColor: AppConstant.primaryColor,
                onChanged: (value) {
                  setState(() {
                    selected = value!;
                  });
                },
              ),
              CustomText(
                text: "Да",
                color: AppConstant.blackColor,
                size: 16,
                weight: FontWeight.w400,
              ),
              Radio(
                value: 'Нет',
                groupValue: selected,
                activeColor: AppConstant.primaryColor,
                onChanged: (value) {
                  setState(() {
                    selected = value!;
                  });
                },
              ),
              CustomText(
                text: "Нет",
                color: AppConstant.blackColor,
                size: 16,
                weight: FontWeight.w400,
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: step1TextField.length,
            itemBuilder: (context, index) => Padding(
              padding: EdgeInsets.only(bottom: 8.h),
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
                  SizedBox(height: 12.h),
                  CustomTextfield(
                    textCapitalization: [
                      TextCapitalization.characters,
                      null
                    ][index],
                    inputFormatters: [
                      [
                        UpperCaseTextFormatter(),
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9]')),
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
                if (kDebugMode) {
                  print(state.message ?? "Xatolik Bor");
                }
              } else if (state is MyidCodeSuccessState) {
                loadingService.closeLoading(context);

                if (mounted) {
                  AppContoller.create(context,
                      passport: passportController.text);
                }

                if (kDebugMode) print("Successfully Post data");
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
                if (kDebugMode) print(state.message ?? "Xatolik Bor");
              } else if (state is AppCreateSuccessState) {
                loadingService.closeLoading(context);
                if (kDebugMode) print("STATE DATA : ");
                if (kDebugMode) print(state.data);
                if (mounted) {
                  AppContoller.refreshAll(context);
                  context.replace('/singleApplication', extra: {
                    'id': state.data?["id"],
                  });
                }
                toastService.success(message: "Muvafaqqiyatli Yaratildi");

                if (kDebugMode) print("Successfully Post data");
              }
            },
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIcon(
                  icon: 'assets/icons/myid.svg',
                  color: AppConstant.primaryColor,
                  width: 120.w,
                ),
              ],
            ),
          ),
          CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: const EdgeInsets.all(0),
            value: isChecked,
            activeColor: AppConstant.primaryColor,
            checkboxShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
            onChanged: (value) async {
              if (selected == "Да") {
                if (!isChecked) {
                  if ((await showOferta()) != null) {
                    isChecked = true;
                  }
                } else {
                  isChecked = false;
                }
                setState(() {});
              } else {
                toastService.error(
                    message:
                        "Обслуживание доступно только официально трудоустроенным клиентам");
              }
            },
            title: CustomText(
              text: 'Я ознакомился с публичной офертой и согласен со всем',
              color: AppConstant.blackColor,
              size: 14,
              weight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(bottom: 16.h),
            child: CustomButton(
              text: 'Поиск',
              color: passportController.text.length == 9 &&
                      dateController.text.length == 10 &&
                      isChecked &&
                      selected == "Да"
                  ? AppConstant.primaryColor
                  : AppConstant.greyColor1,
              onTap: () async {
                if (passportController.text.length == 9 &&
                    dateController.text.length == 10 &&
                    isChecked &&
                    selected == "Да") {
                  String? validationRes =
                      dateFormValidator(dateController.text);
                  if (validationRes == null) {
                    final data = await MyIdService().scan(
                        passport: passportController.text,
                        birthdate: dateController.text.replaceAll("/", "."));
                    if (data is MyIdResult?) {
                      if (kDebugMode) {
                        for (var i = 0; i < 100; i++) {
                          print("++++++++++++++++++++++++++++++++++++++++++++");
                        }
                      }
                      if (kDebugMode) print(data.toString());

                      if (data != null && data.code != null) {
                        if (kDebugMode) print(data.comparison);
                        if (kDebugMode) print(data.code);
                        await MyidController.code(context,
                            code: data.code,
                            passport:
                                passportController.text.replaceAll(" ", ""),
                            comparison_value:
                                double.tryParse(data.comparison.toString()) ??
                                    0);
                      } else {
                        toastService.error(message: "Tanib bo'lmadi");
                      }
                    } else if (data is PlatformException) {
                      final parts = data.message.toString().split(' - ');
                      final errorText =
                          parts.length > 1 ? parts[1] : data.message;
                      toastService.error(
                          message: errorText ?? "Tanib bo'lmadi");
                    } else if (data is Error) {
                      toastService.error(
                          message: data.stackTrace == null
                              ? "Tanib bo'lmadi"
                              : data.stackTrace.toString());
                    } else if (data is PlatformException) {
                      final parts = data.message.toString().split(' - ');
                      final errorText =
                          parts.length > 1 ? parts[1] : data.message;
                      toastService.error(
                          message: errorText ?? "Tanib bo'lmadi");
                    }
                  } else {
                    toastService.error(message: validationRes);
                  }
                } else if (selected == "Нет") {
                  toastService.error(
                      message:
                          "Обслуживание доступно только официально трудоустроенным клиентам");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
