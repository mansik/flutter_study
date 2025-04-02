# mvvm_riverpot_test

A new Flutter project.

MVVM architecture, using Riverpot, Sqlite

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Features

- MVVM architecture sample, using Provider, Sqlite

## Usage


## Skill

- MVVM architecture sample, using Provider, Sqlite

## prior knowledge

## Layout

## Setps

### add plugins and assets in pubspec.yaml, `pub get`

```yaml
dependencies:
  flutter_riverpod: ^2.6.1
  sqflite: ^2.4.2
  path_provider: ^2.1.5
```

### configuring native setting


### implement user model

- User 데이터 모델을 정의합니다.

- /lib/models/user.dart
```dart
class User {
  int? id;
  String name;
  int age;

  User({this.id, required this.name, required this.age});

  Map<String, dynamic> toMap() {
    return {'id': id, 'name': name, 'age': age};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(id: map['id'], name: map['name'], age: map['age']);
  }
}

```


### implement Database Service

- DatabaseService: SQLite 데이터베이스를 관리하는 서비스 계층 (Provider로 관리).

- lib/services/database_service.dart
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpot_sqlite_test/models/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, age INTEGER)',
        );
      },
    );
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db!.insert('users', user.toMap());
  }

  Future<List<User>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('users');
    return List.generate(maps.length, (i) => User.fromMap(maps[i]));
  }

  Future<int> updateUser(User user) async {
    final db = await database;
    return await db!.update(
      'users',
      user.toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db!.delete('users', where: 'id = ?', whereArgs: [id]);
  }
}

// Riverpot Provider
final databaseServiceProvider = Provider<DatabaseService>((ref) {
  return DatabaseService();
});

```


### implement Repository

- UserRepository: 데이터베이스와 연결하는 Repository 계층 (Provider 사용).

- /lib/repositories/user_repository.dart
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpot_sqlite_test/models/user.dart';
import 'package:mvvm_riverpot_sqlite_test/services/database_service.dart';

class UserRepository {
  final DatabaseService _databaseService;

  UserRepository(this._databaseService);

  Future<List<User>> fetchUsers() async {
    return await _databaseService.getUsers();
  }

  Future<int> addUser(User user) async {
    return await _databaseService.insertUser(user);
  }

  Future<int> updateUser(User user) async {
    return await _databaseService.updateUser(user);
  }

  Future<int> deleteUser(int id) async {
    return await _databaseService.deleteUser(id);
  }
}
  // Riverpot Provider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final databaseService = ref.read(databaseServiceProvider);
  return UserRepository(databaseService);
});

```


### implement ViewModel(UserNotifier)

- UserNotifier (ViewModel): Riverpod StateNotifier를 사용하여 상태를 관리.
- UserNotifier는 UserRepository와 연결되어 DB에서 데이터를 가져오고 상태를 관리하는 역할을 합니다.

- /lib/view_models/user_notifier.dart
```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpot_sqlite_test/models/user.dart';
import 'package:mvvm_riverpot_sqlite_test/repositories/user_repository.dart';

class UserNotifier extends StateNotifier<List<User>> {
  final UserRepository _userRepository;

  UserNotifier(this._userRepository) : super([]) {
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    state = await _userRepository.fetchUsers();
  }

  Future<void> addUser(String name, int age) async {
    await _userRepository.addUser(User(name: name, age: age));
    fetchUsers();
  }

  Future<void> updateUser(User user) async {
    await _userRepository.updateUser(user);
    fetchUsers();
  }

  Future<void> deleteUser(int id) async {
    await _userRepository.deleteUser(id);
    fetchUsers();
  }
}

// Riverpot StateNotifierProvider
final userNotifierProvider = StateNotifierProvider<UserNotifier, List<User>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserNotifier(userRepository);
});


```


### implement View

- UserScreen (View): ConsumerWidget을 사용하여 userNotifierProvider의 상태를 감시.

- /lib/views/user_screen.dart
```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpot_sqlite_test/view_models/user_notifier.dart';

class UserScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 상태 감시(UI 자동 리렌더링): userNotifierProvider의 현재 상태(List<User>)를 감시  
    final users = ref.watch(userNotifierProvider);
    // UserNotifier 객체를 가져옴: addUser(), deleteUser() 등의 함수 호출 가능
    final userNotifier = ref.read(userNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('User List')),
      body: Column(
        children: [
          Expanded(
            child:
                users.isEmpty
                    ? Center(child: Text('No users found'))
                    : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                        return ListTile(
                          title: Text('${user.name} - ${user.age}'),
                          trailing: IconButton(
                            onPressed: () => userNotifier.deleteUser(user.id!),
                            icon: Icon(Icons.delete),
                          ),
                        );
                      },
                    ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(hintText: 'Name'),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(hintText: 'Age'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    final name = nameController.text;
                    final age = int.tryParse(ageController.text) ?? 0;
                    userNotifier.addUser(name, age);
                    nameController.clear();
                    ageController.clear();
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  final nameController = TextEditingController();
  final ageController = TextEditingController();
}

```


### implement main.dart


- /lib/main.dart
```dart
import 'package:flutter/material.dart';
import 'package:mvvm_riverpot_sqlite_test/views/user_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM Riverpot Sqlite Test',
      home: UserScreen(),
    );
  }
}
```
