import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_test2/models/fish_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create:
          (BuildContext context) =>
              FishModel(name: 'Salmon', count: 10, size: 'big'),
      child: MaterialApp(home: FishOrder()),
    );
  }
}

class FishOrder extends StatelessWidget {
  const FishOrder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fish Order")),
      body: Center(
        child: Column(
          children: [
            Text(
              'Fish name: ${Provider.of<FishModel>(context).name}',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            High(),
          ],
        ),
      ),
    );
  }
}

class High extends StatelessWidget {
  const High({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('SpiceA is located at high place', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 20),
        SpiceA(),
      ],
    );
  }
}

class SpiceA extends StatelessWidget {
  const SpiceA({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Fish count: ${Provider.of<FishModel>(context).count}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Fish size: ${Provider.of<FishModel>(context).size}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Middle(),
      ],
    );
  }
}

class Middle extends StatelessWidget {
  const Middle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SpiceB is located at middle place',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 20),
        SpiceB(),
      ],
    );
  }
}

class SpiceB extends StatelessWidget {
  const SpiceB({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Fish count: ${Provider.of<FishModel>(context).count}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Fish size: ${Provider.of<FishModel>(context).size}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Low(),
      ],
    );
  }
}

class Low extends StatelessWidget {
  const Low({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('SpiceC is located at Low place', style: TextStyle(fontSize: 16)),
        const SizedBox(height: 20),
        SpiceC(),
      ],
    );
  }
}

class SpiceC extends StatelessWidget {
  const SpiceC({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Fish count: ${Provider.of<FishModel>(context).count}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Fish size: ${Provider.of<FishModel>(context).size}',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Provider.of<FishModel>(context, listen: false).increaseCount();
          },
          child: Text('Increase Fish Count'),
        ),
      ],
    );
  }
}
