import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'card_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

const String _title = 'Vagazine';

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ContainerTransitionType _transitionType = ContainerTransitionType.fade;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Navigator(
        key: ValueKey(_transitionType),
        onGenerateRoute: (settings) {
          return MaterialPageRoute<void>(
            builder: (context) => Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Column(
                  children: [
                    Text(_title),
                    // Text(
                    //   '(${localizations.demoContainerTransformDemoInstructions})',
                    //   style: Theme.of(context)
                    //       .textTheme
                    //       .subtitle2
                    //       .copyWith(color: Colors.white),
                    // ),
                  ],
                ),
              ),
              body: CardList(),
            ),
          );
        });
  }
}
