import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:premium_pay_seller/bloc/app/all/all_bloc.dart';
import 'package:premium_pay_seller/bloc/app/all/all_state.dart';
import 'package:premium_pay_seller/export_files.dart';
import 'package:premium_pay_seller/widgets/common/custom_loading.dart';

showCustomSearch(BuildContext context) {
  showSearch(
    context: context,
    delegate: CustomSearchDelegate(),
  );
}

class CustomSearchDelegate extends SearchDelegate<String> {

  @override
  String get searchFieldLabel => 'Поиск';

  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: AppConstant.blackColor,
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
      );

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      appBarTheme: const AppBarTheme(
        backgroundColor: AppConstant.whiteColor,
        surfaceTintColor: AppConstant.whiteColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: AppConstant.blackColor,
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  @override
  PreferredSizeWidget? buildBottom(BuildContext context) => PreferredSize(
        preferredSize: Size(1.sw, 4.h),
        child: customDivider(),
      );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        highlightColor: Colors.transparent,
        icon: CustomIcon(
          icon: 'assets/icons/xcircle.svg',
          color: AppConstant.primaryColor,
          width: 30,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: CustomIcon(
        icon: 'assets/icons/chevronleft.svg',
        color: AppConstant.primaryColor,
        width: 25,
      ),
      onPressed: () => context.pop(),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: AppConstant.whiteColor,
      child: 
      BlocBuilder<AllAppBloc, AllAppState>(
        builder: (context, state) {
          if (state is AllAppSuccessState) {
            if (state.data.isEmpty) {
              return Center(
                child: Text(
                  "Заявки недоступны",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppConstant.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }

            return AllAppCard(
              cardList: state.data
                  .where((item) => item["fullname"]
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList(),
            );
          } else if (state is AllAppWaitingState) {
            return const Center(
              child: CustomLoading(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    

    return Container(
      height: 1.sh,
      width: 1.sw,
      color: AppConstant.whiteColor,
      child:    BlocBuilder<AllAppBloc, AllAppState>(
        builder: (context, state) {
          if (state is AllAppSuccessState) {
            if (state.data.isEmpty) {
              return Center(
                child: Text(
                  "Заявки недоступны",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppConstant.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }

            return AllAppCard(
              cardList:  query.isEmpty
        ? []
        : state.data
                  .where((item) => item["fullname"]
                      .toString()
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList(),
            );
          } else if (state is AllAppWaitingState) {
            return const Center(
              child: CustomLoading(),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
  
    );
  }
}
