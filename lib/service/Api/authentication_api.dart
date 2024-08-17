import 'dart:convert';

import 'package:http/http.dart' as http;

var base_url = "127.0.0.1:8000";

login_endPoint(body) async {
  try {
    var response= await http.post(Uri.parse(base_url),
      body: body
    );
    if(response.statusCode==200){
      var responseBody=jsonDecode(response.body);
      print(responseBody);
    }
  } catch (e) {
    print(e);
  }
}
