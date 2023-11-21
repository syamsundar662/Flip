
//   Padding _postAndThoughtsButton(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8, right: 8, top: 10, bottom: 8),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Container(
//             width: screenFullWidth / 2.1,
//             height: screenFullHeight * .06,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Theme.of(context).colorScheme.primary),
//             child: IconButton(
//                 onPressed: () {
//                   // context
//                   //     .read<ProfileBloc>()
//                   //     .add(UserProfileInitialEvent());
//                 },
//                 icon: const Icon(Icons.window_outlined)),
//           ),
//           Container(
//             width: screenFullWidth / 2.1,
//             height: screenFullHeight * .06,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Theme.of(context).colorScheme.primary),
//             child: IconButton(
//                 onPressed: () {
//                   // context
//                   //     .read<ProfileBloc>()
//                   //     .add(UserProfileInitialEvent());
//                 },
//                 icon: const Icon(Icons.notes)),
//           ),
//         ],
//       ),
//     );
//   }