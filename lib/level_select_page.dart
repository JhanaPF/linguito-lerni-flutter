import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:core';
import 'package:animate_do/animate_do.dart';
import 'package:lingui_lerni/models.dart';
import './http_client.dart';
import 'question.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './global_colors.dart';

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
  List<double> cardPositions = [];

  @override
  void initState() {
    super.initState();
    lessonList = widget.lessonList;
    setCardPos();
  }

  void setCardPos() {
    lessonList!.forEach((element) {
      double randomNumber = 0.3 + (Random().nextDouble() * 0.7);
      final randomSide = lessonList!.indexOf(element) % 2 == 0 ? (1 - randomNumber) : (-1 + randomNumber);
      cardPositions.add(randomSide);
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
          alignment: Alignment(cardPositions[index], 0.0),
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
    return Container(
        width: screenWidth * 0.75,
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0), 
            ),
            child: InkWell(
                onTap: () {
                    //_openLesson(items[index]);
                },
                child: Stack(children: [
                  Container( // Background
                    height: 190,
                    decoration: BoxDecoration(
                      color: generateRandomColor(),
                      borderRadius: BorderRadius.circular(12.0), 
                      //image: const DecorationImage(image: NetworkImage(lesson.url), fit: BoxFit.fill), 
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: 
                      Container( // Progress bar  
                        height: 10,
                        width: double.infinity * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.5, // Coefficient de progression
                          child: Container(
                            height: 10,
                            decoration: BoxDecoration(
                              color: GlobalColors.primaryMainColor,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                  ),
                  Positioned( // Texts
                      bottom: 16.0,
                      left: 16.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            capitalizeFirstLetter(lesson.name),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white, 
                              fontFamily: 'Monserrat', 
                              fontWeight: FontWeight.bold, 
                              fontSize: 20
                            ),
                          ),
                          const SizedBox(height: 1.0),
                          Text(
                            capitalizeFirstLetter(lesson.description),
                            style: const TextStyle(
                              color: Colors.white,
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

String capitalizeFirstLetter(String text) {
  if (text == null || text.isEmpty) {
    return text; 
  }
  else {
    return text[0].toUpperCase() + text.substring(1);
  }
}

Color generateRandomColor() {
  final random = Random();
  final r = random.nextInt(256); // Valeurs entre 0 et 255
  final g = random.nextInt(256);
  final b = random.nextInt(256);
  return Color.fromARGB(255, r, g, b);
}