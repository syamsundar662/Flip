import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar( 
                title: const CupertinoSearchTextField(),
                bottom: const PreferredSize(
                  preferredSize: Size.fromHeight(40),      
                  child: TabBar(
                    labelColor: Colors.blue,indicatorColor: Colors.blue,
                    overlayColor: MaterialStatePropertyAll(Color.fromARGB(21, 255, 255, 255)),
                    labelPadding: EdgeInsets.all(10),
                
                    tabs: [Text('Explore'), Text('Nearby')]),
                ),
              ),
              body: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,crossAxisSpacing: 2, mainAxisSpacing: 2,childAspectRatio: 1/1.5), 
                    itemBuilder: (BuildContext context,int index){
                      return Container(color: const Color.fromARGB(48, 93, 93, 93),);
                    }),
                    const GoogleMap(
                      trafficEnabled: false,
                      tiltGesturesEnabled: false,
                      buildingsEnabled: false,
                      scrollGesturesEnabled: true,
                      mapType: MapType.hybrid, 
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      zoomGesturesEnabled: true,
                      
                      initialCameraPosition: CameraPosition(
                        target: LatLng(10.005999, 76.342802),
                        zoom: 14,
                      ),
                      //                   markers: {
                      //                      Marker(
                      //                       markerId: const MarkerId('marker_id'),
                      //                       position:
                      //                           LatLng(
                      // 10.005999,76.342802),
                      //                     ),
                      // },
                    )
                  ]),
            )));
  }
}

