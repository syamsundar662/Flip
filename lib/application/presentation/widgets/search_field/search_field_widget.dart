import 'package:flip/application/business_logic/bloc/search/search_bloc.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchFieldWidget extends StatelessWidget {
  const SearchFieldWidget(
      {super.key,
      required this.width,
      required this.type,
      this.isChat = false,
      this.textEditingController});
  final double width;
  final SearchType type;
  final bool isChat;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenFullHeight * 0.06,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
      ),
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          controller: textEditingController,
          onChanged: (value) async {
            if (SearchType.gloabal == type) {
              if (value.isEmpty) {
                context.read<SearchBloc>().add(InitialSearch());
                return;
              }
              context.read<SearchBloc>().add(UserSearchEvent(query: value));
            }
          },
          decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search_rounded, color: Colors.lightBlue),
              hintText: 'Search',
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none),
        ),
      ),
    );
  }
}
