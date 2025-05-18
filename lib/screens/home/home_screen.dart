import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/widgets/common/custom_loading.dart';

import '../../bloc/app/all/all_bloc.dart';
import '../../bloc/app/all/all_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> homeCardList = [
    "Алишер Баҳодиров",
    "Абдулазиз Абдулмаликов",
    "Ҳамза Исломов",
    "Исмоил Жалолов",
    "Лазиз Очилов",
    "Нурали Тешаев",
    "Одина Муродова",
    "Жасур Алимов",
    "Зафар Жабборов",
    "Ҳалима Турсунова",
    "Билол Алиев",
    "Расул Исломов",
    "Анвар Бердиев",
    "Дилобар Расулова",
    "Бахтиёр Жалолов",
    "Зарина Алиева",
    "Севара Солиева",
    "Шаҳло Рустамова",
    "Жўрабек Камолов",
  ];
  @override
  void initState() {
    AppContoller.getAll(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: 'Заявки',
          isLeading: true,
          isHome: true,
        ),
      ),
      customBody:
      
       BlocBuilder<AllAppBloc, AllAppState>(
        builder: (context, state) {
          if (state is AllAppSuccessState) {
            if (state.data.isEmpty) {
              return Center(
                child: Text(
                  "Заявки недоступны",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppConstant.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }

            return AllAppCard(
              cardList:
                  state.data,
            );
          } else if (state is AllAppWaitingState) {
            return const Center(
              child: CustomLoading(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
      scaffoldKey: scaffoldKey,
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          context.push('/myId');
        },
        child: CustomIcon(
          icon: 'assets/icons/pencil.svg',
          color: AppConstant.whiteColor,
          width: 30,
        ),
      ),
    );
  }
}
