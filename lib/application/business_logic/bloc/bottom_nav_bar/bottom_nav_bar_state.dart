part of 'bottom_nav_bar_bloc.dart';

class BottomNavBarState {
  final int index;
  BottomNavBarState({required this.index});
}

final class BottomNavBarInitial extends BottomNavBarState {
  BottomNavBarInitial():super(index: 0);
}
