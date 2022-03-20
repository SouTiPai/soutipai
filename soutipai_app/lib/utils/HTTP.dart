// ignore_for_file: file_names
import 'dart:convert';

import 'package:http/http.dart' as http;

class getDataFromService {
  Future<List> getData(String url, var arguments) async {
    var uri = Uri.http("192.168.153.188:8080", url, arguments);
    var result = await http.get(uri);
    if (result.statusCode == 200) {
      print(result.body);
    } else {
      print(result.statusCode);
    }
    return json.decode(result.body);
  }
}
