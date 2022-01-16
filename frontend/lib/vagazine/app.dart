// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';

// Widget textSection = const Padding(
//   padding: EdgeInsets.all(32),
//   child: Text(
//     'Lake Oeschinen lies at the foot of the Blüemlisalp in the Bernese '
//     'Alps. Situated 1,578 meters above sea level, it is one of the '
//     'larger Alpine Lakes. A gondola ride from Kandersteg, followed by a '
//     'half-hour walk through pastures and pine forest, leads you to the '
//     'lake, which warms to 20 degrees Celsius in the summer. Activities '
//     'enjoyed here include rowing, and riding the summer toboggan run.',
//     softWrap: true,
//   ),
// );

// Widget titleSection = Container(
//   padding: const EdgeInsets.all(32),
//   child: Row(
//     children: [
//       Expanded(
//         /*1*/
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             /*2*/
//             Container(
//               padding: const EdgeInsets.only(bottom: 8),
//               child: const Text(
//                 'Oeschinen Lake Campground',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Text(
//               'Kandersteg, Switzerland',
//               style: TextStyle(
//                 color: Colors.grey[500],
//               ),
//             ),
//           ],
//         ),
//       ),
//       /*3*/
//       Icon(
//         Icons.star,
//         color: Colors.red[500],
//       ),
//       const Text('41'),
//     ],
//   ),
// );

// Widget itemSection = Container(child: Text("item Section"));

// class VagazineApp extends StatelessWidget {
//   const VagazineApp({Key? key}) : super(key: key);

//   static const String _title = 'Vagazine';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: _title,
//       home: MyStatefulWidget(),
//     );
//   }
// }

// // class Item {
// //   final int id;
// //   final String title;
// //   final String name;
// //   final int price;
// //   final String imageUrl;

// //   Item({this.id, this.title, this.name, this.price, this.imageUrl});

// //   factory Item.fromJson(Map<String, dynamic> json) {
// //     return Item(
// //       id: json['id'],
// //       title: json['title'],
// //       name: json['name'],
// //       price: json['price'],
// //       imageUrl: json['imageUrl'],
// //     );
// //   }
// // }

// class Post {
//   final int userId;
//   final int id;
//   final String title;
//   final String body;

//   Post({this.userId, this.id, this.title, this.body});

//   factory Post.fromJson(Map<String, dynamic> json) {
//     return Post(
//       userId: json['userId'],
//       id: json['id'],
//       title: json['title'],
//       body: json['body'],
//     );
//   }
// }

// Future<http.Response> fetchPost() {
//   return http.get('https://jsonplaceholder.typicode.com/posts/1');
// }

// // Future<http.Response> fetchItems() {
// //   // return http.get('https://jsonplaceholder.typicode.com/posts/1');
// //   return http.get('https://dongsan.club/items');
// // }

// Future<Post> fetchPost() async {
//   final response =
//       await http.get('https://jsonplaceholder.typicode.com/posts/1');

//   if (response.statusCode == 200) {
//     // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
//     return Post.fromJson(json.decode(response.body));
//   } else {
//     // 만약 응답이 OK가 아니면, 에러를 던집니다.
//     throw Exception('Failed to load post');
//   }
// }

// class _ItemListWidgetState extends State<ItemListWidget> {
//   // List<dynamic> items = ['A', 'B', 'C', 'D', 'E', 'G'];
//   Future<Post> items;

//   @override
//   void initState() {
//     super.initState();
//     items = fetchPost();
//   }

//   _requestItems() async {
//     var url = Uri.parse('https://dongsan.club/items');
//     print(url);
//     var response = await http.get(url);
//     var statusCode = response.statusCode;
//     print(response);

//     List<dynamic> list = [];
//     if (statusCode == 200) {
//       String responseBody = utf8.decode(response.bodyBytes);
//       list = jsonDecode(responseBody);
//     }

//     setState(() {
//       items = list;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // var _navigationTextStyle =
//     //     TextStyle(color: CupertinoColors.white, fontFamily: 'GyeonggiMedium');
//     // var _listTextStyle =
//     //     TextStyle(color: CupertinoColors.black, fontFamily: 'GyeonggiLight');

//     // var _navigationBar = CupertinoNavigationBar(
//     //     middle: Text("Vagazine") //, style: _navigationTextStyle),
//     //     backgroundColor: CupertinoColors.systemBlue);

//     var _listView = ListView.separated(
//       padding: const EdgeInsets.all(4),
//       itemCount: items.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Container(child: Text(items[index]) // , style: _listTextStyle),
//             );
//       },
//       separatorBuilder: (BuildContext context, int index) {
//         return Divider();
//       },
//     );

//     return CupertinoPageScaffold(
//       // navigationBar: _navigationBar,
//       child: _listView,
//     );
//   }
// }

// class ItemListWidget extends StatefulWidget {
//   @override
//   _ItemListWidgetState createState() => _ItemListWidgetState();
// }

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   int _selectedIndex = 0;
//   static const TextStyle optionStyle =
//       TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
//   static const List<Widget> _widgetOptions = <Widget>[
//     Text(
//       'Index 0: Home',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 1: Business',
//       style: optionStyle,
//     ),
//     Text(
//       'Index 2: School',
//       style: optionStyle,
//     ),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   Column _buildButtonColumn(Color color, IconData icon, String label) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Icon(icon, color: color),
//         Container(
//           margin: const EdgeInsets.only(top: 8),
//           child: Text(
//             label,
//             style: TextStyle(
//               fontSize: 12,
//               fontWeight: FontWeight.w400,
//               color: color,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     Color color = Theme.of(context).primaryColor;

//     Widget buttonSection = Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _buildButtonColumn(color, Icons.call, 'CALL'),
//         _buildButtonColumn(color, Icons.near_me, 'ROUTE'),
//         _buildButtonColumn(color, Icons.share, 'SHARE'),
//       ],
//     );

//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Vagazine'),
//         ),
//         // body: Center(
//         //   child: _widgetOptions.elementAt(_selectedIndex),
//         // ),
//         // body: ListView(
//         //   children: [
//         //     Image.asset(
//         //       'images/lake.jpg',
//         //       width: 600,
//         //       height: 240,
//         //       fit: BoxFit.cover,
//         //     ),
//         //     titleSection,
//         //     Container(),
//         //     // itemSection,
//         //     // ItemListWidget(),
//         //     buttonSection,
//         //     textSection
//         //   ],
//         // ),
//         body: ItemListWidget()
//         // bottomNavigationBar: BottomNavigationBar(
//         //   items: const <BottomNavigationBarItem>[
//         //     BottomNavigationBarItem(
//         //       icon: Icon(Icons.home),
//         //       label: 'Home',
//         //     ),
//         //     BottomNavigationBarItem(
//         //       icon: Icon(Icons.business),
//         //       label: 'Business',
//         //     ),
//         //     BottomNavigationBarItem(
//         //       icon: Icon(Icons.school),
//         //       label: 'School',
//         //     ),
//         //   ],
//         //   currentIndex: _selectedIndex,
//         //   selectedItemColor: Colors.amber[800],
//         //   onTap: _onItemTapped,
//         // ),
//         );
//   }
// }
