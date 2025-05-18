import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/app/single/single_app_bloc.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/export_files.dart';

import '../../bloc/app/single/single_app_state.dart';
import '../../widgets/common/custom_loading.dart';
import '../home/components/single_card.dart';

// ignore: must_be_immutable
class SingleScreen extends StatefulWidget {
  int id;
  SingleScreen({super.key, required this.id});

  @override
  State<SingleScreen> createState() => _SingleScreenState();
}

class _SingleScreenState extends State<SingleScreen> {
  List<Map<String, String>> singleCardList = [
    {
      'title': 'Идентификация',
      'subtitle': 'Имя: Alisher Bahodirov',
      'icon': 'assets/icons/person.svg',
      'link': 'step1',
    },
    {
      'title': 'Данные клиента',
      'subtitle': 'Номер телефона: +998901234567',
      'icon': 'assets/icons/folder.svg',
      'link': 'step2',
    },
    {
      'title': 'Скоринг',
      'subtitle': 'Лимит: 6 000 000 сум',
      'icon': 'assets/icons/clock.svg',
      'link': 'step3',
    },
    {
      'title': 'Покупка',
      'subtitle': 'Товаров: 2︱4 050 000 сум',
      'icon': 'assets/icons/bag.svg',
      'link': 'step4',
    },
    {
      'title': 'Оформление',
      'subtitle': 'Месяцев: 9︱4 350 000 сум',
      'icon': 'assets/icons/doc.svg',
      'link': 'step5',
    },
    {
      'title': 'Договор',
      'subtitle': 'Дата погашения: 14 октября 2024 г',
      'icon': 'assets/icons/magazine.svg',
      'link': 'step6',
    },
  ];
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    AppContoller.getSingle(context, id: widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: 'ID: ${widget.id}',
          isLeading: true,
          isHome: false,
        ),
      ),
      customBody: BlocBuilder<SingleAppBloc, SingleAppState>(
        builder: (context, state) {
          if (state is SingleAppSuccessState) {
            if (state.data.isEmpty) {
              return Center(
                child: Text(
                  "Заявкa недоступн",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppConstant.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }

            return singleScreenBody();
          } else if (state is SingleAppWaitingState) {
            return const Center(
              child: CustomLoading(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      scaffoldKey: scaffoldKey,
    );
  }

  singleScreenBody<Widget>() {
    return SingleCard(
      cardList: singleCardList,
    );
  }
}
