import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class NearByFlips extends StatelessWidget {
  const NearByFlips({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold( 
      body: GoogleMap(
                      trafficEnabled: false,
                      tiltGesturesEnabled: false,
                      buildingsEnabled: false,
                      scrollGesturesEnabled: true,
                      mapType: MapType.normal , 
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
                    ),
    );
  }
}