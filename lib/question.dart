import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // A widget is an immutable description of part of a user interface.
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
