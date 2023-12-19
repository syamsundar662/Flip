
// working on this feature (Story) some unexpected bugs found

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flip/application/presentation/utils/constants/constants.dart';
// import 'package:flip/application/presentation/utils/image/image_picker.dart';
// import 'package:flip/data/firebase/story_data_resourse/story_data.dart';
// import 'package:flip/domain/models/story_model/story_model.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';

// class AddStoryScreen extends StatelessWidget {
//   const AddStoryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Add Story'),
//         ),
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             SizedBox(
//               height: screenFullHeight / 8,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Container(
//                     height: screenFullHeight / 8,
//                     width: screenFullWidth / 2.2,
//                     color: Colors.grey.shade900,
//                     child: IconButton(
//                         onPressed: () async {
//                           final pickedImage = await PickImage()
//                               .imagePicker(ImageSource.gallery);
//                           final imageUrl =
//                               await PickImage().uploadImage(pickedImage!.path);

//                           final story = StoryModel(
//                               userId: FirebaseAuth.instance.currentUser!.uid,
//                               imageUrl: imageUrl,
//                               time: DateTime.now());

//                           await StoryDataSource().addStory(story: story).then((value) {
//                             Navigator.pop(context); 
//                           });
//                         },
//                         icon: const Icon(Icons.file_copy)),
//                   ),
//                   Container(
//                     height: screenFullHeight / 8,
//                     width: screenFullWidth / 2.2,
//                     color: Colors.grey.shade900,
//                     child: IconButton(
//                         onPressed: () {}, icon: const Icon(Icons.camera)),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
