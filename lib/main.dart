import 'package:flutter/material.dart';
import 'level_select_page.dart';
import './components/app_bar.dart';
import './components/bottom_bar.dart';
import 'package:http/http.dart' as http;

var rootUrl = 'localhost:7705/';

void main() {
  String _selectedCourseId = "";
  int _life = 0;

  List<String> courses;
  var fetch = fetchData("dictionaries");
  print(fetch);

  runApp(MaterialApp(
    home: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(
          title: 'Langue',
          gradientColors: [Color.fromARGB(255, 158, 255, 161), Color.fromARGB(255, 44, 255, 202)],
        ),
        body: const LevelSelectPage(items: ["test", "test"]),
        bottomNavigationBar: const NavBar()),
  ));
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

Future<String> fetchData(String endpoint) async {
  var url = Uri.parse(rootUrl + endpoint);
  var response = await http.get(url);
  print("fetch datas");
  if (response.statusCode == 200) {
    print(response.body);
    return response.body;
  } else {
    print('Échec de la requête avec le code d\'erreur: ${response.statusCode}');
    return '';
  }
}

Future<void> sendData() async {
  var url = Uri.parse('https://votre-api.com/endpoint');
  var body = {'param1': 'valeur1', 'param2': 'valeur2'};
  var response = await http.post(url, body: body);

  if (response.statusCode == 200) {
    // Requête réussie, vous pouvez traiter les données de la réponse ici
    print(response.body);
  } else {
    // La requête a échoué
    print('Échec de la requête avec le code d\'erreur: ${response.statusCode}');
  }
}
