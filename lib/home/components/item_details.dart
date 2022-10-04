import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shoppingsite/model/cart_item_model.dart';

import '../../bloc/cart_bloc/cart_bloc.dart';
import '../../constants.dart';
import '../../model/item_model.dart';

class ItemDetails extends StatefulWidget {
  const ItemDetails({Key? key, required this.item}) : super(key: key);
  final Item item;

  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  int quantity = 1;

  increaseQuantity() {
    setState(() {
      quantity++;
    });
  }

  decreaseQuantity() {
    setState(() {
      if (quantity > 1) quantity--;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30.0),
      color: Colors.pink[50],
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Expanded(child: Image.network(widget.item.photo)),
          addHeight(3.0),
          Text(widget.item.name),
          addHeight(3.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Price"),
              Text('${widget.item.price}'),
            ],
          ),
          addHeight(3.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    CartItem cartItem =
                        CartItem(item: widget.item, quantity: quantity);
                    context.read<CartBloc>().add(AddToCart(cartItem: cartItem));

                    // widget.onPressed(quantity);
                    // quantity = 1;
                  },
                  icon: const Icon(
                    Icons.add_shopping_cart,
                    color: Colors.red,
                  )),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        increaseQuantity();
                      },
                      icon: const Icon(Icons.exposure_plus_1)),
                  Text('$quantity'),
                  IconButton(
                      onPressed: () {
                        decreaseQuantity();
                      },
                      icon: const Icon(
                        Icons.exposure_minus_1,
                      ))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
