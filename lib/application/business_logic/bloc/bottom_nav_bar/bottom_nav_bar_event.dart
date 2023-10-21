part of 'bottom_nav_bar_bloc.dart';

class BottomNavBarEvent {}

class BottomNavbarOnTapEvent extends BottomNavBarEvent{
final int index;
BottomNavbarOnTapEvent({required this.index});

}
