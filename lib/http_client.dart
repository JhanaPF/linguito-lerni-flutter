// ignore: avoid_print
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import './models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

var rootUrl = 'http://10.0.2.2:7005/'; // When you are using android emulator 10.0.2.2 is the correct localhost

Future<Map<String, dynamic>> request(String endpoint, [String method = "get", Map<String, dynamic>? data]) async {
  await dotenv.load(fileName: ".env");
  var isProd = dotenv.env['ENV'] == "prod";
  if (isProd) {
    var apiUrl = dotenv.env['API_URL'];
    if (apiUrl != null) rootUrl = apiUrl;
  }

  var url = Uri.parse(rootUrl + endpoint);
  print({"request", url, method, data});

  http.Response response;
  if (method == "post") {
    response = await http.post(url, body: data);
  } else if (method == "put") {
    response = await http.put(url, body: data);
  } else if (method == "delete") {
    response = await http.delete(url, body: data);
  } else {
    response = await http.get(url);
  }

  print({"Status code:", response.statusCode});
  print({"Body:", response.body});
  if (response.statusCode >= 200 && response.statusCode <= 299) {
    final jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  } else {
    final jsonResponse = jsonDecode(response.body);
    print('Error: ${jsonResponse}');
    Fluttertoast.showToast(msg: "Request failed");
    throw Exception('Request failed');
  }
}

Future<List<CourseModel>> fetchCourses() async {
  Map<String, dynamic> response = await request("courses");
  List<CourseModel> courses = [];
  for (var course in response["data"]["courses"]) {
    courses.add(CourseModel.fromJson(course));
  }
  //print({"courses from fetch: ": courses});
  return courses;
}


Future<List<LessonModel>> fetchLessons(courseId) async {
  Map<String, dynamic> response = await request("lessons", "get", courseId);
  List<LessonModel> lessons = [];
  for (var lesson in response["data"]["lessons"]) {
    lessons.add(LessonModel.fromJson(lesson));
  }
  print({"lessons from fetch: ": lessons});
  return lessons;
}