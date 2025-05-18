import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/service/storage.dart';
import 'package:premium_pay_seller/widgets/common/custom_modal.dart';

// ignore: must_be_immutable
class CustomAppBar extends StatelessWidget {
  CustomAppBar({
    super.key,
    this.titleText,
    required this.isLeading,
    required this.isHome,
  });
  String? titleText;
  bool isLeading;
  bool isHome;
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> actionIcons = [
      {
        'icon': 'assets/icons/search.svg',
        'width': 30.0,
        'link': 'search',
      },
      {
        'icon': 'assets/icons/filter.svg',
        'width': 25.0,
        'link': 'filter',
      },
      {
        'icon': 'assets/icons/callcenter.svg',
        'width': 30.0,
        'link': 'support',
      },
    ];
    Map? user = StorageService().read(StorageService.user);
    return AppBar(
      automaticallyImplyLeading: false,
      surfaceTintColor: Colors.transparent,
      backgroundColor: AppConstant.whiteColor,
      title: CustomText(
        text: titleText!,
        color: AppConstant.blackColor,
        size: 18,
        weight: FontWeight.w400,
      ),
      centerTitle: !isHome,
      leading: isLeading
          ? isHome
              ? IconButton(
                  onPressed: () {
                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(16.w, 80.h, 80.w, 0.h),
                      color: AppConstant.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      items: List.generate(
                        1,
                        (index) => PopupMenuItem(
                          child: ListTile(
                            onTap: () {
                              context.pop();
                            },
                            leading: CircleAvatar(
                              radius: 20.r,
                              backgroundColor: AppConstant.whiteColor,
                              child: CustomIcon(
                                icon: 'assets/icons/person.svg',
                                color: AppConstant.primaryColor,
                                width: 30,
                              ),
                            ),
                            title: CustomText(
                              text: user?["fullname"]  ?? 'Operator',
                              color: AppConstant.whiteColor,
                              size: 14,
                              weight: FontWeight.w400,
                            ),
                            subtitle: CustomText(
                              text: user?["phone"]  ?? '',
                              color: AppConstant.greyColor,
                              size: 12,
                              weight: FontWeight.w200,
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                StorageService().logout();
                                context.replace('/login');
                              },
                              icon: CustomIcon(
                                icon: 'assets/icons/logout.svg',
                                color: AppConstant.whiteColor,
                                width: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  icon: CustomIcon(
                    icon: 'assets/icons/more.svg',
                    color: AppConstant.primaryColor,
                    width: 30,
                  ),
                  highlightColor: Colors.transparent,
                )
              : IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: CustomIcon(
                    icon: 'assets/icons/chevronleft.svg',
                    color: AppConstant.primaryColor,
                    width: 25,
                  ),
                )
          : null,
      actions: isHome
          ? List.generate(
              actionIcons.length,
              (index) => IconButton(
                highlightColor: Colors.transparent,
                onPressed: () {
                  if (actionIcons[index]['link'] == 'search') {
                    showCustomSearch(context);
                  } else if (actionIcons[index]['link'] == 'filter') {
                    showCustomModal(
                      context,
                      const FilterArea(),
                    );
                  } else if (actionIcons[index]['link'] == 'support') {
                    context.push('/support');
                  } else {}
                },
                icon: CustomIcon(
                  icon: actionIcons[index]['icon'],
                  color: AppConstant.primaryColor,
                  width: actionIcons[index]['width'],
                ),
              ),
            )
          : null,
      bottom: PreferredSize(
        preferredSize: Size(1.sw, 0),
        child: customDivider(),
      ),
    );
  }
}
