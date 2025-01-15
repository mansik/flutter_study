import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class HomeScreen extends StatelessWidget {
  // initializing the Maps location
  static final LatLng companyLatLng = LatLng(37.5233273, 126.921252);

  // Declare a Company Location Marker
  static final Marker companyMarker = Marker(
    markerId: MarkerId('company'),
    position: companyLatLng,
  );

  // Declare a Company Location Circle
  static final Circle circle = Circle(
    circleId: CircleId('choolCheckCircle'),
    center: companyLatLng,
    // 원의 중심 위치
    fillColor: Colors.blue.withAlpha((0.5 * 255).toInt()),
    radius: 100,
    // 원의 반지름(미터 단위)
    strokeColor: Colors.blue,
    // 원의 테두리 색
    strokeWidth: 1, // 원의 테두리 두께
  );

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: FutureBuilder<String>(
        future: checkPermission(),
        builder: (context, snapshot) {
          // 로딩 상태
          if (!snapshot.hasData &&
              snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          // 권한이 허가된 상태
          if (snapshot.data == '위치 권한이 허가 되었습니다.') {
            return Column(
              children: [
                Expanded(
                  flex: 2, // 2/3만큼 공간 차지
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: companyLatLng,
                      zoom: 15,
                    ),
                    myLocationEnabled: true, // 내 위치 지도에 보여주기
                    markers: Set.from([companyMarker]), // Set로 Marker 제공
                    circles: Set.from([circle]), // Set로 Circle 제공
                  ),
                ),
                Expanded(
                  // 1/3만큼 공간 차지
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
                        onPressed: () async {
                          final currentPosition =
                              await Geolocator.getCurrentPosition();

                          final distance = Geolocator.distanceBetween(
                              currentPosition.latitude, // 현재 위치 위도
                              currentPosition.longitude, // 현재 위치 경도
                              companyLatLng.latitude, // 회사 위치 위도
                              companyLatLng.longitude); //회사 위치 경도
                        },
                        child: Text('출근하기'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }

          // 권한이 없는 상태
          return Center(
            child: Text(
              snapshot.data.toString(),
            ),
          );
        },
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

  Future<String> checkPermission() async {
    // 위치 서비스 활성화 여부
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationEnabled) {
      return '위치 서비스를 활성화해주세요.';
    }

    // 위치 권한 확인
    LocationPermission checkedPermission = await Geolocator.checkPermission();

    // 위치 권한 거절됨
    if (checkedPermission == LocationPermission.denied) {
      // 위치 권한 요청하기
      checkedPermission = await Geolocator.requestPermission();

      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허용해주세요.';
      }
    }

    // 위치 권한 거절됨(앱에서 재요청 불가)
    if(checkedPermission == LocationPermission.deniedForever) {
      return '앱의 위치 권한을 설정에서 허가해주세요.';
    }

    return '위치 권한이 허가 되었습니다.';
  }
}
