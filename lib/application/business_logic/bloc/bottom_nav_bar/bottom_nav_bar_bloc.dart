import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flip/application/presentation/screens/home_screen/home_screen.dart';
import 'package:flip/application/presentation/screens/notification_screen/notification_screen.dart';
import 'package:flip/application/presentation/screens/post_screen/post_screen.dart';
import 'package:flip/application/presentation/screens/profile_screen/profile_screen.dart';
import 'package:flip/application/presentation/screens/search_screen/search_screen.dart';
part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc() : super(BottomNavBarInitial()) {
    on<BottomNavbarOnTapEvent>(bottomNavbarOnTapEvent);
  }

  FutureOr<void> bottomNavbarOnTapEvent(
      BottomNavbarOnTapEvent event, Emitter<BottomNavBarState> emit) {
    emit(BottomNavBarState(index: event.index));
  }
  final pages = [
    const HomeScreen(),
    const SearchScreen(),
     PostScreen(),
     const NotificationScreen(),
    const ProfileScreen()
  ];
}
