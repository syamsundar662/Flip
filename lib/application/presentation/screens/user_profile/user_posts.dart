
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip/application/business_logic/bloc/user_profile/profile_bloc.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/post_view.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/domain/models/user_model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class UserPostSection extends StatelessWidget {
  const  UserPostSection({super.key, required this.userData});
  final UserModel userData;

  @override   
  Widget build(BuildContext context) {

    context.read<ProfileBloc>().add(ProfilePostDataFetchEvent(id: userData.userId));
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (pre, cur) =>
          cur is ProfileFetchingState || cur is ProfileFetchedState,
      builder: (context, state) {
        print(state);
        if (state is ProfileFetchedState) {
          if (state.model.isEmpty) {
            return const Text(
              'No posts',
              style: TextStyle(color: Colors.amber),
            );
          }
          return GridView.builder(
              itemCount: state.model.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PostViewScreen(model: state.model[index])));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  state.model[index].imageUrls[0]),
                              fit: BoxFit.cover),
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(1)),
                    ));
              });
        }
        return SizedBox(
          height: screenFullHeight / 2,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
              itemCount: 9,
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Theme.of(context).colorScheme.primary,
                  highlightColor: Theme.of(context).colorScheme.background,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1),
                        color: Colors.grey),
                  ),
                );
              }),
        );
      },
    );
  }
}