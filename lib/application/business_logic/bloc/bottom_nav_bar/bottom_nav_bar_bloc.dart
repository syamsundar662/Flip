import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flip/application/presentation/screens/home_screen/home_screem.dart';
import 'package:flip/application/presentation/screens/notification_screen/notification_screen.dart';
import 'package:flip/application/presentation/screens/profile_screen.dart/profile_screen.dart';
import 'package:flip/application/presentation/screens/search_screen.dart/search_screen.dart';

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
      final pages =[
HomeScreen(),
SearchScreen(),
NotificationScreen(),
ProfileScreen()
];
}
