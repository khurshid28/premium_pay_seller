import 'package:fluttertoast/fluttertoast.dart';

import '../../export_files.dart';

class ToastService {
  success({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: AppConstant.primaryColor,
      textColor: Colors.white,
      fontSize: 14.sp,
      
    );
  }

  error({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: AppConstant.redColor,
      textColor: Colors.white,
      fontSize: 14.sp,
      
    );
  }
}
