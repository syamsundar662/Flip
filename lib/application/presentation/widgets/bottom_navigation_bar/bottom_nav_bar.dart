import 'package:flip/application/business_logic/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBarWidget extends StatelessWidget {
  const BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {


    return 
    BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.index,
          onTap: (value){ 
            context.read<BottomNavBarBloc>().add(BottomNavbarOnTapEvent(index: value));
          },
          selectedItemColor: Colors.amber,
          type: BottomNavigationBarType.fixed,
          items: const [
             BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
             BottomNavigationBarItem(icon: Icon(Iconsax.discover), label: 'Explore'),
             BottomNavigationBarItem(icon: Icon(Iconsax.notification_1), label: 'Notification'),
             BottomNavigationBarItem(icon: Icon(Iconsax.user),label: 'Profile'),
          ],
        );
      },
    );
  }
}
