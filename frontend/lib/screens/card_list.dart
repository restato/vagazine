import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import '../screens/detail_page.dart';

class CardList extends StatelessWidget {
  const CardList();

  @override
  Widget build(BuildContext context) {
    ContainerTransitionType _transitionType = ContainerTransitionType.fade;

    return ListView(padding: const EdgeInsets.all(8), children: [
      Row(
        children: [
          Expanded(
            child: _OpenContainerWrapper(
              transitionType: _transitionType,
              closedBuilder: (context, openContainer) {
                return _SmallDetailsCard(
                    openContainer: openContainer, subtitle: 'subtitle');
              },
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: _OpenContainerWrapper(
              transitionType: _transitionType,
              closedBuilder: (context, openContainer) {
                return _SmallDetailsCard(
                    openContainer: openContainer, subtitle: 'subtitle');
              },
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 16,
      ),
      Row(
        children: [
          Expanded(
            child: _OpenContainerWrapper(
              transitionType: _transitionType,
              closedBuilder: (context, openContainer) {
                return _SmallDetailsCard(
                  openContainer: openContainer,
                  subtitle: 'subtitle',
                );
              },
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: _OpenContainerWrapper(
              transitionType: _transitionType,
              closedBuilder: (context, openContainer) {
                return _SmallDetailsCard(
                  openContainer: openContainer,
                  subtitle: 'subtitle',
                );
              },
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: _OpenContainerWrapper(
              transitionType: _transitionType,
              closedBuilder: (context, openContainer) {
                return _SmallDetailsCard(
                  openContainer: openContainer,
                  subtitle: 'subtitle',
                );
              },
            ),
          ),
        ],
      )
    ]);
  }
}

class _OpenContainerWrapper extends StatelessWidget {
  const _OpenContainerWrapper({
    required this.closedBuilder,
    required this.transitionType,
  });

  final CloseContainerBuilder closedBuilder;
  final ContainerTransitionType transitionType;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (context, openContainer) => const DetailPage(title: 'gg'),
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
    required this.subtitle,
  });

  final VoidCallback openContainer;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return _InkWellOverlay(
      openContainer: openContainer,
      height: 225,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            color: Colors.black38,
            height: 150,
            child: Center(
              child: Image.asset(
                './images/lake.jpg',
                width: 80,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'text', // GalleryLocalizations.of(context).demoMotionPlaceholderTitle,
                    style: textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    subtitle,
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
