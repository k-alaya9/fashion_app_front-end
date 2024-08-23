import 'dart:convert';

import 'package:fashionapp/model/categoryModel.dart';
import 'package:fashionapp/model/clothesModel.dart';
import 'package:fashionapp/service/Api/TokenStorage.dart';
import 'package:http/http.dart' as http;

import '../../model/User.dart';

var ip_address='192.168.241.137:8000';
register_endPoint(username,email,password)async{
  var request = http.Request('GET', Uri.parse('http://$ip_address/api/auth/register/'));

  request.body = json.encode({
    "username": "$username",
    "email": "$email",
    "password": "$password"
  });

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var data=jsonDecode( await response.stream.bytesToString());
    print(data);
    TokenStorage().saveToken(data['access_token']);
    TokenStorage().saveRToken(data['refresh_token']);
  }
  else {
  print(response.reasonPhrase);
  }
}


Future<void> logout() async {
  final String url = 'http://$ip_address/api/auth/logout/';

  final String bearerToken = TokenStorage().getToken()!;

  final Map<String, dynamic> body = {
    'refresh_token':
    TokenStorage().getRToken()
  };

  // Send the POST request
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    print('Logout successful');
    TokenStorage().deleteRToken();
    TokenStorage().deleteToken();
  } else {
    print('Logout failed: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}


Future<void> login(username,password) async {
  final String url = 'http://$ip_address/api/token';

  final Map<String, dynamic> body = {
    'username': '$username',
    'password': '$password',
  };

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(body),
  );

  if (response.statusCode == 200) {
    print('Login successful');
    print('Response body: ${response.body}');
    var data=jsonDecode(response.body);
    print(data);
    TokenStorage().saveToken(data['access']);
    TokenStorage().saveRToken(data['refresh']);
  } else {
    print('Login failed: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

getUser() async {

  final String url = 'http://$ip_address/api/users/me';

  final String bearerToken =TokenStorage().getToken()!;

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    print('Retrieved cloth item successfully');
    print('Response body: ${response.body}');
    var data=jsonDecode(response.body);
    return User.fromJson(data);
  } else {
    print('Failed to retrieve cloth item: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}


 getAllClothes() async {
  // Define the API endpoint
  final String url = 'http://$ip_address/api/clothes';

  // Define the Bearer token
  final String bearerToken =TokenStorage().getToken()!;

  // Send the GET request
  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    },
  );

  // Check the response status code
  if (response.statusCode == 200) {
    print('Retrieved all clothes successfully');
    print('Response body: ${response.body}');
    List data=jsonDecode(response.body);
    List<clothes>resp=data.map((e) => clothes.fromJson(e)).toList();
    return resp;
  } else {
    print('Failed to retrieve clothes: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

 getClothById(int id) async {

  final String url = 'http://$ip_address/api/clothes/$id';


  final String bearerToken =TokenStorage().getToken()!;

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    print('Retrieved cloth item successfully');
    print('Response body: ${response.body}');
    var data=jsonDecode(response.body);
    return clothes.fromJson(data);
  } else {
    print('Failed to retrieve cloth item: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}


getSavedList() async {
  final String url = 'http://$ip_address/api/saved/';

  final String bearerToken =TokenStorage().getToken()!;


  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    },
  );


  if (response.statusCode == 200) {
    print('Retrieved saved clothes successfully');
    print('Response body: ${response.body}');
    List data= jsonDecode(response.body);
    return data.map((e)=>clothes.fromJson(e['clothes'])).toList();
  } else {
    print('Failed to retrieve saved clothes: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}



 unsaveClothItem(id) async {
  final String url = 'http://$ip_address/api/saved/unsave/$id';

  final String bearerToken = TokenStorage().getToken()!;


  final response = await http.delete(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 204) {
    print('Cloth item unsaved successfully');
    print('Response body: ${response.body}');

  } else {
    print('Failed to unsave cloth item: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}



 saveClothItem(int id) async {

  final String url = 'http://$ip_address/api/saved/';

  final String bearerToken =TokenStorage().getToken()!;

  final Map<String, dynamic> requestBody = {'clothes': id};

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 201) {
    print('Cloth item saved successfully');
    print('Response body: ${response.body}');
        var data=jsonDecode(response.body)['id'];
    return data;
  } else {
    print('Failed to save cloth item: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}


Future<void> reportBug(report) async {
  final String url = 'http://localhost:8000/api/report/';


  final String bearerToken =
TokenStorage().getToken()!;

  final Map<String, dynamic> requestBody = {
    'report': report
  };


  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestBody),
  );

  if (response.statusCode == 200) {
    print('Bug reported successfully');
    print('Response body: ${response.body}');
  } else {
    print('Failed to report bug: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}


Future<void> getUserInfo() async {

  final String url = 'http://$ip_address/api/users/1';


  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    print('User info retrieved successfully');
    print('Response body: ${response.body}');
  } else {
    print('Failed to retrieve user info: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}


Future<void> getHistory() async {

  final String url = 'http://$ip_address/api/history/';
  final String bearerToken =
      TokenStorage().getToken()!;

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    print('History retrieved successfully');
    print('Response body: ${response.body}');
  } else {
    print('Failed to retrieve history: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}



Future<void> submitFeedback(int id,int rate,description) async {

  final String url = 'http://$ip_address/api/feedback/';


  final String bearerToken =TokenStorage().getToken()!;

  final Map<String, dynamic> requestBody = {
    'cloth': id,
    'rate': rate,
    'description': description
  };

  // Send the POST request
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    },
    body: jsonEncode(requestBody),
  );


  if (response.statusCode == 200) {
    print('Feedback submitted successfully');
    print('Response body: ${response.body}');
  } else {
    print('Failed to submit feedback: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}


 getAllCategories() async {

  final String url = 'http://$ip_address/api/category/';


  final String bearerToken = TokenStorage().getToken()!;

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    print('Categories retrieved successfully');
    print('Response body: ${response.body}');
    List data=jsonDecode(response.body);
    return data.map((e)=>Category.fromJson(e)).toList();
  } else {
    print('Failed to retrieve categories: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}



 getClothesInCategory(int categoryId) async {
  final String url = 'http://$ip_address/api/category/clothes/$categoryId';

  final String bearerToken =TokenStorage().getToken()!;

  final response = await http.get(
    Uri.parse(url),
    headers: {
      'Authorization': 'Bearer $bearerToken',
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    print('Clothes in category retrieved successfully');
    print('Response body: ${response.body}');
        List data= jsonDecode(response.body);
    return data.map((e)=>clothes.fromJson(e)).toList();
  } else {
    print('Failed to retrieve clothes in category: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}

tryVritualOn(String imagePath,String imagePath2)async{
      final String url = 'http://$ip_address/api/experiment/';

      final String bearerToken =TokenStorage().getToken()!;

      var request= http.MultipartRequest('POST',Uri.parse(url));
      request.headers.addAll({
          'Authorization': 'Bearer $bearerToken',
          // 'Content-Type': 'application/json',
        },);
      request.files.add(await http.MultipartFile.fromPath('user_photo_path', imagePath));
      request.files.add(await http.MultipartFile.fromPath('clothes_photo_path', imagePath2));
      
      var response= await request.send();
      
      if(response.statusCode==201){
        print('Virtual try on successful');
        var data=jsonDecode(await response.stream.bytesToString());
        print(data);
        return data;
      }
      else{
        print('Failed to perform virtual try on: ${response.statusCode}');
        var data=jsonDecode(await response.stream.bytesToString());
        print(data);
      }

}