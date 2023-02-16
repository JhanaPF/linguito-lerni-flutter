import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

void main() {
  runApp(MaterialApp(
    home: LevelSelectPage(),
      theme: ThemeData.dark()
  ));
}

class LevelSelectPage extends StatefulWidget {
  const LevelSelectPage({super.key});

  @override
  State<LevelSelectPage> createState() => _LevelSelectPage();
}

class _LevelSelectPage extends State<LevelSelectPage>  {

  int _selectedIndex = 0;
  int _selectedLanguage = 0;

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Espagnol'),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(10, (index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SecondRoute()),
              );
              // Fonction de sélection de niveau ici
              // Utilisez index pour identifier le niveau sélectionné
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //Image.asset('assets/level_icon_$index.png'),
                  // Image.asset('assets/level_icon_1.png'),
                  Text(
                    'Niveau $index',
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                ],
              )
            ),
          );
        }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Leçons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Progression',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}


class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nom du niveau'),
      ),
      body: Column(
          children: <Widget>[
            Text('hello'),
            ElevatedButton(
              onPressed: () {
                // Navigate where you want
              },
              child: BounceInDown(
                child: Container(width: 10, height: 10, decoration: BoxDecoration(color: Colors.red),)
              )
            ),
        ]),
    );
  }
}

class Question extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[ // A widget is an immutable description of part of a user interface.
              const Text('Ecoutez cette phrase'),
              ElevatedButton(
                onPressed: () async {
                  // Lire le fichier audio
              //    final player = AudioPlayer();
              //    await player.play('path/to/audiofile.mp3');
                },
                child: Text('Lire le fichier audio'),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Répétez ce que vous avez entendu',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Linguistro Lerni"),
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