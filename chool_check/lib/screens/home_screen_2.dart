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
      body: Column(
        children: [
          Expanded(
            flex: 2, // 2/3만큼 공간 차지
            child: GoogleMap(
              initialCameraPosition:
                  CameraPosition(target: companyLatLng, zoom: 15),
            ),
          ),
          Expanded( // 1/3만큼 공간 차지
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.timelapse_outlined,
                  color: Colors.blue,
                  size: 50.0,
                ),
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('출근하기'),
                ),
              ],
            ),
          ),
        ],
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
