import 'package:flutter/material.dart';
import 'dart:math';
import 'package:animate_do/animate_do.dart';

class LevelSelectPage extends StatefulWidget {
  const LevelSelectPage({super.key});

  @override
  State<LevelSelectPage> createState() => _LevelSelectPage();
}

class _LevelSelectPage extends State<LevelSelectPage> {
  final List<String> items = ['Item 1', 'Item 2', 'Item 3', 'Item 4', 'Item 5', 'kk', "iuh"];
  double _selectedLesson = 0;

  void _openLesson(double id) {
    setState(() {
      _selectedLesson = id;
    });

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SecondRoute()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          double randomNumber = 0.3 + (Random().nextDouble() * 0.7);
          double screenHeight = MediaQuery.of(context).size.height;
          double screenWidth = MediaQuery.of(context).size.width;
          final randomSide = index % 2 == 0 ? (1 - randomNumber) : (-1 + randomNumber);

          return Align(
            alignment: Alignment(randomSide, 0.0),
            child: Container(
                //height: screenHeight / 4,
                width: screenWidth / 2,
                child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0), // Modifier le rayon selon votre préférence
                    ),
                    child: Stack(children: [
                      Container(
                        height: 130,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), image: const DecorationImage(image: AssetImage("assets/FrFlag.png"), fit: BoxFit.fill)),
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
                    ]))),
          );
        });
  }
}

class SecondRoute extends StatelessWidget {
  // Temporary widget with bouncing animated button
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
