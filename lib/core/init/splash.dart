
import 'package:premium_pay_seller/core/init/widget.dart';
import 'package:premium_pay_seller/export_files.dart';

Future splashinit() async{
     WidgetsBinding widgetsFlutterBinding = await widgetinit();
   

 

  FlutterNativeSplash.preserve(widgetsBinding: widgetsFlutterBinding);

  await Future.delayed(
    const Duration(milliseconds: 500),
  );

  FlutterNativeSplash.remove();
}