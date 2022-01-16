// import 'package:flutter/material.dart';
// import 'vagazine/app.dart';

// void main() => runApp(const VagazineApp());
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Item {
  final int id;
  final String title;
  final String price;
  final String imageUrl;

  Item({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      title: json['title'],
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

Future<List<Album>> fetchAlbums() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    List<Album> albums = [];
    List<dynamic> albumsJson = jsonDecode(response.body);
    albumsJson.forEach(
      (oneAlbum) {
        Album album = Album.fromJson(oneAlbum);
        albums.add(album);
      },
    );
    return albums;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;

  Album({
    required this.userId,
    required this.id,
    required this.title,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          // child: FutureBuilder<List<Album>>(
          child: FutureBuilder<List<Item>>(
            future: fetchItems(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // List<Album>? resData = snapshot.data;
                List<Item>? resData = snapshot.data;
                return ListView.builder(
                    itemCount: resData != null ? resData.length : 0,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          // FlutterLogo(size: 56.0), 'https://picsum.photos/250?image=9'
                          // leading:
                          //     Image.network(resData?[index].imageUrl ?? ""),
                          leading: GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () {},
                            child: Container(
                              width: 48,
                              height: 48,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              alignment: Alignment.center,
                              child: Image.network(resData?[index].imageUrl ??
                                  ""), // const CircleAvatar(),
                            ),
                          ),
                          title: Text(resData?[index].title ?? ""),
                          subtitle: Text(resData?[index].title ?? ""),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
