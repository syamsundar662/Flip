// import 'dart:typed_data';


// import 'package:flutter/material.dart';
// import 'package:cupertino_icons/cupertino_icons.dart';
// import 'package:photo_manager/photo_manager.dart';
// import 'package:image/image.dart' as img;
// import 'package:video_player/video_player.dart';

// class InstagramMediaPicker extends StatefulWidget {
//   const InstagramMediaPicker({Key? key});

//   @override
//   State<InstagramMediaPicker> createState() => _InstagramMediaPickerState();
// }

// class _InstagramMediaPickerState extends State<InstagramMediaPicker> {
//   late List<AssetEntity> assetList;
//   late AssetEntity? selectedEntity;

//   @override
//   void initState() {
//     super.initState();
//     _loadMedia();
//   }

//   Future<void> _loadMedia() async {
//     final permitted = await PhotoManager.requestPermissionExtend();
//     if (!permitted) {
//       // Handle permissions denied
//       return;
//     }

//     final albums = await PhotoManager.getAssetPathList(onlyAll: true);

//     if (albums.isNotEmpty) {
//       final recentAlbum = albums.first;
//       final assets = await recentAlbum.getAssetListRange(start: 0, end: 100);
//       setState(() {
//         assetList = assets;
//         selectedEntity = assets.isNotEmpty ? assets[0] : null;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//         title: const Text('Instagram Media Picker'),
//         actions: <Widget>[
//           IconButton(
//             onPressed: () {
//               // Handle Next button action
//             },
//             icon: const Icon(Icons.arrow_forward),
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           Expanded(
//             child: _buildMediaGrid(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMediaGrid() {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         mainAxisSpacing: 1,
//         crossAxisSpacing: 1,
//       ),
//       itemCount: assetList.length,
//       itemBuilder: (context, index) {
//         final assetEntity = assetList[index];
//         return GestureDetector(
//           onTap: () {
//             setState(() {
//               selectedEntity = assetEntity;
//             });
//           },
//           child: ImageThumbnail(assetEntity: assetEntity),
//         );
//       },
//     );
//   }
// }

// class ImageThumbnail extends StatelessWidget {
//   final AssetEntity assetEntity;

//   const ImageThumbnail({Key? key, required this.assetEntity}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     if (assetEntity.type == AssetType.image) {
//       return FutureBuilder<Uint8List?>(
//         future: assetEntity.thumbDataWithSize(200, 200),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Icon(Icons.error));
//           } else if (snapshot.hasData && snapshot.data != null) {
//             return Image.memory(
//               snapshot.data!,
//               fit: BoxFit.cover,
//             );
//           } else {
//             return Center(child: Icon(Icons.error));
//           }
//         },
//       );
//     } else if (assetEntity.type == AssetType.video) {
//       return Center(
//         child: Stack(
//           alignment: Alignment.center,
//           children: <Widget>[
//             FutureBuilder<Uint8List?>(
//               future: assetEntity.thumbData,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return Center(child: Icon(Icons.error));
//                 } else if (snapshot.hasData && snapshot.data != null) {
//                   return Image.memory(
//                     snapshot.data!,
//                     fit: BoxFit.cover,
//                   );
//                 } else {
//                   return Center(child: Icon(Icons.error));
//                 }
//               },
//             ),
//             const Icon(Icons.play_circle_fill, color: Colors.white, size: 50),
//           ],
//         ),
//       );
//     } else {
//       // Handle other asset types if needed
//       return Center(child: Icon(Icons.error));
//     }
//   }
// }
