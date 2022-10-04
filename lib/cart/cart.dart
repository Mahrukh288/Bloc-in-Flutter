import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingsite/constants.dart';
import 'package:shoppingsite/model/cart_item_model.dart';

import '../bloc/cart_bloc/cart_bloc.dart';

class Cart extends StatefulWidget {
  Cart({Key? key}) : super(key: key);

  //final Function(CartItem) onPressed;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<int> list = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
  List<CartItem> cartItems = [];
  @override
  Widget build(BuildContext context) {
    // final cartItems = context.watch<ShopingCart>().cart;

    int? dropdownValue = list.first;

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 80.0,
            color: Colors.pink[200],
            padding: const EdgeInsets.all(20.0),
            child: const Center(
                child: Text(
              'Cart',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0),
            )),
          ),
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is LoadedCart) {
                  cartItems = state.cartItems;
                }
                return ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(50),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cartItems[index].item.name),
                                  addHeight(3.0),
                                  Text('Price: Rs.'
                                      '${cartItems[index].item.price}'),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () async {
                                        context.read<CartBloc>().add(
                                            DeleteFromCart(
                                                cartItem: cartItems[index]));
                                      },
                                      icon: Icon(Icons.delete)),
                                  DropdownButton(
                                    value: cartItems[index].quantity,
                                    onChanged: (value) {
                                      CartItem cartItem = CartItem(
                                          item: cartItems[index].item,
                                          quantity: value);
                                      context
                                          .read<CartBloc>()
                                          .add(UpdateCart(cartItem: cartItem));
                                      //state.cartItems[index].quantity = value;
                                    },
                                    items:
                                        list.map<DropdownMenuItem>((int value) {
                                      return DropdownMenuItem(
                                          value: value, child: Text('$value'));
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Price'),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        double totalPrice = 0.0;
                        for (int i = 0; i < cartItems.length; i++) {
                          totalPrice = totalPrice +
                              cartItems[i].item.price * cartItems[i].quantity;
                        }

                        return Text('Rs.' '$totalPrice');
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text('Place Order'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
