import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiCalls {
  ApiCalls._();

  static Future<List<dynamic>> getData() async {
    try {
      final uri = Uri.parse('https://test-v37i.onrender.com/get');
      final http.Response response = await http.get(uri);
      if (response.statusCode == 200) {
        final values = jsonDecode(response.body);

        return values;
      }
      return [];
    } on SocketException catch (x) {
      throw {'message': "No Internet ", 'err': x.message};
    } catch (e) {
      throw Exception("Unknown error: $e");
    }
  }
}
