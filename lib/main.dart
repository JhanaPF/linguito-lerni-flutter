import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lingui_lerni/models.dart';
import 'level_select_page.dart';
import './components/app_bar.dart';
import './components/bottom_bar.dart';
import './http_client.dart';

int hello = 10;

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences? _prefs;
  bool isLoading = true;
  late List<CourseModel> _courses;
  String? selectectedCourseId;
  bool courseSelected = false;

  Future<void> firsFetch() async {
    _courses = await fetchCourses();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    //print({"prefs:", _prefs});
    _loadDataLocally();
  }

  void _loadDataLocally() {
    if (_prefs != null) {
      selectectedCourseId = _prefs!.getString('selectectedCourseId');
      if(selectectedCourseId != null) {
        courseSelected = true;
      }
      //print('selectectedCourseId: $selectectedCourseId');
    }
  }

  void _saveDataLocally(String id) {
    if (_prefs != null) {
      _prefs!.setString('selectectedCourseId', id);
    }
  }

  @override
  void initState() {
    super.initState();
    firsFetch();
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    print(isLoading);
    if (isLoading) return const CircularProgressIndicator();

    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(
          title: 'Langue',
          gradientColors: const [Color.fromARGB(255, 158, 255, 161), Color.fromARGB(255, 44, 255, 202)], 
          selectedCourse: courseSelected,
          courses:  _courses,
          updateSelectedCourse: _saveDataLocally,
        ),
        body: courseSelected ? LevelSelectPage(courseId: selectectedCourseId) : const CircularProgressIndicator(),
        bottomNavigationBar: const NavBar()
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Linguito Lerni"),
        centerTitle: true,
      ),
      body: Container(
        width: 100,
        height: 100,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
        child: const Text("Je suis un bouton"),
      ),
    );
  }
}