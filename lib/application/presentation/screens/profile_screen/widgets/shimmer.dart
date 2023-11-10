import 'package:flip/data/firebase/auth_data_resourse/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/widgets/flip_logo/flip_logo.dart';

class ProfileShimmerEffect extends StatelessWidget {
  ProfileShimmerEffect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Positioned(
              left: 68,
              top: 18,
              child: Shimmer.fromColors(
                baseColor: const Color.fromARGB(255, 215, 215, 215),
                highlightColor: Colors.grey[200]!,
                child: Container(
                  height: screenFullHeight * .035,
                  width: screenFullWidth,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(4)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
            child: Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: screenFullHeight / 3,
                    width: screenFullWidth,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                Positioned(
                  left: 12,
                  bottom: 30,
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[300]!,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[900],
                      radius: 60,
                    ),
                  ),
                ),
                  Positioned(
                  right: 15,
                    bottom: 40 ,
                    child: Shimmer.fromColors(
                      baseColor: const Color.fromARGB(255, 215, 215, 215),
                      highlightColor: Colors.grey[200]!,
                      child: Container(
                        height: screenFullHeight * .05,
                        width: screenFullWidth/2.2,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(4)),
                      ),
                    ),
                  ),
              ],
            ),
          ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Positioned(
                  left: 68,
                  top: 18,
                  child: Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 215, 215, 215),
                    highlightColor: Colors.grey[200]!,
                    child: Container(
                      height: screenFullHeight * .05,
                      width: screenFullWidth/2.2,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),
                          ),
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Positioned(
                  left: 68,
                  top: 18,
                  child: Shimmer.fromColors(
                    baseColor: const Color.fromARGB(255, 215, 215, 215),
                    highlightColor: Colors.grey[200]!,
                    child: Container(
                      height: screenFullHeight * .05,
                      width: screenFullWidth/2.2,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                ),
                          ),
              ],
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 300,
                child: GridView.builder(
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3
                        ,crossAxisSpacing: 2,mainAxisSpacing: 2
                        
                        ), 
                        itemCount: 9,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[300]!,
                        child: Container(
                              // height: screenFullHeight / 2.3,
                              // width: screenFullWidth ,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(1),
                                  color: Colors.green),
                            ),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
