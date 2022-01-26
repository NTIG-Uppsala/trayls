import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final String subdirectory;
  final String secondLevelDomain = 'netlabua.se';
  String callBody = '';

  Api({required this.subdirectory});
  Api.body({required this.subdirectory, required this.callBody});

  //connect to the server and get the data with body
  Future<dynamic> get() async {
    var response = await http.get(Uri.http(secondLevelDomain, subdirectory),
        body: jsonEncode(<String, String>{'body': callBody}));
    return response;
  }

  final http.Request request =
      http.Request('GET', Uri.http('netlabua.se', subdirectory));
}
