part of 'cart_bloc.dart';

@immutable
abstract class CartState extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingCart extends CartState {}

class LoadedCart extends CartState {
  List<CartItem> cartItems;
  LoadedCart({required this.cartItems}) {
    List<CartItem> templist = List.from(cartItems);
    cartItems = templist;
  }

  @override
  List<Object> get props => [cartItems];
}
