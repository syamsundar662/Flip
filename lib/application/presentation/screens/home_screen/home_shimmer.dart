import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/flip_logo/flip_logo.dart';
import 'package:flip/data/repositories/auth_repository.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final List<Widget> wid = List.generate(
    10,
    (index) => Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Padding(
          padding: const EdgeInsets.only(left: 3),
          child: CircleAvatar(
            backgroundColor: Colors.grey[200],
            radius: 33,
          ),
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    size(context);
    return Scaffold(
      appBar: AppBar(
        title: const FlipLogoText(
          // logoColor: Colors.black,
          logoSize: 30,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () {
                AuthRepository().signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()),
                    (route) => false);
              },
              icon: const Icon(Icons.message_rounded))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 70,
            width: screenFullWidth,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: wid,
            ),
          ),
          const Divider(thickness: .1),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
                  child: Stack(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: screenFullHeight / 1.5,
                          width: screenFullWidth,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 12,
                        top: 6,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[300]!,
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[900],
                            radius: 25,
                          ),
                        ),
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[300]!,
                        child: Align(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 65),
                            child: Column(
                              children: [
                                Container(
                                  height: screenFullHeight / 1.9,
                                  width: screenFullWidth / 1.1,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Colors.green),
                                ),
                                kHeight20,
                                Positioned(
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[400]!,
                                    highlightColor: Colors.grey[200]!,
                                    child: Container(
                                      height: screenFullHeight * .03,
                                      width: screenFullWidth / 1.11,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(4)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 68,
                        top: 18,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[200]!,
                          child: Container(
                            height: screenFullHeight * .03,
                            width: screenFullWidth / 1.31,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(4)),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:shimmer/shimmer.dart';
// import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
// import 'package:flip/application/presentation/utils/constants.dart';
// import 'package:flip/application/presentation/widgets/flip_logo.dart';
// import 'package:flip/data/repositories/auth_repository.dart';

// class HomePage extends StatelessWidget {
//   HomePage({Key? key}) : super(key: key);

//   final List<Widget> wid = List.generate(
//     10,
//     (index) => Padding(
//       padding: const EdgeInsets.only(left: 5),
//       child: Shimmer.fromColors(
//         baseColor: Colors.grey[300]!,
//         highlightColor: Colors.grey[100]!,
//         child: Padding(
//           padding: const EdgeInsets.only(left: 3),
//           child: CircleAvatar(
//             backgroundColor: Colors.grey[200],
//             radius: 33,
//           ),
//         ),
//       ),
//     ),
//   );

//   @override
//   Widget build(BuildContext context) {
//     size(context);
//     return Scaffold(
//       appBar: AppBar(
//         title: const FlipLogoText(
//           logoColor: Colors.black,
//           logoSize: 30,
//         ),
//         automaticallyImplyLeading: false,
//         actions: [
//           IconButton(
//               onPressed: () {
//                 AuthRepository().signOut();
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const LoginScreen()),
//                     (route) => false);
//               },
//               icon: const Icon(Icons.message_rounded))
//         ],
//       ),
//       body: SingleChildScrollView( 
//         physics: AlwaysScrollableScrollPhysics(), 
//         child: Column(  
//           children: [
//             SizedBox( 
//               height: 70,
//               width: screenFullWidth,
//               child: ListView(
//                 shrinkWrap: true,
//                 scrollDirection: Axis.horizontal,
//                 children: wid,
//               ),
//             ),
//             const Divider(thickness: .1),
//             Expanded(
//               child: ListView.builder(
//                 physics: NeverScrollableScrollPhysics(),
//                 shrinkWrap: true,
//                 itemCount: 10,
//                 itemBuilder: (context, index) { 
//                   return Padding(
//                     padding:
//                         const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
//                     child: Stack(
//                       children: [
//                         Shimmer.fromColors(
//                           baseColor: Colors.grey[300]!,
//                           highlightColor: Colors.grey[100]!,
//                           child: Container(
//                             height: screenFullHeight / 1.5,
//                             width: screenFullWidth,
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: 12,
//                           top: 6,
//                           child: Shimmer.fromColors(
//                             baseColor: Colors.grey[400]!,
//                             highlightColor: Colors.grey[300]!,
//                             child: CircleAvatar(
//                               backgroundColor: Colors.grey[900],
//                               radius: 25,
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           left: 12,
//                           top: 0,
//                           child: Stack(
//                             children: [
//                               Shimmer.fromColors(
//                                 baseColor: Colors.grey[400]!,
//                                 highlightColor: Colors.grey[300]!,
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(top: 65),
//                                   child: Column(
//                                     children: [
//                                       Container(
//                                         height: screenFullHeight / 1.9,
//                                         width: screenFullWidth / 1.1,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                           color: Colors.green,
//                                         ),
//                                       ),
//                                       kHeight20,
//                                       Container(
//                                         height: screenFullHeight * .03,
//                                         width: screenFullWidth / 1.11,
//                                         decoration: BoxDecoration(
//                                           color: Colors.green,
//                                           borderRadius:
//                                               BorderRadius.circular(4),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 left: 68,
//                                 top: 18,
//                                 child: Shimmer.fromColors(
//                                   baseColor: Colors.grey[400]!,
//                                   highlightColor: Colors.grey[200]!,
//                                   child: Container(
//                                     height: screenFullHeight * .03,
//                                     width: screenFullWidth / 1.31,
//                                     decoration: BoxDecoration(
//                                       color: Colors.green,
//                                       borderRadius: BorderRadius.circular(4),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
