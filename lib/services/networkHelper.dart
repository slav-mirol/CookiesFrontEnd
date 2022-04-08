import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  final String url;
  NetworkHelper({required this.url});

  Future<dynamic> getData() async {
    var client = http.Client();
    http.Response response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      String data = response.body;
      //print(jsonDecode(data));
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      return;
    }
  }
}