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
