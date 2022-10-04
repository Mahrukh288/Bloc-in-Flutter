part of 'cart_bloc.dart';

@immutable
abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {
  @override
  List<Object?> get props => [];
}

class AddToCart extends CartEvent {
  final CartItem cartItem;
  const AddToCart({required this.cartItem});
  @override
  List<Object> get props => [cartItem];
}

class UpdateCart extends CartEvent {
  final CartItem cartItem;
  const UpdateCart({required this.cartItem});
  @override
  List<Object> get props => [cartItem];
}

class DeleteFromCart extends CartEvent {
  final CartItem cartItem;
  const DeleteFromCart({required this.cartItem});
  @override
  List<Object> get props => [cartItem];
}
