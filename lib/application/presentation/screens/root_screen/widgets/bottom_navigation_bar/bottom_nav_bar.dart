import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flip/application/business_logic/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBarWidget extends StatelessWidget {
  final PageController _pageController = PageController();

  BottomNavBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (index) {
                context
                    .read<BottomNavBarBloc>()
                    .add(BottomNavbarOnTapEvent(index: index));
              },
              children: context.read<BottomNavBarBloc>().screens),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.index,
            onTap: (value) {
              _pageController.animateToPage(
                value,
                duration: const Duration(microseconds: 1),
                curve: Curves.decelerate,
              );
            },
            showSelectedLabels: false,
            showUnselectedLabels: false,
            iconSize: 23,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Iconsax.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.discover), label: 'Explore'),
              // BottomNavigationBarItem(
              //     icon: Icon(Iconsax.location), label: 'Flip'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.notification_status),
                  label: 'Notification'),
              BottomNavigationBarItem(
                  icon: Icon(Iconsax.user), label: 'Profile'),
            ],
          ),
        );
      },
    );
  }
}
