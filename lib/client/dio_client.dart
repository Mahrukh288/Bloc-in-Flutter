import 'package:dio/dio.dart';

import '../model/item_model.dart';

class DioClient {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://fakestoreapi.com',
  ));

  Future<List<Item>> getItems() async {
    List<Item> items = [];
    try {
      Response itemData = await _dio.get('/products');
      List<dynamic> jsonProductList = itemData.data;
      Item obj;
      for (int i = 0; i < jsonProductList.length; i++) {
        obj = Item.fromJson(jsonProductList[i]);
        items.add(obj);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print('Error Status: ${e.response?.statusCode}');
      } else {
        print('Error Sending Request: ${e.message}');
      }
    }
    return items;
  }
}
