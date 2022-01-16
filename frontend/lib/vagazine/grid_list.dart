import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Item {
  final int id;
  final String title;
  final String url;
  final String price;
  final String imageUrl;

  Item({
    required this.id,
    required this.title,
    required this.url,
    required this.price,
    required this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }
}

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

class GridListDemo extends StatelessWidget {
  const GridListDemo({Key? key}) : super(key: key);
  // Future<List<Item>> futureItems;

  List<_Photo> _photos(BuildContext context) {
    return [
      _Photo(
          imageUrl:
              'http://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/241314894070500-c2b90551-d723-41df-9f3f-8f4c541abdc3.jpg',
          title: 'hi',
          subtitle: 'bye'),
      _Photo(
          imageUrl:
              'http://thumbnail10.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/241314894070500-c2b90551-d723-41df-9f3f-8f4c541abdc3.jpg',
          title: 'hi',
          subtitle: 'bye'),
    ];
  }

  // @override
  // void initState() {
  //   super.initState();
  //   futureItems = fetchItems();
  // }

  // Future<void> _pullRefresh() async {
  //   List<Item> freshItems = await fetchItems();
  //   setState(() {
  //     futureItems = Future.value(freshItems);
  //   });
  // }

  Widget _gridView(AsyncSnapshot snapshot) {
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
            return GestureDetector(
                onTap: () {
                  launchURL(item.url);
                },
                child: _GridPhotoItem(item: item));
          });
    } else if (snapshot.hasError) {
      return Text('${snapshot.error}');
    }
    return const CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vagazine',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
        appBar: AppBar(title: const Text('Vagazine')),
        body: Center(
          child: FutureBuilder<List<Item>>(
            future: fetchItems(),
            builder: (context, snapshot) {
              return _gridView(snapshot);
            },
          ),
        ),
      ),
    );
  }
}

class _Photo {
  final String imageUrl;
  final String title;
  final String subtitle;

  _Photo({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });
}

class _GridTitleText extends StatelessWidget {
  const _GridTitleText(this.text);

  final String text;
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      alignment: AlignmentDirectional.centerStart,
      child: Text(text),
    );
  }
}

class _GridPhotoItem extends StatelessWidget {
  const _GridPhotoItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  // final _Photo photo;
  final Item item;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        item.imageUrl,
        fit: BoxFit.cover,
      ),
    );

    return GridTile(
      footer: Material(
        color: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(4)),
        ),
        clipBehavior: Clip.antiAlias,
        child: GridTileBar(
          backgroundColor: Colors.black45,
          title: _GridTitleText(item.title),
          subtitle: _GridTitleText(item.price),
        ),
      ),
      child: image,
    );
  }
}
