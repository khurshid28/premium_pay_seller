import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class CustomScaffold extends StatelessWidget {
  CustomScaffold({
    super.key,
    this.customAppBar,
    this.floatingActionButton,
    required this.customBody,
    required this.scaffoldKey,
    this.resizeToAvoidBottomInset,
    this.floatingActionButtonPadding,
  });
  Widget customBody;
  PreferredSizeWidget? customAppBar;
  FloatingActionButton? floatingActionButton;
  GlobalKey scaffoldKey;
  bool? resizeToAvoidBottomInset;
  double? floatingActionButtonPadding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      resizeToAvoidBottomInset: true,
      appBar: customAppBar,
      body: SafeArea(child: customBody),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: floatingActionButtonPadding == null
              ? 0
              : floatingActionButtonPadding!,
        ),
        child: floatingActionButton,
      ),
    );
  }
}
