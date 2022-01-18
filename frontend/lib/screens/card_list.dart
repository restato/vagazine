import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../screens/detail_page.dart';
import '../models/item.dart';

Future<List<Item>> fetchItems() async {
  final response = await http.get(Uri.parse('https://dongsan.club/items'));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Item> items = [];
    List<dynamic> itemsJson = jsonDecode(response.body);
    itemsJson.forEach(
      (oneItem) {
        Item item = Item.fromJson(oneItem);
        items.add(item);
      },
    );
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

class CardList extends StatelessWidget {
  const CardList({Key? key}) : super(key: key);

  Widget _gridView(AsyncSnapshot snapshot) {
    ContainerTransitionType _transitionType = ContainerTransitionType.fade;

    if (snapshot.hasData) {
      List<Item>? resData = snapshot.data;
      return GridView.builder(
          itemCount: resData != null ? resData.length : 0,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5.0,
            mainAxisSpacing: 5.0,
          ),
          itemBuilder: (context, index) {
            Item item = resData![index];
            return _OpenContainerWrapper(
              transitionType: _transitionType,
              item: item,
              closedBuilder: (context, openContainer) {
                return _SmallDetailsCard(
                    openContainer: openContainer, item: item);
              },
            );
          });
      // return GestureDetector(
      //   onTap: () {
      //     launchURL(item.url);
      //   },
      //   child: Expanded(
      //     child: _OpenContainerWrapper(
      //       transitionType: _transitionType,
      //       closedBuilder: (context, openContainer) {
      //         return _SmallDetailsCard(
      //             openContainer: openContainer, item: item);
      //       },
      //     ),
      //   ),
      // ); // _GridPhotoItem(item: item));
      // });
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }
    return const CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<List<Item>>(
        future: fetchItems(),
        builder: (context, snapshot) {
          return _gridView(snapshot);
        },
      ),
    );

    // return ListView(padding: const EdgeInsets.all(8), children: [
    //   Row(
    //     children: [
    //       Expanded(
    //         child: _OpenContainerWrapper(
    //           transitionType: _transitionType,
    //           closedBuilder: (context, openContainer) {
    //             return _SmallDetailsCard(
    //                 openContainer: openContainer, subtitle: 'subtitle');
    //           },
    //         ),
    //       ),
    //       const SizedBox(
    //         width: 8,
    //       ),
    //       Expanded(
    //         child: _OpenContainerWrapper(
    //           transitionType: _transitionType,
    //           closedBuilder: (context, openContainer) {
    //             return _SmallDetailsCard(
    //                 openContainer: openContainer, subtitle: 'subtitle');
    //           },
    //         ),
    //       ),
    //     ],
    //   ),
    //   const SizedBox(
    //     height: 16,
    //   ),
    //   Row(
    //     children: [
    //       Expanded(
    //         child: _OpenContainerWrapper(
    //           transitionType: _transitionType,
    //           closedBuilder: (context, openContainer) {
    //             return _SmallDetailsCard(
    //               openContainer: openContainer,
    //               subtitle: 'subtitle',
    //             );
    //           },
    //         ),
    //       ),
    //       const SizedBox(
    //         width: 8,
    //       ),
    //       Expanded(
    //         child: _OpenContainerWrapper(
    //           transitionType: _transitionType,
    //           closedBuilder: (context, openContainer) {
    //             return _SmallDetailsCard(
    //               openContainer: openContainer,
    //               subtitle: 'subtitle',
    //             );
    //           },
    //         ),
    //       ),
    //       const SizedBox(
    //         width: 8,
    //       ),
    //       Expanded(
    //         child: _OpenContainerWrapper(
    //           transitionType: _transitionType,
    //           closedBuilder: (context, openContainer) {
    //             return _SmallDetailsCard(
    //               openContainer: openContainer,
    //               subtitle: 'subtitle',
    //             );
    //           },
    //         ),
    //       ),
    //     ],
    //   )
    // ]);
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
    required this.item,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;
  final Item item;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (context, openContainer) => DetailPage(item: item),
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}

class _DetailsCard extends StatelessWidget {
  const _DetailsCard({required this.openContainer});

  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    return _InkWellOverlay(
      openContainer: openContainer,
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
              color: Colors.black38,
              child: Center(
                child: Image.asset(
                  './images/lake.jpg',
                  width: 100,
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'title',
            ),
            subtitle: Text(
              'subtitle',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: 16,
            ),
            child: Text(
              'Lorem ipsum dolor sit amet, consectetur '
              'adipiscing elit, sed do eiusmod tempor.',
              // style: Theme.of(context).textTheme.bodyText2.copyWith(
              //       color: Colors.black54,
              //       inherit: false,
              //     ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmallDetailsCard extends StatelessWidget {
  const _SmallDetailsCard({
    required this.openContainer,
    required this.item,
  });

  final VoidCallback openContainer;
  final Item item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        item.imageUrl,
        fit: BoxFit.cover,
      ),
    );

    return _InkWellOverlay(
      openContainer: openContainer,
      height: 225,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridTile(child: image),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title, // GalleryLocalizations.of(context).demoMotionPlaceholderTitle,
                    style: textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    item.price,
                    style: textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailsListTile extends StatelessWidget {
  const _DetailsListTile({required this.openContainer});

  final VoidCallback openContainer;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const height = 120.0;

    return _InkWellOverlay(
      openContainer: openContainer,
      height: height,
      child: Row(
        children: [
          Container(
            color: Colors.black38,
            height: height,
            width: height,
            child: Center(
              child: Image.asset(
                './images/lake.jpg',
                width: 60,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'text',
                    style: textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur '
                    'adipiscing elit,',
                    style: textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InkWellOverlay extends StatelessWidget {
  const _InkWellOverlay({
    required this.openContainer,
    required this.height,
    required this.child,
  });

  final VoidCallback openContainer;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: InkWell(
        onTap: openContainer,
        child: child,
      ),
    );
  }
}
