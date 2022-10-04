import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/cart_bloc/cart_bloc.dart';
import '../../cart/cart.dart';

class CustomizedAppBar extends StatelessWidget {
  CustomizedAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int counter = 0;

    return Container(
      height: 80.0,
      color: Colors.pink[200],
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Cute Little Things',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Cart(),
                    ));
                  },
                  icon: const Icon(Icons.shopping_cart)),
              BlocBuilder<CartBloc, CartState>(
                bloc: context.watch<CartBloc>(),
                builder: (context, state) {
                  if (state is LoadedCart) {
                    for (int i = 0; i < state.cartItems.length; i++) {
                      counter = counter + state.cartItems[i].quantity;
                    }
                  }
                  return Text('$counter');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
