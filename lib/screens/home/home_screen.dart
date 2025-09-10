import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/version/version_bloc.dart';
import 'package:premium_pay_seller/bloc/version/version_state.dart';
import 'package:premium_pay_seller/controller/app_contoller.dart';
import 'package:premium_pay_seller/controller/version_controller.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/check_versions.dart';
import 'package:premium_pay_seller/service/download_last_version.dart';
import 'package:premium_pay_seller/service/fmc_token.dart';
import 'package:premium_pay_seller/service/toast.dart';
import 'package:premium_pay_seller/widgets/common/custom_loading.dart';

import 'package:go_router/go_router.dart';

import '../../bloc/app/all/all_bloc.dart';
import '../../bloc/app/all/all_state.dart';
import 'package:url_launcher/url_launcher.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  Timer? _timer;

  @override
  void initState() {
    VersionController.getAppVersion(context);
    AppContoller.getAll(context);
    _timer = Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      if (mounted && rootNavigatorKey.currentContext != null) {
        // final delegate =
        //     GoRouter.of(rootNavigatorKey.currentContext!).routerDelegate;
        // final uri =
        //     delegate.currentConfiguration..toString(); // bu to'liq path

        // print("Current full path: $uri");
        AppContoller.refreshAll(context);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  ToastService toastService = ToastService();
  @override
  Widget build(BuildContext context) {
    getFcmToken().then(print);
    return CustomScaffold(
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: 'Заявки',
          isLeading: true,
          isHome: true,
        ),
      ),
      customBody: BlocListener<VersionBloc, VersionState>(
        child: BlocBuilder<AllAppBloc, AllAppState>(
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
                cardList: state.data,
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
        listener: (context, state) async {
          if (state is VersionWaitingState) {
          } else if (state is VersionErrorState) {
            toastService.error(message: "Versiya anishlashda xatolik");
          } else if (state is VersionSuccessState) {
         
            if (!(await isAvailableApp(state.version))) {
              await showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: Container(
                      height: 1.sh,
                      width: 1.sw,
                      color: AppConstant.primaryColor.withOpacity(0.4),
                      child: Center(
                        child: CustomContainer(
                          width: 300.w,
                          padding: EdgeInsets.all(16.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 16.h,
                              ),
                              Image.asset("assets/images/update.png",height: 200.h,width: 200.w,),
                              SizedBox(
                                height: 16.h,
                              ),
                               CustomText(
                                text:
                                    "Уважаемый пользователь",
                                color: AppConstant.primaryColor,
                                textAlign: TextAlign.center,
                                size: 17,
                                weight: FontWeight.w700,
                              ),
                              CustomText(
                                text:
                                    "Пожалуйста, загрузите последнюю версию приложения.",
                                color: AppConstant.primaryColor,
                                textAlign: TextAlign.center,
                                size: 13,
                                weight: FontWeight.w500,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              CustomButton(text: "Скачать", onTap: DownLoadLastVersion),
                            ],
                          ),
                        ),
                      )),
                ),
              );
            }
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
          icon: 'assets/icons/person.svg',
          color: AppConstant.whiteColor,
          width: 30,
        ),
      ),
    );
  }
}
