import 'package:frontend/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:frontend/model/item_list_data.dart';
import 'package:frontend/vagazine/grid_list.dart';
import 'dart:developer' as developer;

class ItemListView extends StatelessWidget {
  const ItemListView(
      {Key? key,
      this.itemData,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback? callback;
  final ItemListData? itemData;
  final AnimationController? animationController;
  final Animation<double>? animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (BuildContext context, Widget? child) {
        return FadeTransition(
          opacity: animation!,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation!.value), 0.0),
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 24, right: 24, top: 8, bottom: 16),
              child: InkWell(
                splashColor: Colors.transparent,
                onTap: callback,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.6),
                        offset: const Offset(4, 4),
                        blurRadius: 16,
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                    child: Stack(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            AspectRatio(
                              aspectRatio: 2,
                              child: Image.network(
                                itemData!.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              color: HotelAppTheme.buildLightTheme()
                                  .backgroundColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, top: 8, bottom: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          // title
                                          children: <Widget>[
                                            Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    itemData!.title,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15,
                                                    ),
                                                  )
                                                ]),
                                            // desc
                                            Row(children: <Widget>[
                                              Text(
                                                  itemData!.desc
                                                          .substring(0, 50) +
                                                      "...",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 11,
                                                  ))
                                            ]),
                                            // price
                                            getBottomView(context, itemData),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 4),
                                              child: Row(
                                                children: <Widget>[
                                                  // RatingBar(
                                                  //   initialRating: 5,
                                                  //   direction:
                                                  //       Axis.horizontal,
                                                  //   allowHalfRating: true,
                                                  //   itemCount: 5,
                                                  //   itemSize: 24,
                                                  //   ratingWidget:
                                                  //       RatingWidget(
                                                  //     full: Icon(
                                                  //       Icons
                                                  //           .star_rate_rounded,
                                                  //       color: HotelAppTheme
                                                  //               .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //     half: Icon(
                                                  //       Icons
                                                  //           .star_half_rounded,
                                                  //       color: HotelAppTheme
                                                  //               .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //     empty: Icon(
                                                  //       Icons
                                                  //           .star_border_rounded,
                                                  //       color: HotelAppTheme
                                                  //               .buildLightTheme()
                                                  //           .primaryColor,
                                                  //     ),
                                                  //   ),
                                                  //   itemPadding:
                                                  //       EdgeInsets.zero,
                                                  //   onRatingUpdate:
                                                  //       (rating) {
                                                  //     print(rating);
                                                  //   },
                                                  // ),
                                                  // TextButton(
                                                  //   // style: TextButton
                                                  //   //     .styleFrom(
                                                  //   //   padding:
                                                  //   //       const EdgeInsets
                                                  //   //           .all(0.0),
                                                  //   //   textStyle:
                                                  //   //       const TextStyle(
                                                  //   //           fontSize: 20),
                                                  //   // ),
                                                  //   onPressed: () {
                                                  //     launchURL(
                                                  //         itemData!.url);
                                                  //   },
                                                  //   child:
                                                  //       const Text('구매하기'),
                                                  // ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 16, top: 8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        // Text(
                                        //   '\$${hotelData!.perNight}',
                                        //   textAlign: TextAlign.left,
                                        //   style: TextStyle(
                                        //     fontWeight: FontWeight.w600,
                                        //     fontSize: 22,
                                        //   ),
                                        // ),
                                        // Text(
                                        //   '/per night',
                                        //   style: TextStyle(
                                        //       fontSize: 14,
                                        //       color:
                                        //           Colors.grey.withOpacity(0.8)),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        // Positioned(
                        //   top: 8,
                        //   right: 8,
                        //   child: Material(
                        //     color: Colors.transparent,
                        //     child: InkWell(
                        //       borderRadius: const BorderRadius.all(
                        //         Radius.circular(32.0),
                        //       ),
                        //       onTap: () {},
                        //       child: Padding(
                        //         padding: const EdgeInsets.all(8.0),
                        //         child: Icon(
                        //           Icons.favorite_border,
                        //           color: HotelAppTheme.buildLightTheme()
                        //               .primaryColor,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget getBottomView(context, itemData) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
      Text(
        itemData!.price,
        style: TextStyle(fontSize: 14, color: Colors.grey.withOpacity(0.8)),
      ),
      TextButton(
        // style: TextButton
        //     .styleFrom(
        //   padding:
        //       const EdgeInsets
        //           .all(0.0),
        //   textStyle:
        //       const TextStyle(
        //           fontSize: 20),
        // ),
        onPressed: () {
          launchURL(itemData!.url);
        },
        child: const Text('구매하기'),
      ),
      TextButton(
        // style: TextButton
        //     .styleFrom(
        //   padding:
        //       const EdgeInsets
        //           .all(0.0),
        //   textStyle:
        //       const TextStyle(
        //           fontSize: 20),
        // ),
        onPressed: () {
          getDialogView(context, itemData);
        },
        // launchURL(itemData!.url);
        child: const Text('자세히'),
      ),
      // Expanded(
      //   child: Text(
      //     '${hotelData!.dist.toStringAsFixed(1)} km to city',
      //     overflow: TextOverflow
      //         .ellipsis,
      //     style: TextStyle(
      //         fontSize: 14,
      //         color: Colors.grey
      //             .withOpacity(
      //                 0.8)),
      //   ),
      // ),
    ],
  );
}

