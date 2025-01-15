# chool_check

A new Flutter project.

구글지도, Geolocator plugin, Dialog

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Features

- 구글 지도를 활용해서 지도 UI를 구현
- 현재 위치를 지도에 보여준다.
- [현재 위치로 이동] 버튼을 눌러 GPS상의 현재 위치로 이동
- 출근 가능한 위치로 이동하면 [출근하기] 버튼을 눌러 출근 체크
- 출근 가능한 위치가 아니라면 [출근하기] 버튼이 보이지 않음

## Usage

- 출근 체크가 가능한 위치로 GPS 이동
- [출근하기] 버튼 탭 후 출근 체크

## Skill

구글 지도, Geolocator, Dialog

## Plugin

- google_maps_flutter: ^2.10.0
- geolocator: ^13.0.2

## prior knowledge

#### Geolocator plugin

지리와 관련된 기능을 쉽게 사용할 수 있는 플러그인

Geolocator 기능 3가지
1. 위치 서비스를 사용할 수 있는 권한이 있는지 확인하고 권한을 요청
- 기기의 위치 서비스가 활성화되어 있는지 확인
```dart
final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
```
- 앱에서 위치 서비스 권한을 요청하고 허가 받기
```dart
final checkedPermission = await Geolocator.checkPermission(); // 권한 확인
final checkedPermission = await Geolocator.requestPermission(); // 권한 요청
```

2. 현재 GPS 위치가 바뀔 때마다 현재 위칫값을 받을 수 있는 기능을 사용

```dart
Geolocator.getPositionStream().listen((Position position) {
  print(position);
});
```

3. 두 위치간 거리를 계산

```dart
// 두 위치 간의 거리를 double값으로 반환(미터 단위)
final distance = Geolocator.distanceBetween(
    sLat, // 시작점 위도 
    sLng, // 시작점 경도
    eLat, // 끝지점 위도
    eLng, // 끝지점 경도
);
```

## Layout

AppBar, Body, Footer로 3등분된 화면
- AppBar: 타이틀
- Body: 구글 지도, 회사의 정확한 위치에 마커 표시 및 도형을 사용해서 출근 체크가 가능한 영역 표시
- Footer: 출근하기 기능, 현재 GPS 위치가 출근 체크가 가능한 위치라면 [출근하기] 버튼 표시, 아니면 버튼을 숨김

## Setps

### get the [Google Maps API key](https://developers.google.com/maps/documentation/places/android-sdk/cloud-setup?_gl=1*p43t50*_up*MQ..*_ga*MzA3NDI2ODkyLjE3MzY5MjUyMDM.*_ga_NRWSTWS78N*MTczNjkyNTIwMy4xLjEuMTczNjkyNTM2Ny4wLjAuMA..)

