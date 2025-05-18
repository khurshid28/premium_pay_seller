import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class Step2Screen extends StatefulWidget {
  Step2Screen({super.key, required this.title});
  String title;

  @override
  State<Step2Screen> createState() => _Step2ScreenState();
}

class _Step2ScreenState extends State<Step2Screen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController step2Controller = TextEditingController();
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
    {
      'title': 'Данные ПК',
      'icon': 'assets/icons/card.svg',
      'textFieldtitle': [
        'Номер ПК',
        'Срок',
      ],
    },
  ];
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
      customBody: step2ScreenBody(),
    );
  }

  step2ScreenBody() {
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
