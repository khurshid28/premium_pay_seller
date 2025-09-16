import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:premium_pay_seller/bloc/app/add_detail/app_add_detail_bloc.dart';
import 'package:premium_pay_seller/bloc/app/add_detail/app_add_detail_state.dart';
import 'package:premium_pay_seller/bloc/app/profile/app_profile_bloc.dart';
import 'package:premium_pay_seller/bloc/app/profile/app_profile_state.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/fio/fio_validation.dart';
import 'package:premium_pay_seller/service/loading.dart';
import 'package:premium_pay_seller/service/toast.dart';
import 'package:premium_pay_seller/widgets/common/custom_loading.dart';

// ignore: must_be_immutable
class Step2Screen extends StatefulWidget {
  final app;
  // String? title;
  Step2Screen({
    super.key,
    required this.app,
  });

  @override
  State<Step2Screen> createState() => _Step2ScreenState();
}

class _Step2ScreenState extends State<Step2Screen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  final phoneMaskFormatter = MaskTextInputFormatter(
    mask: '## ### ## ##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  TextEditingController phoneController = TextEditingController();
  TextEditingController rNameController = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    AppContoller.getProfile(context,
        id: int.tryParse(widget.app["id"].toString()) ?? 0);
  }

  @override
  void dispose() {
    phone2Controller.clear();
    phoneController.clear();
    super.dispose();
  }

  LoadingService loadingService = LoadingService();
  ToastService toastService = ToastService();
  Map relations = {
    "FATHER": "Отец",
    "MOTHER": "Мать",
    "BROTHER/SISTER": "Брат или сестра",
    "FRIEND": "Друг/подруга",
    "OTHER": "Другой"
  };
  String? selectedRelation;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: "Данные клиента",
          isLeading: true,
          isHome: false,
        ),
      ),
      scaffoldKey: scaffoldKey,
      customBody: BlocBuilder<AppProfileBloc, AppProfileState>(
        builder: (context, state) {
          if (state is AppProfileSuccessState) {
            return step2ScreenBody(state.data);
          } else if (state is AppProfileWaitingState) {
            return const Center(
              child: CustomLoading(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  step2ScreenBody(data) {
    String first_name =
        data["profile"]?["common_data"]?["first_name"] ?? "NOMA'LUM";
    String middle_name =
        data["profile"]?["common_data"]?["middle_name"] ?? "NOMA'LUM";
    String last_name =
        data["profile"]?["common_data"]?["last_name"] ?? "NOMA'LUM";
    String regionName = data["profile"]?["address"]?["permanent_registration"]
            ?["region"] ??
        "NOMA'LUM";
    String districtName = data["profile"]?["address"]?["permanent_registration"]
            ?["district"] ??
        "NOMA'LUM";
    String homeName =
        data["profile"]?["address"]?["permanent_address"] ?? "NOMA'LUM";

    List<Map<String, dynamic>> step2CustomTileData = [
      {
        'title': 'Имя клиента',
        'icon': 'assets/icons/person.svg',
        'fields': [
          {
            "title": 'Имя',
            "controller": TextEditingController(text: first_name),
            "disable": true,
          },
          {
            "title": 'Фамилия',
            "disable": true,
            "controller": TextEditingController(text: middle_name),
          },
          {
            "title": 'Отчества',
            "disable": true,
            "controller": TextEditingController(text: last_name),
          },
        ],
      },
      {
        'title': 'Адресные данные',
        'icon': 'assets/icons/location.svg',
        'fields': [
          {
            "title": 'Область',
            "controller": TextEditingController(text: regionName),
            "disable": true,
          },
          {
            "title": 'Город / район проживания',
            "controller": TextEditingController(text: districtName),
            "disbale": true,
          },
          {
            "title": 'Адрес',
            "controller": TextEditingController(text: homeName),
            "disable": true,
          },
        ],
      },
      {
        'title': 'Номер телефона клиента',
        'icon': 'assets/icons/phone.svg',
        'fields': [
          {
            "title": '90 123 45 67',
            "controller": phoneController,
            "prefix": "+998",
            "disable": false,
            "keyboardType": TextInputType.number,
            "masks": [
              phoneMaskFormatter,
            ]
          },
          {
            "title": 'Ф.И.О',
            "relation": true,
            "controller": rNameController,
            "disable": false,
            "keyboardType": TextInputType.name,
            'validator' : fioValidator
          },
          {
            "title": '90 123 45 67',
            "keyboardType": TextInputType.number,
            "controller": phone2Controller,
            "prefix": "+998",
            "disable": false,
            "masks": [
              phoneMaskFormatter,
            ]
          },
        ],
      },
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: 1.sw,
            minHeight: 1.sh - 95.h,
          ),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                ...List.generate(
                  step2CustomTileData.length,
                  (index) => Padding(
                    padding: EdgeInsets.only(
                      bottom: 16.h,
                      top: index == 0 ? 16.h : 0,
                    ),
                    child: CustomExpansionTile(
                      bordercolor: AppConstant.primaryColor,
                      borderWidth: 1.2,
                      onChanged: (v) => setState(() {}),
                      title: step2CustomTileData[index]['title'],
                      leadingIcon: step2CustomTileData[index]['icon'],
                      fields: step2CustomTileData[index]['fields'],
                      relation: selectedRelation,
                      onChangedRelation: (r) {
                        setState(() {
                          selectedRelation = r;
                        });
                      },
                    ),
                  ),
                ),
                const Spacer(),
                BlocListener<AppAddDetailBloc, AppAddDetailState>(
                  child: const SizedBox(),
                  listener: (context, state) async {
                    if (state is AppAddDetailWaitingState) {
                      loadingService.showLoading(context);
                    } else if (state is AppAddDetailErrorState) {
                      loadingService.closeLoading(context);
                      toastService.error(
                          message: state.message ?? "Xatolik Bor");
                      if (kDebugMode) print(state.message ?? "Xatolik Bor");
                    } else if (state is AppAddDetailSuccessState) {
                      loadingService.closeLoading(context);

                      if (mounted) {
                        AppContoller.refreshSingle(context,
                            id: int.tryParse(widget.app["id"].toString()) ?? 0);
                        context.replace(
                          '/singleApplication/step3',
                          extra: {
                            'app': state.data,
                          },
                        );
                      }
                      toastService.success(message: "Muvafaqqiyatli qo'shildi");

                      if (kDebugMode) print("Successfully Post data");
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 64.h),
                  child: CustomButton(
                    text: 'Подтвердить информация',
                    color: phoneController.text.length == 12 &&
                            phone2Controller.text.length == 12 &&
                            selectedRelation != null &&
                            rNameController.text.isNotEmpty && fioValidator(rNameController.text)  == null
                        ? AppConstant.primaryColor
                        : AppConstant.greyColor1,
                    onTap: () {
                      if (phoneController.text.length == 12 &&
                          phone2Controller.text.length == 12 &&
                          selectedRelation != null &&
                          rNameController.text.isNotEmpty && fioValidator(rNameController.text)  == null) {
                        AppContoller.addDetail(context,
                            id: int.tryParse(widget.app["id"].toString()) ?? 0,
                            phone: "+998" +
                                phoneController.text.replaceAll(" ", ""),
                            phone2: "+998" +
                                phone2Controller.text.replaceAll(" ", ""),
                            relation: selectedRelation,
                            relationName: rNameController.text);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
