import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/profile/user_data/profile_bloc.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/post_view.dart';
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
          return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: state.model.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
              itemBuilder: (context, index) {
                return state.model[index].imageUrls[0].isNotEmpty
                    ? GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PostViewScreen(
                                      model: state.model[index])));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                      state.model[index].imageUrls[0]),
                                  fit: BoxFit.cover),
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(1)),
                        ),
                      )
                    : const SizedBox();
              });
        }

        return SizedBox(
          height: 300,
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 2, mainAxisSpacing: 2),
              itemCount: 6,
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
