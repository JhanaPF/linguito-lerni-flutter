import 'package:http/http.dart' as http;
import 'dart:convert';

var rootUrl = 'http://10.0.2.2:7005/'; // When you are using android emulator 10.0.2.2 is the correct localhost

Future<String> fetchData(String endpoint, [String method = "get"]) async {
  var url = Uri.parse(rootUrl + endpoint);
  //print("url: ${url}");
  //if (https) url = Uri.https(rootUrl, endpoint);
  print("request");

  http.Response response;
  if (method == "get") {
    response = await http.get(url);
  } else if (method == "post") {
    response = await http.post(url);
  } else
    return "";

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    return jsonResponse;
  } else {
    final jsonResponse = jsonDecode(response.body);
    print('Error: ${jsonResponse}');
    print('Status code: ${response.statusCode}');
    return "";
  }
}
