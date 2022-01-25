import 'dart:async';
import 'dart:convert';
import 'package:trayls/api.dart';

class Points {
  final String mail;
  final int points;

  Points({required this.mail, required this.points});

  factory Points.fromJson(Map<String, dynamic> json) {
    return Points(mail: json['user_mail'], points: json['user_points']);
  }
}
