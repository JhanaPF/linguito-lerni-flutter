import 'package:flutter/material.dart';
import 'level_select_page.dart';
import './components/app_bar.dart';
import './components/bottom_bar.dart';

void main() {
  print("main");
  String _selectedCourseId = "";
  int _life = 0;
  List<String> courses;

  runApp(MaterialApp(
    home: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Langue',
          gradientColors: [Color.fromARGB(255, 158, 255, 161), Color.fromARGB(255, 44, 255, 202)],
        ),
        body: const LevelSelectPage(items: ["test", "test"]),
        bottomNavigationBar: const NavBar()),
  ));
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Linguitro Lerni"),
        centerTitle: true,
      ),
      body: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
        child: Text("Je suis un bouton"),
      ),
    );
  }
}
