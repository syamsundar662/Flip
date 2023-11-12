import 'package:carousel_slider/carousel_slider.dart';
import 'package:flip/application/business_logic/bloc/home/fetch_bloc.dart';import 'package:flip/application/presentation/screens/home_screen/widgets/main_card_buttons.dart';
import 'package:flip/application/presentation/screens/message_screen/message_screen.dart';
import 'package:flip/application/presentation/screens/post_screen/post_screen.dart';
import 'package:flip/application/presentation/utils/timestamp/time_stamp.dart';
import 'package:flip/application/presentation/widgets/flip_logo/flip_logo.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context); 
    return RefreshIndicator.adaptive(
      onRefresh: () async {
         Future.delayed(const Duration(seconds: 1));
        context.read<FetchBloc>().add(HomeFetchPostEvent());
      },
      child: Scaffold(
          body: CustomScrollView(slivers: [
        SliverAppBar(
          floating: true,
          centerTitle: false,
          title: const FlipLogoText(
            logoSize: 35,
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const PostScreen()));
                },
                icon: const Icon(Iconsax.add_square)),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const MessageScreen()));
                },
                icon: const Icon(Iconsax.sms_notification)),
          ],
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              children: [
                const StorySection(),
                const Divider(
                  thickness: .1,
                ),
                BlocBuilder<FetchBloc, FetchState>(
                  builder: (context, state) {
                    if (state is HomeDataFetchingState) {
                      return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
                    } else if (state is HomeDataFechedState) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                         itemCount: state.model.length, 
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                 Row(
                                  children: [
                                    const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/IMG_2468.JPG'),
                                      radius: 18,
                                    ),
                                    kWidth10,
                                    Text(
                                      state.model[index].username ,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.more_vert)
                                  ],
                                ),
                                kHeight10,
                                state.model[index].imageUrls.isNotEmpty
                                    ? CarouselSlider.builder(
                                      options: CarouselOptions(
                                        padEnds: true ,
                                        autoPlay: true,
                                        pauseAutoPlayOnTouch: true,
                                        enlargeCenterPage: true,
                                        height:screenFullHeight / 1.8 ,
                                        viewportFraction: 1,
                                        aspectRatio: 16/9 ,
                                        enableInfiniteScroll: false
                                      ),
                                      itemCount: state.model[index].imageUrls.length,
                                      itemBuilder: (context,inde,_){
                                        return ClipRRect(
                                          borderRadius: const BorderRadius.all( Radius.circular(10)),
                                          child: Container(
                                            // padding: EdgeInsets.all(8),
                                            constraints: BoxConstraints(
                                                maxHeight:
                                                    screenFullHeight / 1.8),
                                            width: double.infinity,
                                            child: Image.network(
                                              state.model[index].imageUrls[inde],
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                     
                                    )
                                    : Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          color: const Color.fromARGB(
                                              20, 159, 159, 159),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Text(
                                            state.model[index].textContent,
                                            style:
                                                const TextStyle(fontSize: 18),
                                          ),
                                        ),
                                      ),
                                const PostMainCommonButtons(),
                                const Row(
                                  children: [
                                    kWidth10,
                                    Text(
                                      '324 likes and ',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    // kWidth10,
                                    Text(
                                      '56 comments',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                state.model[index].imageUrls.isNotEmpty
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            left: 10.5, right: 10),
                                        child: Text(
                                          state.model[index].textContent,
                                          style: const TextStyle(
                                            fontSize: 15,
                                          ),
                                        ),
                                      )
                                    : const SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.5),
                                  child: Text(
                                    timeAgo(state.model[index].timestamp),
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                  ),
                                ),
                                const Divider(
                                  thickness: .1,
                                )
                              ],
                            );
                          });
                    } else {
                      return Container();
                    }
                  },
                )
              ],
            ),
          ]),
        ),
      ])),
    );
  }
}

class StorySection extends StatelessWidget {
  const StorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(left: 7),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: index == 0
                          ? const AssetImage('assets/IMG_2468.JPG')
                          : const AssetImage(
                              'assets/brunette-girl-walking-through-park-during-autumn.jpg'),
                      radius: 35,
                    ),
                    index == 0
                        ? const Text('Faizy', style: TextStyle(fontSize: 12))
                        : const Text(
                            'Jasmy jain',
                            style: TextStyle(fontSize: 12),
                          )
                  ],
                ));
          }),
    );
  }
}
