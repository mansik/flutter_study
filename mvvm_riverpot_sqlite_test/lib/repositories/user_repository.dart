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
