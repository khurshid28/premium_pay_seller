import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/app/profile/app_profile_bloc.dart';
import 'package:premium_pay_seller/bloc/app/profile/app_profile_state.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/widgets/common/custom_loading.dart';

// ignore: must_be_immutable
class Step2Screen extends StatefulWidget {
  final app;
  String? title;
  Step2Screen({super.key, required this.app,required this.title});

  @override
  State<Step2Screen> createState() => _Step2ScreenState();
}

class _Step2ScreenState extends State<Step2Screen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController step2Controller = TextEditingController();
  @override
  void initState() { 
    super.initState();
    AppContoller.getProfile(context, id: int.tryParse(widget.app["id"].toString()) ?? 0);
  }
  List<Map<String, dynamic>> step2CustomTileData = [
    {
      'title': 'Имя клиента',
      'icon': 'assets/icons/person.svg',
      'textFieldtitle': [
        'Имя',
        'Фамилия',
        'Отчества',
      ],
    },
    {
      'title': 'Номер телефона клиента',
      'icon': 'assets/icons/phone.svg',
      'textFieldtitle': [
        'Номер телефона',
        'Номер телефона родственника или друга',
      ],
    },
    {
      'title': 'Адресные данные',
      'icon': 'assets/icons/location.svg',
      'textFieldtitle': [
        'Область',
        'Город / район проживания',
        'Адрес',
      ],
    },
    // {
    //   'title': 'Данные ПК',
    //   'icon': 'assets/icons/card.svg',
    //   'textFieldtitle': [
    //     'Номер ПК',
    //     'Срок',
    //   ],
    // },
  ];
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: widget.title ?? "",
          isLeading: true,
          isHome: false,
        ),
      ),
      scaffoldKey: scaffoldKey,
      customBody:
      BlocBuilder <AppProfileBloc, AppProfileState>(
        builder: (context, state) {
          if (state is AppProfileSuccessState) {
          

            return    step2ScreenBody();
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

  step2ScreenBody() {
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
                      title: step2CustomTileData[index]['title'],
                      leadingIcon: step2CustomTileData[index]['icon'],
                      textFieldtitle: step2CustomTileData[index]
                          ['textFieldtitle'],
                      index: index,
                      textEditingController: step2Controller,
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
}
