import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/user_profile/profile_bloc.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/post_view.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/utils/timestamp/time_stamp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PostSection extends StatelessWidget {
  const PostSection({super.key});

  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;
    context.read<ProfileBloc>().add(ProfilePostDataFetchEvent(id: id));
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (pre, cur) =>
          cur is ProfileFetchingState || cur is ProfileFetchedState,
      builder: (context, state) {
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
        return const PostViewShimmer();
      },
    );
  }
}

class SavedPostSection extends StatelessWidget {
  const SavedPostSection({super.key});

  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;
    context.read<ProfileBloc>().add(ProfileSavedPostFetchEvent(id: id));
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (pre, cur) =>
          cur is ProfileSavedPostFetchingState ||
          cur is ProfileSavedPostFetchedState,
      builder: (context, state) {
        if (state is ProfileSavedPostFetchedState) {
          if (state.postModel.isEmpty) {
            return const Text(
              'No posts',
              style: TextStyle(color: Colors.amber),
            );
          }
          return GridView.builder(
              itemCount: state.postModel.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PostViewScreen(
                                  model: state.postModel[index])));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  state.postModel[index].imageUrls[0]),
                              fit: BoxFit.cover),
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(1)),
                    ));
              });
        }
        return const PostViewShimmer();
      },
    );
  }
}

class ThoughtsPostSection extends StatelessWidget {
  const ThoughtsPostSection({super.key});

  @override
  Widget build(BuildContext context) {
    final id = FirebaseAuth.instance.currentUser!.uid;
    context.read<ProfileBloc>().add(ProfileThoughtFetchEvent(id: id));
    return BlocBuilder<ProfileBloc, ProfileState>(
      buildWhen: (pre, cur) =>
          cur is ProfileThoughtFetchingState ||
          cur is ProfileThoughtFetchedState,
      builder: (context, state) {
        if (state is ProfileThoughtFetchedState) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: state.model.length,
            itemBuilder: (context, index) {
              return state.model[index].textContent.isNotEmpty &&
                      state.model[index].imageUrls.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color.fromARGB(20, 159, 159, 159),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.grey[900],
                                backgroundImage: const AssetImage(
                                    "assets/bearded-man-staying-nature.jpg"),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  state.model[index].textContent,
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    timeAgo(
                                      state.model[index].timestamp,
                                    ),
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .secondary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox();
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

class PostViewShimmer extends StatelessWidget {
  const PostViewShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                    borderRadius: BorderRadius.circular(1), color: Colors.grey),
              ),
            );
          }),
    );
  }
}
