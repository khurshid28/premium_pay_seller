import 'package:premium_pay_seller/export_files.dart';

// ignore: must_be_immutable
class SingleCard extends StatelessWidget {
  SingleCard({
    super.key,
    required this.cardList,
  });
  List cardList;

  @override
  Widget build(BuildContext context) {
    print(cardList);
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
          isTrailing: true,
          status: cardList[index]['status'].toString(),
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
