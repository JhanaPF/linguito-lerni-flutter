import 'package:flutter/material.dart';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import './http_client.dart';

class LevelSelectPage extends StatefulWidget {
  final List<String> items;
  const LevelSelectPage({required this.items});

  @override
  State<LevelSelectPage> createState() => _LevelSelectPage();
}

class _LevelSelectPage extends State<LevelSelectPage> {
  String _selectedLesson = "null";
  late List<String> items;

  @override
  void initState() {
    fetchData("dictionaries");
    super.initState();
    items = widget.items;
  }

  void _openLesson(String id) {
    print("Open lesson");
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
          //double screenHeight = MediaQuery.of(context).size.height;
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
                    child: InkWell(
                        onTap: () {
                          //_openLesson(items[index]);
                        },
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
                        ])))),
          );
        });
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
