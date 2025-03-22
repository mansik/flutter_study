import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_getbuilder_test/controllers/count_controller.dart';

class CounterScreen extends StatelessWidget {
  final CounterController counterController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("GetX Counter")),
      body: Center(
        child: GetBuilder<CounterController>(
          init: CounterController(),
          builder: (controller) {
            return Text(
              "Count: ${controller.count}",
              style: TextStyle(fontSize: 24),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: counterController.increment,
        child: Icon(Icons.add),
      ),
    );
  }
}