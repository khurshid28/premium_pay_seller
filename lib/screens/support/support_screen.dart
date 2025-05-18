import 'package:premium_pay_seller/export_files.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> {
  GlobalKey scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController supportController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      resizeToAvoidBottomInset: true,
      customAppBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          titleText: 'Служба поддержки',
          isLeading: true,
          isHome: false,
        ),
      ),
      customBody: supportScreenBody(),
      scaffoldKey: scaffoldKey,
    );
  }

  supportScreenBody<Widget>() {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          customLogo(false),
          CustomText(
            text: 'Версия 1.0.0',
            color: AppConstant.greyColor,
            size: 14,
            weight: FontWeight.w200,
          ),
          const Spacer(),
          CustomText(
            text: "Отправьте нам сообщение с вашими вопросами и предложениями",
            color: AppConstant.blackColor,
            size: 14,
            weight: FontWeight.w200,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16.h),
          CustomTextfield(
            textEditingController: supportController,
            keyboardType: TextInputType.multiline,
            minlines: 5,
            maxlines: 5,
          ),
          SizedBox(height: 16.h),
          CustomButton(
            text: 'Отправить',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
