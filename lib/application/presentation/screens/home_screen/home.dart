import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flip/application/presentation/widgets/flip_logo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final List<Widget> wid = List.generate(
      10,
      (index) => Padding(
            padding: const EdgeInsets.only(left: 5),
            child: CircleAvatar(
              backgroundColor: Colors.grey[200],
              radius: 33,
            ),
          ));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FlipLogoText(
          logoColor: Colors.black,
          logoSize: 30,
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.message_rounded))
        ],
      ),
      body: Container(
        height: screenFullHeight,
        width: screenFullWidth,
       
        child: ListView
        (children: [
          SizedBox(
            height: 70,
            width: screenFullWidth,
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: wid,
            ),
          ),
          Divider(thickness: .1,),
          Padding(
            padding: const EdgeInsets.only(left :8.0,right: 8,bottom: 8),
            child: Stack(
              children: [
                Container(
                  height: screenFullHeight/1.5,
                  width: screenFullWidth,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15)
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 6,
                  child: CircleAvatar(backgroundColor: Colors.grey[400],radius: 25,)),
                Divider(thickness: .3,height: 120,endIndent: 16,indent: 16 ,),
                Positioned(
                  left: 11,
                  top: 65,
                  child: Container(
                    height: screenFullHeight/2,
                    width: screenFullWidth/1.1,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 205, 204, 202),
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(image: AssetImage('assets/IMG_2468.JPG'),fit: BoxFit.cover) 
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left :8.0,right: 8,bottom: 8),
            child: Stack(
              children: [
                Container(
                  height: screenFullHeight/1.5,
                  width: screenFullWidth,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15)
                  ),
                ),
                Positioned(
                  left: 12,
                  top: 6,
                  child: CircleAvatar(backgroundColor: Colors.grey[400],radius: 25,)),
                Divider(thickness: .3,height: 120,endIndent: 16,indent: 16 ,),
                Positioned(
                  left: 11,
                  top: 65,
                  child: Container(
                    height: screenFullHeight/2,
                    width: screenFullWidth/1.1,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 205, 204, 202),
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(image: AssetImage('assets/IMG_2468.JPG'),fit: BoxFit.cover) 
                    ),
                  ),
                )
              ],
            ),
          ),
      
        ]),
      ),
    );
  }
}
