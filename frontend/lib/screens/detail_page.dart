import 'package:flutter/material.dart';
import '../models/item.dart';

const String _text = "상세페이지 내용입니다";

class DetailPage extends StatelessWidget {
  const DetailPage({
    required this.item,
  });

  final Item item;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.black38,
            child: Padding(
              padding: const EdgeInsets.all(70),
              child: Image.network(item.imageUrl),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.price,
                  // style: textTheme.headline5.copyWith(
                  //   color: Colors.black54,
                  //   fontSize: 30,
                  // ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _text,
                  // style: textTheme.bodyText2.copyWith(
                  //   color: Colors.black54,
                  //   height: 1.5,
                  //   fontSize: 16,
                  // ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
