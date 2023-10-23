import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(length: 2, child: Scaffold(
        appBar: AppBar(
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios)),
          bottom: TabBar(tabs: [Text('data'),Text('data')]),
        ),
        body: TabBarView(children: [Center(child: Text('data')),
        Center(
          child: SizedBox(
                        height: screenFullHeight/2 ,
                        width: double.infinity,
                        child: ClipRRect( 
                          borderRadius: BorderRadius.circular(10),
                          child: GoogleMap(
                            scrollGesturesEnabled: false ,
                            mapType: MapType.hybrid ,  
                            myLocationButtonEnabled: true,
                            myLocationEnabled: true, 
                            zoomControlsEnabled: true, 
                            zoomGesturesEnabled: true,
                            initialCameraPosition:  CameraPosition(
                              target: LatLng(
        10.005999,76.342802), 
                              zoom: 14,
                            ), 
                            markers: { 
                               Marker( 
                                markerId: const MarkerId('marker_id'),
                                position:
                                    LatLng(
        10.005999,76.342802),
                              ),
                            }, 
                            // ignore: prefer_collection_literals
                            gestureRecognizers: Set()
                             ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                            
                            ),
                        ),
                      ),
        )]),
      ))
    );
  }
} 