class Item {
  int id;
  String photo;
  String name;
  double price;
  Item(
      {required this.id,
      required this.photo,
      required this.name,
      required this.price});

  factory Item.fromJson(Map<String, dynamic> parsedJson) {
    Item item = Item(
        id: parsedJson["id"] ?? 0,
        photo: parsedJson["image"] ?? "",
        name: parsedJson["title"] ?? "",
        price: parsedJson["price"] ?? "");
    return item;
  }
}
