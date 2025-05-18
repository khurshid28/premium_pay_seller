import 'package:premium_pay_seller/export_files.dart';

showCustomSearch(BuildContext context) {
  showSearch(
    context: context,
    delegate: CustomSearchDelegate(),
  );
}

class CustomSearchDelegate extends SearchDelegate<String> {
  final List<String> searchList = [
    "Алишер Баҳодиров",
    "Абдулазиз Абдулмаликов",
    "Ҳамза Исломов",
    "Исмоил Жалолов",
    "Лазиз Очилов",
    "Нурали Тешаев",
    "Одина Муродова",
    "Жасур Алимов",
    "Зафар Жабборов",
    "Ҳалима Турсунова",
    "Билол Алиев",
    "Расул Исломов",
    "Анвар Бердиев",
    "Дилобар Расулова",
    "Бахтиёр Жалолов",
    "Зарина Алиева",
    "Севара Солиева",
    "Шаҳло Рустамова",
    "Жўрабек Камолов",
  ];

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
    final List<String> searchResults = searchList
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return Container(
      height: 1.sh,
      width: 1.sw,
      color: AppConstant.whiteColor,
      child: AllAppCard(
        cardList: searchResults,
        // onTap: () {
        //   // close(context, searchResults[index]);
        // },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<String> suggestionList = query.isEmpty
        ? []
        : searchList
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return Container(
      height: 1.sh,
      width: 1.sw,
      color: AppConstant.whiteColor,
      child: AllAppCard(
        cardList: suggestionList,
        // onTap: () {
        //   // query = suggestionList[index];
        // },
      ),
    );
  }
}
