import 'package:http/http.dart' as http;

class Api {
  final String subdirectory;
  final String secondLevelDomain = 'netlabua.se/';

  Api({required this.subdirectory});

  //connect to the server and get the data
  Future<dynamic> get() async {
    var response = await http.get(Uri.http(secondLevelDomain, subdirectory));
    return response;
  }
}
