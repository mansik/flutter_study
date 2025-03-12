import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:soul_talk/models/message_model.dart';
import 'package:soul_talk/screens/home_screen.dart';

void main() async {
  // 플러터 프레임워크가 실행 준비될 때까지 기다리기
  WidgetsFlutterBinding.ensureInitialized();

  // 앱에 배정된 폴더 경로 가져오기
  final dir = await getApplicationDocumentsDirectory();

  // Isar 데이터베이스 초기화
  final isar = await Isar.open([MessageModelSchema], directory: dir.path);

  // GetIt에 Isar 주입해서 프로젝트 어디에서든 사용하기
  GetIt.I.registerSingleton<Isar>(isar);

  runApp(MaterialApp(home: HomeScreen()));
}
