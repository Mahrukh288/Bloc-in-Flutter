part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  //const HomeState();
  @override
  List<Object> get props => [];
}

class LoadingHome extends HomeState {}

class LoadedHome extends HomeState {
  List<Item> items;
  LoadedHome({required this.items});
  @override
  List<Object> get props => [items];
}
