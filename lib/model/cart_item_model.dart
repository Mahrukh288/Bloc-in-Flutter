import 'item_model.dart';

class CartItem {
  Item item;
  int quantity;
  CartItem({required this.item, required this.quantity});

  factory CartItem.fromJson(Map<String, dynamic> parsedJson) {
    Item item = Item(
        id: parsedJson["item id"] ?? 0,
        photo: parsedJson["item photo"] ?? "",
        name: parsedJson["item name"] ?? "",
        price: parsedJson["item price"] ?? "");
    return CartItem(item: item, quantity: parsedJson["quantity"] ?? 0);
  }

  Map<String, dynamic> toJson() {
    return {
      "item id": item.id,
      "item photo": item.photo,
      "item name": item.name,
      "item price": item.price,
      "quantity": quantity
    };
  }
}
