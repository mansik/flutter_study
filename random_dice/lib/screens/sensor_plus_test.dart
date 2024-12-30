// import 'package:flutter/material.dart';
// import 'package:sensors_plus/sensors_plus.dart'; // pubspec.yaml에 sensors_plus: ^1.4.1 등록후 사용
//
// class SensorPlusTest extends StatelessWidget {
//   const SensorPlusTest({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     test();
//     return const Placeholder();
//   }
//
//   void test(){
//     // 중력을 반영한 가속도계 값
//     accelerometerEvents.listen((AccelerometerEvent event) {
//       print(event.x);
//       print(event.y);
//       print(event.z);
//     });
//
//     // 중력을 반영하지 않은 순수 사용자의 힘에 의한 가속도계 값
//     userAccelerometerEvents.listen((UserAccelerometerEvent event){
//       print(event.x);
//       print(event.y);
//       print(event.z);
//     });
//
//     // gyroscope
//     gyroscopeEvents.listen((GyroscopeEvent event) {
//       print(event.x);
//       print(event.y);
//       print(event.z);
//     });
//   }
// }
