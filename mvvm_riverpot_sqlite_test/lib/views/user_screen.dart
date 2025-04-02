import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_riverpot_sqlite_test/view_models/user_notifier.dart';

class UserScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(userNotifierProvider);
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
