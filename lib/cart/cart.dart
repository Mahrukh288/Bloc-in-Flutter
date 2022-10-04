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
  double totalPrice = 0.0;
  List<int> list = <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    // final cartItems = context.watch<ShopingCart>().cart;

    int? dropdownValue = list.first;

    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        //bloc: context.watch<CartBloc>(),
        builder: (context, state) {
          if (state is LoadedCart) {
            for (int i = 0; i < state.cartItems.length; i++) {
              totalPrice = totalPrice +
                  state.cartItems[i].item.price * state.cartItems[i].quantity;
            }
            return Column(
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
                  child: ListView.builder(
                    itemCount: state.cartItems.length,
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
                                    Text(state.cartItems[index].item.name),
                                    addHeight(3.0),
                                    Text('Price: Rs.'
                                        '${state.cartItems[index].item.price}'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        onPressed: () async {
                                          context.read<CartBloc>().add(
                                              DeleteFromCart(
                                                  cartItem:
                                                      state.cartItems[index]));
                                        },
                                        icon: Icon(Icons.delete)),
                                    DropdownButton(
                                      value: state.cartItems[index].quantity,
                                      onChanged: (value) {
                                        CartItem cartItem = CartItem(
                                            item: state.cartItems[index].item,
                                            quantity: value);
                                        context.read<CartBloc>().add(
                                            UpdateCart(cartItem: cartItem));
                                        //state.cartItems[index].quantity = value;
                                      },
                                      items: list
                                          .map<DropdownMenuItem>((int value) {
                                        return DropdownMenuItem(
                                            value: value,
                                            child: Text('$value'));
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
                          Text('Rs.' '$totalPrice'),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () {}, child: const Text('Place Order'))
                    ],
                  ),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
