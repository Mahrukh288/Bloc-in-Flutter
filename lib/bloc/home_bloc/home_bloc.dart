import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../client/dio_client.dart';
import '../../model/item_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DioClient _client = DioClient();
  HomeBloc() : super(LoadingHome()) {
    on<LoadHome>(_onLoadHome);
  }
  Future<void> _onLoadHome(LoadHome event, Emitter<HomeState> emit) async {
    emit(LoadingHome());
    List<Item> shoppingItems = await _client.getItems();
    emit(LoadedHome(items: shoppingItems));
  }
}
