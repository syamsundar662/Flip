
// working on this feature (Story) some unexpected bugs found

// import 'package:flip/application/presentation/screens/home_screen/home_screen.dart';
// import 'package:flip/application/presentation/utils/constants/constants.dart';
// import 'package:flip/application/presentation/utils/timestamp/time_stamp.dart';
// import 'package:flip/domain/models/story_model/story_model.dart';
// import 'package:flutter/material.dart';
// import 'package:story_view/story_view.dart';

// class ScreenStoryView extends StatefulWidget {
//   const ScreenStoryView({
//     super.key,
//     required this.storyWithUser, 
//   });

//   final StoryWithUser storyWithUser; 

//   @override
//   ScreenStoryViewState createState() => ScreenStoryViewState();
// }

// class ScreenStoryViewState extends State<ScreenStoryView> {
//   late PageController _controller;
//   @override
//   void initState() {
//     super.initState();
//     final initialPage = storiesIn.indexOf(widget.storyWithUser);
//     _controller = PageController(initialPage: initialPage);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PageView(
//       onPageChanged: (value) {
//         if (value == 0 && storiesIn[0].stories.isEmpty) {
//           Navigator.pop(context);
//         }
//       },
//       controller: _controller,
//       children: storiesIn
//           .map((user) => StoryWidget(user: user, controller: _controller))
//           .toList(),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }

// class StoryWidget extends StatefulWidget {
//   final StoryWithUser user;
//   final PageController controller;

//   const StoryWidget({
//     super.key,
//     required this.user,
//     required this.controller,
//   });

//   @override
//   StoryWidgetState createState() => StoryWidgetState();
// }

// class StoryWidgetState extends State<StoryWidget> {
//   final storyItems = <StoryItem>[];
//   late StoryController controller;
//   String date = '';

//   @override
//   void initState() {
//     super.initState();
//     controller = StoryController();
//     addStoryItems();
//   }

//   void addStoryItems() {
//     for (final story in widget.user.stories) {
//       // print(story.imageUrl); 
//       storyItems.add(
//         StoryItem.pageImage(
//           url: story.imageUrl,
//           imageFit:BoxFit.cover ,
//           controller: controller,
//           duration: const Duration(seconds: 5),
//         ),
//       );
//     }
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }

//   void handleCompleted() {
//     widget.controller.nextPage(
//       duration: const Duration(milliseconds: 300),
//       curve: Curves.bounceInOut,
//     );

//     final currentIndex = storiesIn.indexOf(widget.user);
//     final isLastPage = storiesIn.length - 1 == currentIndex;

//     if (isLastPage) {
//       Navigator.of(context).pop();
//     } else if (currentIndex == 0 && storiesIn[0].stories.isEmpty) {
//       Navigator.of(context).pop();
//     }
//   }

//   @override
//   Widget build(BuildContext context) => SafeArea(
//         child: Stack(
//           children: <Widget>[
//             Material(
//               type: MaterialType.transparency,
//               child: StoryView(
//                 progressPosition: ProgressPosition.bottom,
//                 indicatorForegroundColor:
//                     Theme.of(context).colorScheme.secondary,
//                 storyItems: storyItems,
//                 controller: controller,
//                 onComplete: handleCompleted,
//                 onVerticalSwipeComplete: (direction) {
//                   if (direction == Direction.down) {
//                     Navigator.pop(context);
//                   }
//                 },
//                 onStoryShow: (storyItem) async {
//                   final index = storyItems.indexOf(storyItem);

//                   await Future.delayed(const Duration(milliseconds: 200));
//                   setState(() {
//                     date = timeAgo(widget.user.stories[index].time);
//                   });
//                 },
//               ),
//             ),
//             Positioned(
//               top: 20,
//               left: 15,
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: screenFullWidth * 0.04,
//                     backgroundImage: NetworkImage(widget.user.user.profileImageUrl!
//                           ,
//                     ),
//                   ),
//                   kHeight10,
//                   RichText(
//                     text: TextSpan(
//                         text: widget.user.user.username,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18,
//                         ),
//                         children: [
//                           TextSpan(
//                             text: '   $date',
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w300,
//                               fontSize: 14,
//                             ),
//                           )
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
// }