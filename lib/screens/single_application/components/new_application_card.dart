import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class NewApplicationCard extends StatelessWidget {
  NewApplicationCard({
    super.key,
    required this.cardList,
    required this.isNew,
  });
  List cardList;
  bool isNew;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cardList.length,
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) => Padding(
        padding: EdgeInsets.only(
          left: 16.w,
          right: 16.w,
          top: index == 0 ? 16.w : 0,
          bottom: 16.w,
        ),
        child: CustomTile(
          title: cardList[index]['title'],
          subtitle: cardList[index]['subtitle'],
          leadingIcon: cardList[index]['icon'],
          index: index,
          isHomeCard: false,
          isTrailing: !isNew,
          status: "CREATED",
          onTap: () {
            context.pushNamed(
              cardList[index]['link'],
              queryParameters: {
                'title': cardList[index]['title'],
              },
            );
          },
        ),
      ),
    );
  }
}
