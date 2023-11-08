import 'package:firebase_auth/firebase_auth.dart';
import 'package:flip/application/business_logic/bloc/profile_post/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostSection extends StatelessWidget {
  PostSection({super.key});
  final id = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if(state is ProfileFetchingState){
          return const CircularProgressIndicator.adaptive();
        }else if(state is ProfileFetchedState){
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            shrinkWrap: true,
            itemCount: state.model.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, mainAxisSpacing: 2, crossAxisSpacing: 2),
            itemBuilder: (context, index) {
              return state.model[index].imageUrls[0].isNotEmpty
                  ? Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(state.model[index].imageUrls[0]),
                              fit: BoxFit.cover),
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(1)),
                    )
                  : const SizedBox();
            });
        }
        
      return Container();
      },
    );
  }
}
