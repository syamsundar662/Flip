import 'package:cached_network_image/cached_network_image.dart';
import 'package:flip/application/business_logic/bloc/search/search_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // context.read<SearchBloc>().add(SearchPageInitalFeedsFetchEvent());
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const CupertinoSearchTextField(),
      ),
      body: BlocConsumer<SearchBloc, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is SearchPageInitialFeedFechingEvent){
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (state is SearchPageInitialFeedFechedEvent) {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 1 / 1.5),
                itemCount: state.postDatas.length,
                itemBuilder: (BuildContext context, int index) {
                  return CachedNetworkImage(imageUrl: state.postDatas[index].imageUrls[0],fit: BoxFit.cover,);
                });
          } else {
            return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    childAspectRatio: 1 / 1.5),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: const Color.fromARGB(48, 93, 93, 93),
                  );
                });
          }
        },
      ),
    ));
  }
}
