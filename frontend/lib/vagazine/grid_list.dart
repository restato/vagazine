import 'package:flutter/material.dart';

class GridListDemo extends StatelessWidget {
  const GridListDemo({Key? key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GridView.count(
        restorationId: 'grid_view_demo_grid_offset',
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        padding: const EdgeInsets.all(8),
        childAspectRatio: 1,
        children: _photos(context).map<Widget>((photo) {
          return _GridPhotoItem(photo: photo);
        }).toList(),
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
    required this.photo,
  }) : super(key: key);

  final _Photo photo;

  @override
  Widget build(BuildContext context) {
    final Widget image = Material(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      clipBehavior: Clip.antiAlias,
      child: Image.network(
        photo.imageUrl,
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
          title: _GridTitleText(photo.title),
          subtitle: _GridTitleText(photo.subtitle),
        ),
      ),
      child: image,
    );
  }
}
