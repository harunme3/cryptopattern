import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class API33 {
  static var l = Logger();

  static Future<dynamic> getdirecrtreferral({required String address}) async {
    var url = 'http://167.71.237.201:8555/getdirecrtreferral';
    Map data = {
      "myAddress": address,
    };
    //encode Map to JSON
    var body = json.encode(data);
    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: body);
    var responseJson = json.decode(response.body);
    l.w(responseJson);
    return responseJson;
  }
}
