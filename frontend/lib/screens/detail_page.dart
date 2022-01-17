import 'package:flutter/material.dart';

const String _text = "상세페이지 내용입니다";

class DetailPage extends StatelessWidget {
  const DetailPage();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('상세화면'),
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.black38,
            child: Padding(
              padding: const EdgeInsets.all(70),
              child: const Text("Main Image"),
              // child: Image.asset(
              //   './images/lake.jpg',
              // ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'text',
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
