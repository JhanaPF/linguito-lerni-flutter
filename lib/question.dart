import 'package:flutter/material.dart';
import './http_client.dart';

class Question extends StatefulWidget {
  final String lessonId;

  const Question({required this.lessonId, Key? key}) : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  late String fetchedData = '';
  late String lessonId;

  @override
  void initState() {
    super.initState();
    lessonId = widget.lessonId;
    // Appeler la fonction de récupération ici
    fetchData();
  }

  Future<void> fetchData() async {
    // Effectuer la requête de récupération en utilisant widget.lessonId
    // Exemple fictif : Remplacer cette logique par votre propre logique de requête


    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      fetchedData = 'Données récupérées pour l\'ID ${widget.lessonId}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Ecoutez cette phrase'),
              ElevatedButton(
                onPressed: () async {
                  // Lire le fichier audio
                },
                child: const Text('Lire le fichier audio'),
              ),
              const TextField(
                decoration: InputDecoration(
                  hintText: 'Répétez ce que vous avez entendu',
                ),
              ),
              Text(fetchedData), // Afficher les données récupérées
            ],
          ),
        ),
      ),
    );
  }
}