import 'dart:core';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lingui_lerni/models.dart';
import 'level_select_page.dart';
import './components/app_bar.dart';
import './components/bottom_bar.dart';
import './http_client.dart';

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
  String selectedCourseId = "";
  bool courseSelected = false;

  Future<void> firsFetch() async {
    _courses = await fetchCourses();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _initSharedPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs!.clear();
  }

  void _saveCourseId(String id) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs!.setString('selectedCourseId', id);
    setState(() {
      selectedCourseId = id;
      courseSelected = true;
    });
  }

  @override
  void initState() {
    super.initState();
    firsFetch();
    _initSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const CircularProgressIndicator();
    print(selectedCourseId);

    return MaterialApp(
      home: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: const Color.fromARGB(255, 236, 236, 236),
        appBar: CustomAppBar(
          title: 'Lingui Lerni',
          gradientColors: const [Color.fromARGB(255, 158, 255, 161), Color.fromARGB(255, 44, 255, 202)], 
          selectedCourse: courseSelected,
          courses:  _courses,
          updateSelectedCourse: _saveCourseId,
        ),
        body: selectedCourseId != "" ? LevelSelectPage(courseId: selectedCourseId) : const CircularProgressIndicator(),
        bottomNavigationBar: const NavBar()
      ),
    );
  }
}