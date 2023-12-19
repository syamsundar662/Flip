import 'package:colorful_safe_area/colorful_safe_area.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:flip/application/business_logic/bloc/home/fetch_bloc.dart';
import 'package:flip/application/business_logic/bloc/search/search_bloc.dart';
import 'package:flip/application/business_logic/bloc/user_profile/profile_bloc.dart';
import 'package:flip/application/presentation/screens/root_screen/widgets/bottom_navigation_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;
    context.read<ProfileBloc>().add(UserDataFetchEvent(id: id));
    context.read<ProfileBloc>().add(ProfilePostDataFetchEvent(id: id));
    context.read<FetchBloc>().add(HomeFetchPostEvent());
    context.read<SearchBloc>().add(SearchPageInitalFeedsFetchEvent()); 

    return ColorfulSafeArea(
      color: Theme.of(context).colorScheme.background,
      child: Scaffold(
        body: BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
          builder: (context, state) {
            return BottomNavBarBloc().screens[state.index];
          },
        ),
        bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
  }
}
