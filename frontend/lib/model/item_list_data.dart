class ItemListData {
  ItemListData({
    this.id = 0,
    this.title = '',
    this.desc = '',
    this.url = '',
    this.price = '80',
    this.imageUrl = '',
  });

  int id;
  String title;
  String url;
  String desc;
  String price;
  String imageUrl;

  factory ItemListData.fromJson(Map<String, dynamic> json) {
    return ItemListData(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      desc: json['desc'],
      price: json['price'],
      imageUrl: json['imageUrl'],
    );
  }

  static List<ItemListData> itemList = <ItemListData>[
    ItemListData(
        imageUrl:
            "http://thumbnail9.coupangcdn.com/thumbnails/remote/230x230ex/image/retail/images/82584787055029-ac20e8ad-8771-4b8f-83a4-c45980a8ebdc.jpg",
        title: "마더케이 신생아용 프리미엄 순면 건티슈",
        desc: "desc",
        price: "80,000원",
        id: 0,
        url:
            "https://link.coupang.com/re/CSHARESDP?lptag=CFM60714948&pageKey=5585680852&itemId=119183238&vendorItemId=324094168")
  ];
}
