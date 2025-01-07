import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CustomVideoPlayer extends StatefulWidget {
  final XFile video; // 선택한 동영상을 저장

  const CustomVideoPlayer({required this.video, super.key});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'custom video player',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
