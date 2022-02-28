import 'app_theme.dart';
import 'package:flutter/material.dart';
import '../models/item.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
// import 'models/hotel_list_data.dart';
// import 'models/hotel_list_view.dart';
import 'model/item_list_view.dart';
import 'model/item_list_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:developer' as developer;

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  List<ItemListData> itemList = ItemListData.itemList;
  AnimationController? animationController;
  bool multiple = true;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 0));
    fetchItems();
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    developer.log('build');
    return Theme(
      data: VagazineAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
          body: Stack(
            children: <Widget>[
              InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Column(
                  children: <Widget>[
                    getAppBarUI(),
                    Expanded(
                      // child: Container(
                      //   color:
                      //       VagazineAppTheme.buildLightTheme().backgroundColor,
                      //   child: FutureBuilder<List<ItemListData>>(
                      //       future: fetchItems(),
                      //       builder: (context, snapshot) {
                      //         return getListView(snapshot);
                      //       }),
                      // ),

                      child: Container(
                        color:
                            VagazineAppTheme.buildLightTheme().backgroundColor,
                        child: ListView.builder(
                          itemCount: itemList.length,
                          padding: const EdgeInsets.only(top: 8),
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            final int count =
                                itemList.length > 10 ? 10 : itemList.length;
                            final Animation<double> animation =
                                Tween<double>(begin: 0.0, end: 1.0).animate(
                                    CurvedAnimation(
                                        parent: animationController!,
                                        curve: Interval(
                                            (1 / count) * index, 1.0,
                                            curve: Curves.fastOutSlowIn)));
                            animationController?.forward();
                            return ItemListView(
                              callback: () {},
                              itemData: itemList[index],
                              animation: animation,
                              animationController: animationController!,
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget getHotelViewList() {
  //   final List<Widget> hotelListViews = <Widget>[];
  //   for (int i = 0; i < hotelList.length; i++) {
  //     final int count = hotelList.length;
  //     final Animation<double> animation =
  //         Tween<double>(begin: 0.0, end: 1.0).animate(
  //       CurvedAnimation(
  //         parent: animationController!,
  //         curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
  //       ),
  //     );
  //     hotelListViews.add(
  //       HotelListView(
  //         callback: () {},
  //         hotelData: hotelList[i],
  //         animation: animation,
  //         animationController: animationController!,
  //       ),
  //     );
  //   }
  //   animationController?.forward();
  //   return Column(
  //     children: hotelListViews,
  //   );
  // }

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: HotelAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: itemList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          itemList.length > 10 ? 10 : itemList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController!,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController?.forward();

                      return ItemListView(
                        callback: () {},
                        itemData: itemList[index],
                        animation: animation,
                        animationController: animationController!,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getListView(AsyncSnapshot snapshot) {
    developer.log('getListView');
    developer.log('$snapshot');
    developer.log('$snapshot.hasData');
    developer.log('$snapshot.hasError');
    developer.log('$snapshot.error');
    if (snapshot.hasData) {
      developer.log('$snapshot.data');
      List<ItemListData>? resData = snapshot.data;
      return ListView.builder(
          itemCount: resData != null ? resData.length : 0,
          padding: const EdgeInsets.only(top: 8),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            final int count = itemList.length > 10 ? 10 : itemList.length;
            final Animation<double> animation =
                Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                    parent: animationController!,
                    curve: Interval((1 / count) * index, 1.0,
                        curve: Curves.fastOutSlowIn)));
            animationController?.forward();
            return ItemListView(
              callback: () {},
              itemData: itemList[index],
              animation: animation,
              animationController: animationController!,
            );
          });
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }
    return const CircularProgressIndicator();
  }

  Widget getAppBarUI() {
    return Container(
      decoration: BoxDecoration(
        color: VagazineAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, 2),
              blurRadius: 8.0),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top, left: 8, right: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              // child: Material(
              // color: Colors.transparent,
              // child: InkWell(
              //   borderRadius: const BorderRadius.all(
              //     Radius.circular(32.0),
              //   ),
              //   onTap: () {
              //     Navigator.pop(context);
              //   },
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Icon(Icons.arrow_back),
              //   ),
              // ),
              // ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    'Vagazine',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: AppBar().preferredSize.height + 40,
              height: AppBar().preferredSize.height,
              // child: Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: <Widget>[
              //     Material(
              //       color: Colors.transparent,
              //       child: InkWell(
              //         borderRadius: const BorderRadius.all(
              //           Radius.circular(32.0),
              //         ),
              //         onTap: () {},
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Icon(Icons.favorite_border),
              //         ),
              //       ),
              //     ),
              //     Material(
              //       color: Colors.transparent,
              //       child: InkWell(
              //         borderRadius: const BorderRadius.all(
              //           Radius.circular(32.0),
              //         ),
              //         onTap: () {},
              //         child: Padding(
              //           padding: const EdgeInsets.all(8.0),
              //           child: Icon(FontAwesomeIcons.mapMarkerAlt),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            )
          ],
        ),
      ),
    );
  }
}

// class ItemListView extends StatelessWidget {
//   const ItemListView(
//       {Key? key,
//       this.callBack,
//       this.listData,
//       this.animationController,
//       this.animation})
//       : super(key: key);

//   final Item? listData;
//   final VoidCallback? callBack;
//   final AnimationController? animationController;
//   final Animation<double>? animation;

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: animationController!,
//       builder: (BuildContext context, Widget? child) {
//         return FadeTransition(
//           opacity: animation!,
//           child: Transform(
//             transform: Matrix4.translationValues(
//                 0.0, 50 * (1.0 - animation!.value), 0.0),
//             child: AspectRatio(
//               aspectRatio: 1.5,
//               child: ClipRRect(
//                 borderRadius: const BorderRadius.all(Radius.circular(4.0)),
//                 child: Stack(
//                   alignment: AlignmentDirectional.center,
//                   children: <Widget>[
//                     Positioned.fill(
//                       child: Image.asset(
//                         listData!.imageUrl,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Material(
//                       color: Colors.transparent,
//                       child: InkWell(
//                         splashColor: Colors.grey.withOpacity(0.2),
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(4.0)),
//                         onTap: callBack,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

Future<List<ItemListData>> fetchItems() async {
  final response = await http.get(Uri.parse('https://dongsan.club/items'));
  developer.log('$response');
  developer.log('fetchItems');
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<ItemListData> items = [];
    List<dynamic> itemsJson = jsonDecode(response.body);
    itemsJson.forEach(
      (oneItem) {
        ItemListData item = ItemListData.fromJson(oneItem);
        items.add(item);
      },
    );
    developer.log('$items');
    return items;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
