import 'package:flip/application/presentation/screens/message_screen/message_screen.dart';
import 'package:flip/application/presentation/widgets/flip_logo/flip_logo.dart';
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    kWidth10,
                    const FlipLogoText(
                      logoSize: 35,
                    ),
                    const Spacer(),
                    IconButton(onPressed: () { 
                      Navigator.push(context, CupertinoPageRoute(builder: (context)=>const MessageScreen()));
                    }, icon: const Icon(Iconsax.sms_notification)),
                  ],
                ), 
                SizedBox(
                  height: 90,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return  Padding(
                            padding: const EdgeInsets.only(left: 7),
                            child: Column(
                              children: [
                                
                                CircleAvatar(
                                  backgroundImage: index ==0 ?const AssetImage('assets/IMG_2468.JPG'): 
                                      const AssetImage('assets/brunette-girl-walking-through-park-during-autumn.jpg'),
                                  radius: 35,
                                ),
                                index ==0?const Text('Faizy',style: TextStyle(fontSize: 12)):
                                const Text('Jasmy jain',style: TextStyle(fontSize: 12),)
                              ],
                            ));
                      }),
                ),
                const Divider(
                  thickness: .1,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                CircleAvatar( 
                                  backgroundImage:
                                      AssetImage('assets/IMG_2468.JPG'),
                                  radius: 18,
                                ),
                                kWidth10,
                                Text(
                                  'Faizy',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                Spacer(),
                                Icon(Icons.more_vert)
                              ],
                            ),
                            kHeight10,
                            index ==0?
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: const Color.fromARGB(20, 159, 159, 159),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(12.0),
                                child: Text('All the dreams like twinkling stars,stars are like glowing gems...;)',style: TextStyle(fontSize: 18),),
                              ),
                            ):

                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                constraints: BoxConstraints(
                                    maxHeight: screenFullHeight / 1.8),
                                width: double.infinity,
                                child: Image.asset(
                                  'assets/IMG_2468.JPG',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Iconsax.like5,color: Colors.red,),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Iconsax.note),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Iconsax.share),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Iconsax.save_2),
                                ),
                              ],
                            ),
                            const Row(
                              children: [
                                kWidth10,
                                Text('324 likes and ',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                                // kWidth10,
                                Text('56 comments',style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                              ],
                            ),
                                const Padding(
                                  padding: EdgeInsets.only(left:10.5,right: 10),
                                  child: Text('If you wanna fly, give up everything that weighs you down,so give it up and fly away!',style: TextStyle(fontSize: 13,),),
                                ),
                            const Padding(
                              padding: EdgeInsets.only(left:10.5),
                              child: Text('40 minutes ago',style: TextStyle(fontSize: 12,color: Colors.grey),),
                            ),
                            const Divider(
                              thickness: .1,
                            )
                          ],
                        );
                      }),
                )
              ],
            ),
          ),
        ));
  }
}
