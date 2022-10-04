import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/cart_item_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<CartItem> cartItemList = [];
  Future<void> updatePreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonString = json.encode(cartItemList);
    preferences.setString('Cart', jsonString);
  }

  CartBloc() : super(LoadingCart()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<UpdateCart>(_onUpdateCart);
    on<DeleteFromCart>(_onDeleteFromCart);
  }
  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonString = preferences.getString('Cart');
    if (jsonString == null) {
      emit(
        LoadedCart(cartItems: const []),
      );
    } else {
      List<dynamic> jsonList = json.decode(jsonString);
      CartItem obj;
      for (int i = 0; i < jsonList.length; i++) {
        obj = CartItem.fromJson(jsonList[i]);
        cartItemList.add(obj);
      }
      emit(
        LoadedCart(cartItems: cartItemList),
      );
    }
  }

  void _onAddToCart(AddToCart event, Emitter<CartState> emit) {
    if (cartItemList.isEmpty) {
      cartItemList.add(event.cartItem);
    } else {
      cartItemList.removeWhere((element) {
        if (element.item.id == event.cartItem.item.id) {
          event.cartItem.quantity = event.cartItem.quantity + element.quantity;
          return true;
        } else {
          return false;
        }
      });
      cartItemList.add(event.cartItem);
    }
    emit(LoadedCart(cartItems: cartItemList));
    updatePreferences();
  }

  void _onUpdateCart(UpdateCart event, Emitter<CartState> emit) {
    cartItemList
        .removeWhere((element) => element.item.id == event.cartItem.item.id);
    cartItemList.add(event.cartItem);
    emit(LoadedCart(cartItems: cartItemList));
    updatePreferences();
  }

  void _onDeleteFromCart(DeleteFromCart event, Emitter<CartState> emit) {
    cartItemList.removeWhere((element) => element.item == event.cartItem.item);
    emit(LoadedCart(cartItems: cartItemList));
    updatePreferences();
  }
}
