import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  final String subdirectory;
  final String secondLevelDomain = 'netlabua.se';
  String callBody = '';
  Map<String, dynamic> queryParams = {};

  Api({required this.subdirectory});
  Api.body({required this.subdirectory, required this.callBody});
  Api.query({required this.subdirectory, required this.queryParams});

  Future<dynamic> get() async {
    var response =
        await http.get(Uri.http(secondLevelDomain, subdirectory, queryParams));
    return response;
  }

  //connect to the server and get the data with body
}
