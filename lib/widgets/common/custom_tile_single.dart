import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/screens/single_application/components/single_card.dart';

// ignore: must_be_immutable
class CustomTileSingle extends StatelessWidget {
  CustomTileSingle(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.leadingIcon,
      required this.index,
      required this.isHomeCard,
      required this.isTrailing,
      required this.onTap,
      required this.status,
      required this.permission
      });
  String title;
  String subtitle;
  String leadingIcon;
  String status;
  int index;
  bool isHomeCard;
  bool isTrailing;
  VoidCallback onTap;
  AppPermission permission ;

  @override
  Widget build(BuildContext context) {
   

    return CustomContainer(
      height: isHomeCard ? 50.h : 70.h,
      width: 1.sw,
      child: ListTile(
        onTap: permission.allowed ?  onTap :(){},
        minTileHeight: isHomeCard ? 50.h : 70.h,
        horizontalTitleGap: 10.w,
        isThreeLine: false,
        leading: isHomeCard
            ? CustomIcon(
                icon: leadingIcon,
                color: AppConstant.primaryColor,
                width: 30,
              )
            : CircleAvatar(
                radius: 20.r,
                backgroundColor:
                    AppConstant.primaryColor.withOpacity(permission.allowed || permission.passed ? 1 : 0.3),
                child: CustomIcon(
                  icon: leadingIcon,
                  color: AppConstant.whiteColor,
                  width: 25,
                ),
              ),
        title: CustomText(
          text: title,
          color: AppConstant.blackColor,
          size: isHomeCard ? 14.sp : 16.sp,
          weight: FontWeight.w400,
        ),
        subtitle: isTrailing && permission.passed
            ? CustomText(
                text: subtitle,
                color: AppConstant.blackColor,
                size: isHomeCard ? 10.sp : 12.sp,
                weight: FontWeight.w200,
              )
            : null,
        trailing: isTrailing
            ? CustomIcon(
                icon: 'assets/icons/${statusIcon()}.svg',
                color: statusColor(),
                width: isHomeCard ? 25 : 30,
              )
            : null,
      ),
    );
  }

  statusIcon<String>() {
    if ( permission.passed) {
      return 'checkmark';
    }  else {
      return 'waitmark';
    }
  }


  statusColor<Color>() {

     if ( permission.passed) {
      return AppConstant.greenColor;
    }  else {
      return AppConstant.blueColor;
    }
   
  }


}
