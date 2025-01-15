import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class HomeScreen extends StatelessWidget {
  // initializing the Maps location
  static final LatLng companyLatLng = LatLng(37.5233273, 126.921252);

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: GoogleMap(
        initialCameraPosition:
        CameraPosition(target: companyLatLng, zoom: 15),
      ),
    );
  }

  AppBar renderAppBar() {
    return AppBar(
      title: Text(
        '오늘도 출첵',
        style: TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w700, // w700=bold, w300=light, w400=normal
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
