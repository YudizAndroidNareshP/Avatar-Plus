import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:avatar_plus/avatar_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avatar Plus example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(
        title: 'Avatar Plus example',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<String> randomStrings = [];

  final int count = 10;
  final int length = 10;

  @override
  void initState() {
    randomStrings.addAll(generateRandomStrings(count, length));
    super.initState();
  }

  List<String> generateRandomStrings(int count, int length) {
    const String chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();

    List<String> strings = [];

    for (int i = 0; i < count; i++) {
      String randomString = '';
      for (int j = 0; j < length; j++) {
        randomString += chars[random.nextInt(chars.length)];
      }
      strings.add(randomString);
    }

    return strings;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          randomStrings.addAll(generateRandomStrings(count, length));
          setState(() {});
        },
        tooltip: 'Load more',
        label: const Text("Load more"),
        icon: const Icon(Icons.add),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.all(12.0),
          itemCount: randomStrings.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20),
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              View(avatar: randomStrings[index])));
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Hero(
                    tag: randomStrings[index],
                    child: AvatarPlus(
                      randomStrings[index],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

class View extends StatelessWidget {
  final String avatar;

  const View({super.key, required this.avatar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Avatar Plus",
            style: TextStyle(fontSize: 40),
          ),
          Text("Yudiz Solutions Limited © 2024"),
          SizedBox(
            height: 20,
          )
        ],
      ),
      body: Center(
        child: Hero(
          tag: avatar,
          child: AvatarPlus(
            avatar,
            height: MediaQuery.of(context).size.width - 20,
            width: MediaQuery.of(context).size.width - 20,
          ),
        ),
      ),
    );
  }
}
