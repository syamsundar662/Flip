import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip/application/business_logic/bloc/search/search_bloc.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/post_view.dart';
import 'package:flip/application/presentation/screens/search_screen/serchfiled.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/widgets/search_field/search_field_widget.dart';
import 'package:flip/data/firebase_services/post_data_resourse/post_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SearchFieldWidget(
                width: screenFullWidth * 1, type: SearchType.gloabal),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                if (state is SearchLoading) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (state is SearchResultFound) {
                  return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final user = state.users[index];
                        return SearchResultTileWidget(user: user);
                      },
                      itemCount: state.users.length);
                } else if (state is SearchResultEmpty) {
                  return const Center(
                    child: Text(
                      "Not found",
                    ),
                  );
                } else if (state is SearchInitial) {
                  return FutureBuilder(
                      future: PostServices().fetchAllImagePosts(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 1.2,
                                    mainAxisSpacing: 1.2,
                                    childAspectRatio: 1 / 1.6),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CupertinoModalPopupRoute(
                                      builder: (context) => PostViewScreen(
                                          model: snapshot.data![index]),
                                    ));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    image: DecorationImage(
                                        image: CachedNetworkImageProvider(
                                          snapshot.data![index].imageUrls[0],
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      });
                }
                return const SizedBox();
              },
            )
          ],
        ),
      ),
    );
  }
}
