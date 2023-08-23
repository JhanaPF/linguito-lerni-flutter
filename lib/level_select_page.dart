import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:core';
import 'package:animate_do/animate_do.dart';
import 'package:lingui_lerni/models.dart';
import './http_client.dart';
import 'question.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// Select lesson widget

class LevelSelectPage extends StatefulWidget {
  final String? courseId;
  const LevelSelectPage({required this.courseId, Key? key}) : super(key: key);

  @override
  State<LevelSelectPage> createState() => _LevelSelectPage();
}

class _LevelSelectPage extends State<LevelSelectPage> {
  // Lesson selection view

  @override
  void initState() {
    //print("level select component");
    super.initState();
    //_lessons = fetchLessons(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LessonModel>>(
      future: fetchLessons("64941e17b5399789d24e2118"),
      builder: (_, snapshot) {
        //print({"context level select page", context});
        //print({"snapshot level select page", snapshot.data});
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text("Erreur: ${snapshot.error}");
        } else if (snapshot.connectionState == ConnectionState.done) {
          Fluttertoast.showToast(msg: "Données récupérées !");
          return LessonList(lessonList: snapshot.data);
        } else {
          return const Text("Failed to fetch for unknow reason");
        }
      },
    );
  }
}

class LessonList extends StatefulWidget {
  final List<LessonModel>? lessonList;

  const LessonList({required this.lessonList, Key? key}) : super(key: key);

  @override
  State<LessonList> createState() => _LessonListState();
}

class _LessonListState extends State<LessonList> {
  late List<LessonModel>? lessonList;
  List<double> resultList = [];

  @override
  void initState() {
    super.initState();
    lessonList = widget.lessonList;
    initializeDataOnce();
  }

  void initializeDataOnce() {
    lessonList!.forEach((element) {
      double randomNumber = 0.3 + (Random().nextDouble() * 0.7);
      final randomSide = lessonList!.indexOf(element) % 2 == 0 ? (1 - randomNumber) : (-1 + randomNumber);
      resultList.add(randomSide);
    });
  }


  void _openLesson(String id) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Question(lessonId: id)),
    );
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
            lesson: lessonList![index]
          ),
        );
      },
    );
  }
}

class LessonCard extends StatelessWidget {
  const LessonCard({super.key, required this.screenWidth, required this.index, required this.lesson});

  final double screenWidth;
  final int index;
  final LessonModel lesson;


  @override
  Widget build(BuildContext context) {
  print("lesson card");
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
                   // decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), image: const DecorationImage(image: NetworkImage(lesson.url), fit: BoxFit.fill)),
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
// Actually called anywhere
class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nom du niveau'),
      ),
      body: Column(children: <Widget>[
        const Text('hello'),
        ElevatedButton(
            onPressed: () {
              // Navigate where you want
            },
            child: BounceInDown(
                child: Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(color: Colors.red),
            ))),
      ]),
    );
  }
}