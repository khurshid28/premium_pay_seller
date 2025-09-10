import 'package:premium_pay_seller/core/init/dataformat.dart';
import 'package:premium_pay_seller/core/init/firebase.dart';
import 'package:premium_pay_seller/core/init/storage.dart';
import 'package:premium_pay_seller/core/init/system.dart';
import 'package:premium_pay_seller/core/init/widget.dart';
import 'package:premium_pay_seller/export_files.dart';

Future init() async {
  await firebaseInit();
 
  systeminit();
  widgetinit();
  
  await initStorage();
  await envinit();
  await dateFormatInit();
  
  
}