1. connect [google cloud](https://cloud.google.com/gcp)
2. login -> [무료로 시작하기] 버튼
3. go google cloud console
4. choose [My First Project] -> click new project
5. write project name and click create project
6. click [Google Maps Platform] button -> [APIs & Services] button 
7. -> [Maps SDK for Android],[Maps SDK for iOS]  enable
8. [Google Maps Platform] button -> [Keys & Credentials] button -> [API Key]-> show key
9. get api key
10. Register detailed location permissions and pre-issued Google Maps API key 
- /android/app/src/main/AndroidManifest.xml

### add plugins and assets in pubspec.yaml, `pub get`

- /assets/images/
```yaml
dependencies:
 google_maps_flutter: ^2.10.0
 geolocator: ^13.0.2
```

### configuring native setting

[on android](https://developers.google.com/maps/flutter-package/config?_gl=1*1ueewqf*_up*MQ..*_ga*MTY0MTgwOTExMS4xNzM2OTI1ODI5*_ga_NRWSTWS78N*MTczNjkyNTgyOC4xLjAuMTczNjkyNTgyOS4wLjAuMA..)
- /android/app/build.gradle
setting to compileSdk>= 34, minSdk>=20
```gradle
android {
    compileSdk = 34// flutter.compileSdkVersion

    defaultConfig {
        minSdk = 23 //flutter.minSdkVersion
```

- /android/app/src/main/AndroidManifest.xml
Register detailed location permissions and pre-issued Google Maps API key
```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
    <application
        <meta-data
            android:name="com.google.android.geo.API_KEY"
            android:value="here is your google maps api key"
        />
```

- /android/settings.gradle
com.android.application version 8.2.1
```gradle
plugins {
    id "dev.flutter.flutter-plugin-loader" version "1.0.0"
    id "com.android.application" version "8.2.1" apply false
```

[on iOS]
- /ios/Podfile
```Podfile
  # Set platform to 14.0 to enable latest Google Maps SDK
  platform :ios, '14.0'
```

- /ios/Runner/AppDelegate.swift
```swift
import UIKit
import Flutter
import GoogleMaps  // Add this import

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    // TODO: Add your Google Maps API key
    GMSServices.provideAPIKey("YOUR_API_KEY")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
 ...
 <dict>
 ...
   <key>NSLocationWhenInUsageDescrition</key>
   <string>this app needs your location</string>
   <key>NSLocationAlwaysUsageDescrition</key>
   <string>this app needs your location</string>
 </dict>
```

### initialize project

- /lib/main.dart
```dart
void main() {
  runApp(
    MaterialApp(
      home: HomeScreen(),
    ),
  );
}
```

- lib/screens/home_screen.dart
```dart
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Text('home'));
  }
}
```

### implement the AppBar to home screen

- lib/screens/home_screen.dart
```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: Text('home'),
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
```


### implement the Body to home screen

- lib/screens/home_screen.dart
```dart
class HomeScreen extends StatelessWidget {
  // initializing the Maps location
  static final LatLng companyLatLng = LatLng(37.5233273, 126.921252);

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: renderAppBar(),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: companyLatLng, zoom: 15),
      ),
    );
  }
```

## implement the Footer to home screen

- lib/screens/home_screen.dart
```dart
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
```

## implement the location permissions

기기 자체의 GPS 사용 권한을 확인, 앱에서 위치 서비스를 사용할 수 있는지 확인 후 권한을 재요청하는 로직
- lib/screens/home_screen.dart
```dart
  // renderAppBar() 아래에 입력하기
  Future<String> checkPermission() async {
    // 위치 서비스 활성화 여부
    final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
    
    if (!isLocationEnabled) {
     return '위치 서비스를 활성화해주세요.'; 
    }
    
    // 위치 권한 확인
    LocationPermission checkedPermission = await Geolocator.checkPermission();
    
    if(checkedPermission == LocationPermission.denied) {
      // 위치 권한 요청하기
      checkedPermission = await Geolocator.requestPermission();
      
      if (checkedPermission == LocationPermission.denied) {
        return '위치 권한을 허용해주세요.';
      }      
    }
    
    return '위치 권한이 허가 되었습니다.';    
  }
```

checkPermission() 함수를 실행, 앱 권한이 없을 경우 앱을 사용하지 못하게 함.
- 로딩 상태이면 CircularProgressIndicator를 보여줌
- 허가 받은 상태면 구글 지도를 보여줌
- 허가 받지 못한 상태면 반환받은 메시지를 화면에 보여줌

- lib/screens/home_screen.dart
```dart
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
                    initialCameraPosition:
                        CameraPosition(target: companyLatLng, zoom: 15),
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
                        onPressed: () {},
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
```


### drawing a marker on the screen

정확한 회사의 위치를 마커로 표시

- Google Maps plugin이 제공하는 Marker 클래스를 사용해서 각 마커별로 ID를 정해주고 위치를 입력한다.
- 그다음 GoogleMaps 위젯의 markers 매개변수에 Set 형태로 원하는 만큼 Marker값들을 넣어주면 된다.
- Marker를 사용할 때 유의할 점은 markerId에 꼭 유일한 값을 넣어줘야 하며, 
- 만약 같은 값이 사용되면 중복되는 마커는 화면에 표시되지 않는다.

- lib/screens/home_screen.dart

Declare a Company Location Marker
```dart
class HomeScreen extends StatelessWidget {
  // initializing the Maps location
  static final LatLng companyLatLng = LatLng(37.5233273, 126.921252);

  // Declare a Company Location Marker
  static final Marker companyMarker = Marker(
    markerId: MarkerId('company'),
    position: companyLatLng,
  );
```

Set.from
```dart
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: companyLatLng,
                      zoom: 15,
                    ),
                    markers: Set.from([companyMarker]), // Set로 Marker 제공
                  ),
```


## display radius around the current location

현재 위치에 반경을 원 모양으로 표시

- lib/screens/home_screen.dart

Declare a Company Location Circle
```dart
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
    center: companyLatLng, // 원의 중심 위치
    fillColor: Colors.blue.withAlpha((0.5 *255).toInt()),
    radius: 100, // 원의 반지름(미터 단위)
    strokeColor: Colors.blue, // 원의 테두리 색
    strokeWidth: 1, // 원의 테두리 두께
  );
```

Set.from
```dart
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: companyLatLng,
                      zoom: 15,
                    ),
                    markers: Set.from([companyMarker]), // Set로 Marker 제공
                    circles: Set.from([circle]), // Set로 Circle 제공
                  ),

```

### display current location on the Map

안드로이드 에뮬레이터에서 현재위치 설정하기: 
점 3개의 옵션 버튼 클릭 후 [Location] -> 검색창에서 위치 검색 -> [Set Location] 버튼을 눌러서 변경


- lib/screens/home_screen.dart
```dart
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: companyLatLng,
                      zoom: 15,
                    ),
                    myLocationEnabled: true, // 내 위치 지도에 보여주기
                    markers: Set.from([companyMarker]), // Set로 Marker 제공
                    circles: Set.from([circle]), // Set로 Circle 제공
                  ),
```

### implement clock-in button

출근하기 기능은 다이얼로그를 사용해서 구현하며, 다이얼로그가 실행되면 '출근하시겠습니까?'라는 문자가 화면에 출력되고
[출근하기] 버튼을 눌러서 출근을 하거나 취소할 수 있다. 출근이 불가능한 거리에 위치해 있다면 [출근하기] 버튼을 눌렀을 때
'출근할 수 없는 위치입니다.'라는 메시지와 함께 [취소] 버튼을 보여준다.

- lib/screens/home_screen.dart

1. 상황에 따라 서로 다른 다이얼로그를 렌더링해주기 위해서 [출근하기] 버튼을 눌렀을 때 현재 위치와 회사의 위치 간의 거리를 미터로 계산
```dart
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
```

2. 원의 반지름이 100미터 이내로 현재 위치와 회사의 거리가 측정되면 출근할 수 있는 다이얼로그를 실행하고 
아니면 출근할 수 없다는 다이얼로그를 보여준다.

```dart
                      ElevatedButton(
                        onPressed: () async {
                          final currentPosition =
                              await Geolocator.getCurrentPosition();

                          final distance = Geolocator.distanceBetween(
                              currentPosition.latitude, // 현재 위치 위도
                              currentPosition.longitude, // 현재 위치 경도
                              companyLatLng.latitude, // 회사 위치 위도
                              companyLatLng.longitude); //회사 위치 경도

                          bool canCheckin =
                              distance <= 100; // 100미터 내에 있으면 출근가능

                          showDialog(
                              context: context,
                              builder: (_) {
                                return AlertDialog(
                                  title: const Text('출근하기'),
                                  content: Text(
                                    canCheckin
                                        ? '출근을 하시겠습니까?'
                                        : '출근할 수 없는 위치입니다.',
                                  ),
                                  actions: [
                                    // 취소를 누르면 false 반환
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(false);
                                      },
                                      child: Text('취소'),
                                    ),
                                    if (canCheckin)
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop(true);
                                        },
                                        child: Text('출근하기'),
                                      ),
                                  ],
                                );
                              });
                        },
                        child: Text('출근하기'),
                      ),
```