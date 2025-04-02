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

