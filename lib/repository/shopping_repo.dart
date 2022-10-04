import '../model/item_model.dart';

class ShoppingRepo {
  List<Item> dummyItems = [
    Item(
        id: 1,
        photo: "assets/images/watch.jpg",
        name: 'Golden Watch',
        price: 10.0),
    Item(
        id: 2, photo: "assets/images/bag.webp", name: 'Brown Bag', price: 50.0),
    Item(
        id: 3,
        photo: "assets/images/couplewatch.jpg",
        name: 'Golden Couple Watch',
        price: 10.0),
    Item(
        id: 4,
        photo: "assets/images/totebag.jpg",
        name: 'Brown Tote bag',
        price: 50.0),
    Item(
        id: 5,
        photo: "assets/images/brownbag.jpg",
        name: 'Brown Leather bag',
        price: 10.0),
  ];
  ShoppingRepo();

  List<Item> fetchShoppingItems() {
    return dummyItems;
  }
}
