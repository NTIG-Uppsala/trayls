import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final String subdirectory;
  final String secondLevelDomain = 'netlabua.se';
  Map<String, dynamic> callBody = {};
  Map<String, dynamic> queryParams = {};

  Api({required this.subdirectory});
  Api.body({required this.subdirectory, required this.callBody});
  Api.query({required this.subdirectory, required this.queryParams});

  Future<dynamic> get() async {
    var response =
        await http.get(Uri.http(secondLevelDomain, subdirectory, queryParams));
    return response;
  }

  Future<dynamic> post() async {
    var response = await http.post(
      Uri.http(secondLevelDomain, subdirectory),
      body: callBody,
    );
    return response;
  }
}
