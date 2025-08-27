import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatelessWidget {
  CustomTextfield({
    super.key,
    required this.textEditingController,
    this.prefixIcon,
     this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.maxlines,
    this.minlines,
    this.maxLength = 50,
    this.onChanged,
    this.onTap,
    this.inputFormatters = const [],
    this.textCapitalization,
    this.readOnly = false
  });
  TextEditingController textEditingController;
  Widget? prefixIcon;
  Widget? suffixIcon;
  String? hintText;
  TextInputType? keyboardType;
  int? maxlines;
  int? minlines;
  List<TextInputFormatter> inputFormatters =[];
  TextCapitalization? textCapitalization;
  void Function(String)? onChanged;
  void Function()? onTap;
  bool readOnly;
   int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      controller: textEditingController,
      onTap: onTap,
      keyboardType: keyboardType,
      minLines: minlines,
      maxLines: maxlines,
      cursorColor: AppConstant.primaryColor,
      showCursor: !readOnly,
      readOnly: readOnly,
       maxLength : maxLength,
        buildCounter: (
            BuildContext context, {
            required int currentLength,
            required bool isFocused,
            required int? maxLength,
          }) {
            return null; 
          },
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
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
