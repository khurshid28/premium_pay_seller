import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/login/login_bloc.dart';
import 'package:premium_pay_seller/bloc/login/login_state.dart';
import 'package:premium_pay_seller/controller/login_controller.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/loading.dart';
import 'package:premium_pay_seller/service/storage.dart';
import 'package:premium_pay_seller/service/toast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController loginController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  List<Map<String, String>> textField = [
    {
      'icon': 'assets/icons/person.svg',
      'hint': 'Логин',
    },
    {
      'icon': 'assets/icons/lockfill.svg',
      'hint': 'Парол',
    },
  ];
  @override
  void dispose() {
    loginController.clear();
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomInset: false,
      customBody: loginScreenBody(),
      scaffoldKey: scaffoldKey,
    );
  }

  LoadingService loadingService = LoadingService();
  ToastService toastService = ToastService();

  loginScreenBody<Widget>() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          customLogo(false),
          Column(
            children: List.generate(
              2,
              (index) => Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: CustomTextfield(
                  onChanged: (v) {
                    setState(() {});
                  },
                  textEditingController: [
                    loginController,
                    passwordController
                  ][index],
                  keyboardType: TextInputType.number,
                  prefixIcon: CustomIcon(
                    icon: textField[index]['icon'].toString(),
                    color: AppConstant.primaryColor,
                    width: 5.w,
                  ),
                  hintText: textField[index]['hint'],
                ),
              ),
            ),
          ),
          BlocListener<LoginBloc, LoginState>(
            child: const SizedBox(),
            listener: (context, state) async {
              if (state is LoginWaitingState) {
                loadingService.showLoading(context);
              } else if (state is LoginErrorState) {
                loadingService.closeLoading(context);
                toastService.error(message: state.message ?? "Xatolik Bor");
                print(state.message ?? "Xatolik Bor");
              } else if (state is LoginSuccessState) {
                print(state.data);
                loadingService.closeLoading(context);
                await Future.wait([
                  StorageService().write(StorageService.token,
                      state.data["access_token"].toString()),
                  StorageService()
                      .write(StorageService.user, state.data['user'])
                ]);
                context.replace('/');
                toastService.success(message: "Xush kelibsiz");

                print("Successfully Post data");
              }
            },
          ),
          CustomButton(
            text: 'Вход',
            color: loginController.text.length < 12 ||
                    passwordController.text.length < 6
                ? AppConstant.greyColor1
                : null,
            onTap: () async {
              if (loginController.text.length >= 12 &&
                  passwordController.text.length >= 6) {
                LoginController.postdata(
                  // ignore: use_build_context_synchronously
                  context,
                  login: loginController.text,
                  password: passwordController.text,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
