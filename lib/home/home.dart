import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/home_bloc/home_bloc.dart';
import '../model/item_model.dart';
import 'components/cutomized_appbar.dart';
import 'components/item_details.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Item> items = [];

    return Scaffold(
      body: Column(
        children: [
          CustomizedAppBar(),
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is LoadingHome) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                );
              }
              if (state is LoadedHome) {
                items = state.items;
              }
              return Expanded(
                child: GridView.builder(
                    itemCount: items.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (BuildContext context, int index) {
                      return ItemDetails(item: items[index]);
                    }),
              );
            },
          )
        ],
      ),
    );
  }
}
