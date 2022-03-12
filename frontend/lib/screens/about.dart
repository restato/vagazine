import 'package:flutter/material.dart';
import 'package:vagazine/app_theme.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_markdown/flutter_markdown.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: VagazineAppTheme.buildLightTheme(),
        child: Scaffold(
            body: Stack(children: <Widget>[
          InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(children: <Widget>[
                getAppBarUI(),
                Expanded(
                    child: Container(
                        alignment: Alignment.center,
                        height: double.infinity,
                        width: double.infinity,
                        color:
                            VagazineAppTheme.buildLightTheme().backgroundColor,
                        child: FutureBuilder(
                            future: getData(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return const Text('✉️ direcision@gmail.com');
                                // return Markdown(data: snapshot.data);
                              }
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            })))
                // const Text('vagazine88@gmail.com')))
              ]))
        ])));
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

  Future<String> getData() async {
    String url =
        'https://raw.githubusercontent.com/mxstbr/markdown-test-file/master/TEST.md';
    // rootBundle.loadString("assets/about.md");
    var response = await http.get(Uri.parse(url));
    return response.body;
  }
}
