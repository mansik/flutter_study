# image_carousel_test

A new Flutter project.

image_carousel 연습

stateful, timer.periodic

![Image](https://github.com/user-attachments/assets/5276cc9f-b7ed-447d-83a0-fcd9d54101fd)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### 1. create asset - images fold

- asset
    - images

### 2. add assets: on pubspec.yaml

```yaml
  assets:
    - asset/images/
```

### 3. add screens/home_screen.dart

create StatefulWidget

### 4. alter main.dart

### 5. alter screens/home_screen.dart

1. PageView 추가
2. 상태바 색상 변경
3. initState() 추가
4. Timer.periodic() 추가
5. PageView에 사용할 PageController 추가
6. controller에 pageController 등록
7. pageController 사용하여 페이지를 주기적으로 변경한다.
