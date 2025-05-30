import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatelessWidget {
  CustomTextfield({
    super.key,
    required this.textEditingController,
    this.prefixIcon,
    this.hintText,
    this.keyboardType,
    this.maxlines,
    this.minlines,
    this.onChanged,
    this.inputFormatters = const [],
    this.textCapitalization,
    this.readOnly = false
  });
  TextEditingController textEditingController;
  Widget? prefixIcon;
  String? hintText;
  TextInputType? keyboardType;
  int? maxlines;
  int? minlines;
  List<TextInputFormatter> inputFormatters =[];
  TextCapitalization? textCapitalization;
  void Function(String)? onChanged;
  bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      controller: textEditingController,
      keyboardType: keyboardType,
      minLines: minlines,
      maxLines: maxlines,
      cursorColor: AppConstant.primaryColor,
      showCursor: false,
      readOnly: readOnly,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: AppConstant.primaryColor,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: AppConstant.primaryColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: const BorderSide(
            color: AppConstant.primaryColor,
          ),
        ),
        isCollapsed: false,
        isDense: true,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppConstant.greyColor,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        errorStyle: const TextStyle(
          color: AppConstant.redColor,
          fontWeight: FontWeight.w400,
        ),
      ),
      style: TextStyle(
        color: AppConstant.blackColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      onChanged: onChanged,
    );
  }
}