// Widget openAlertBox(content, itemData) {
//   return showDialog<String>(
//           context: context,
//           builder: (BuildContext context) => AlertDialog(
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(20.0))),
//             contentPadding: EdgeInsets.only(top: 10),
//             title: Text(itemData!.title,
//                 style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
//             content: Container(
//                 width: 300.0,
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: <Widget>[
//                       AspectRatio(
//                         aspectRatio: 2,
//                         child: Image.network(
//                           itemData!.imageUrl,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       Padding(
//                           padding: EdgeInsets.all(5.0),
//                           child: Text(itemData!.price,
//                               style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.normal,
//                                   decoration: TextDecoration.none))),
//                       SingleChildScrollView(
//                           child: Padding(
//                               padding: EdgeInsets.all(5.0),
//                               child: Text(itemData!.desc,
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       fontWeight: FontWeight.normal,
//                                       decoration: TextDecoration.none)))),
//                       InkWell(
//                         child: Container(
//                           padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(32.0),
//                                 bottomRight: Radius.circular(32.0)),
//                           ),
//                           child: Text(
//                             "Rate Product",
//                             style: TextStyle(color: Colors.black),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       ),
//                     ])),
//             actions: <Widget>[
//               // TextButton(
//               //   onPressed: () => Navigator.pop(context, 'Cancel'),
//               //   child: const Text('Cancel'),
//               // ),
//               TextButton(
//                 onPressed: () => Navigator.pop(context, 'OK'),
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         )
// }

Future<bool> getDialogView(context, itemData) async {
  bool goBack = false;
  await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          title: Text(itemData!.title,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 2,
                  child: Image.network(
                    itemData!.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Container(
                    height: 250,
                    alignment: Alignment.center,
                    child: Expanded(
                        flex: 1,
                        child: Padding(
                            padding: EdgeInsets.all(15),
                            child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Text(itemData!.desc,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal,
                                        decoration: TextDecoration.none)))))),
                InkWell(
                  child: Container(
                    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      color: VagazineAppTheme.buildLightTheme().primaryColor,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32.0),
                          bottomRight: Radius.circular(32.0)),
                    ),
                    child: TextButton(
                        onPressed: () => Navigator.pop(context, '확인'),
                        child: Text(
                          "확인",
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )),
                  ),
                ),
              ],
            ),
          ),
        );
      });
  return goBack;
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url, forceWebView: true);
  } else {
    throw 'Could not launch $url';
  }
}
