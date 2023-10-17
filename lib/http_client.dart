// ignore: avoid_print
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import './models.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:io';

String rootUrl = "";
String apiUrl = "";

Future<String> getRootUrl () async{
  await dotenv.load(fileName: ".env");
  var isProd = dotenv.env['ENV'] == "prod";
  if (isProd) {
    if(apiUrl != "") return apiUrl;
    var getApiUrl = dotenv.env['API_URL'];
    if(getApiUrl != null) apiUrl = getApiUrl;
    if (apiUrl != "") return apiUrl;
  }
  else {
    String? devPort = dotenv.env['DEV_PORT'];
    if (devPort == null) {
      return "";
    } 
    else {
      if (Platform.isAndroid || Platform.isIOS) {
        rootUrl = 'http://10.0.2.2:$devPort/'; // When you are using android emulator 10.0.2.2 is the correct localhost
      } else {
        rootUrl = 'http://127.0.0.1:$devPort/';
      }
    }
  }

  return rootUrl;
}

Future<Map<String, dynamic>> request(String endpoint, {String method = "get", Map<String, dynamic>? data}) async {

  var rootUrl = await getRootUrl();
  var url = Uri.parse(rootUrl + endpoint);
  print({"request", url, method, data});

  http.Response response; 
  if (method == "post") {
    response = await http.post(url, body: data);
  } else if (method == "put") {
    response = await http.put(url, body: data);
  } else if (method == "delete") {
    response = await http.delete(url, body: data);
  } else { // GET method
    final queryString = Uri(queryParameters: data).query;
    if(data == null){
      response = await http.get(url);
    }
    else {
      final uri = Uri.parse('$url?$queryString');
      response = await http.get(uri);
    }
  }

  // print({"Status code": response.statusCode, "Body": response.body});
  
  if (response.statusCode >= 200 && response.statusCode <= 299) {
    final jsonResponse = jsonDecode(response.body);
    return jsonResponse;
  } else {
    final jsonResponse = jsonDecode(response.body);
    //print('Error: ${jsonResponse}');
    Fluttertoast.showToast(msg: "Request failed");
    throw Exception('Request failed');
  }
}

Future<List<CourseModel>> fetchCourses() async {
  Map<String, dynamic> response = await request("courses");
  List<CourseModel> courses = [];
  print(response);
  if (response.containsKey("courses")) {
    for (var course in response["courses"]) {
      courses.add(CourseModel.fromJson(course));
    }
    //print({"courses from fetch: ": courses});
    return courses;
  } else {
    return [];
  }
}

Future<List<LessonModel>> fetchLessons(courseId) async {
  Map<String, dynamic> response = await request("lessons", data: {"course_id": courseId});
  List<LessonModel> lessons = [];
  if (response.containsKey("lessons")) {
    for (var lesson in response["lessons"]) {
      lessons.add(LessonModel.fromJson(lesson));
    }
    //print({"lessons from fetch: ": lessons});
    return lessons;
  } else {
    return [];
  }
}