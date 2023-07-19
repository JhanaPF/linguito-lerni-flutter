import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:core';
import 'package:animate_do/animate_do.dart';
import 'package:lingui_lerni/models.dart';
import './http_client.dart';
import 'question.dart';
import 'package:fluttertoast/fluttertoast.dart';

///
/// Select lesson component
///
class LevelSelectPage extends StatefulWidget {
  final String? courseId;
  const LevelSelectPage({required this.courseId});

  @override
  State<LevelSelectPage> createState() => _LevelSelectPage();
}

class _LevelSelectPage extends State<LevelSelectPage> {
  // Lesson selection view
  String? _selectedLesson;
  late Future<List<CourseModel>> _courses;

  @override
  void initState() {
    //print("level select component");
    super.initState();
    _courses = fetchCourses();
    //_lessons = fetchLessons(widget.courseId);
  }

  void _openLesson(String id) {
    //print("Open lesson");
    setState(() {
      _selectedLesson = id;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Question()),
    );
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<CourseModel>>(
      future: _courses,
      builder: (context, snapshot) {
        print({"context level select page", context});
        print({"snapshot level select page", snapshot.data});

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text("Erreur: ${snapshot.error}");
        } else {
          print(snapshot.connectionState == ConnectionState.done);
          Fluttertoast.showToast(msg: "Données récupérées !");
          return LessonList(items: _courses);
        }
      },
    );
  }
}

class LessonList extends StatefulWidget {
  final Future<List<Object>> items;

  LessonList({required this.items});

  @override
  State<LessonList> createState() => _LessonListState();
}

class _LessonListState extends State<LessonList> {
  List<Object>? lessonList;
  List<double> resultList = [];

  @override
  void initState() {
    super.initState();
    // lessonList = widget.items;
    initializeDataOnce();
  }

  void initializeDataOnce() {
    lessonList!.forEach((element) {
      double randomNumber = 0.3 + (Random().nextDouble() * 0.7);
      final randomSide = lessonList!.indexOf(element) % 2 == 0 ? (1 - randomNumber) : (-1 + randomNumber);
      resultList.add(randomSide);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lessonList!.length,
      itemBuilder: (BuildContext context, int index) {
        double screenWidth = MediaQuery.of(context).size.width;
        return Align(
          alignment: const Alignment(0.0, 0.0),
          child: LessonCard(
            screenWidth: screenWidth,
            index: index,
          ),
        );
      },
    );
  }
}

class LessonCard extends StatelessWidget {
  const LessonCard({super.key, required this.screenWidth, required this.index});

  final double screenWidth;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: screenWidth / 2,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), // Modifier le rayon selon votre préférence
            ),
            child: InkWell(
                onTap: () {
                  //_openLesson(items[index]);
                },
                child: Stack(children: [
                  Container(
                    height: 130,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), image: const DecorationImage(image: NetworkImage("assets/FrFlag.png"), fit: BoxFit.fill)),
                  ),
                  Positioned(
                      bottom: 16.0,
                      left: 16.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Niveau $index',
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.grey, fontFamily: 'Monserrat', fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          const SizedBox(height: 1.0),
                          const Text(
                            'Texte inférieur',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ))
                ]))));
  }
}

// Temporary widget with bouncing animated button
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nom du niveau'),
      ),
      body: Column(children: <Widget>[
        Text('hello'),
        ElevatedButton(
            onPressed: () {
              // Navigate where you want
            },
            child: BounceInDown(
                child: Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(color: Colors.red),
            ))),
      ]),
    );
  }
}
