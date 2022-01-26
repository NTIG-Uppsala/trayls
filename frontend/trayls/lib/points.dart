import 'dart:convert';
import 'dart:async';
import 'package:trayls/api.dart';

class Points {
  String mail = '';
  int points = 0;
  Map<String, dynamic> query = {};

  Points({required this.mail}) {
    query['mail'] = mail;
  }

  Points.res({required this.points});

  factory Points.fromJson(Map<String, dynamic> json) {
    print('hej');
    return Points.res(points: json['user_points']);
  }
}

Future<Points> getPoints(Map<String, dynamic> query) async {
  Api api = Api.query(subdirectory: '/points', queryParams: query);
  var response = await api.get();
  if (response.statusCode == 200) {
    return Points.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load points');
  }
}
