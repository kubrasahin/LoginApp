import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:loginproject/models/usersModel.dart';
import 'package:loginproject/view/id.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Services {
  // Kullanıcıları Çekme
  Future<Users?> getUsers() async {
    var res = await http.get(Uri.parse(Id + "api/users?page=2"));
    if (res.statusCode == 200) {
      var jsonBody = Users.fromJson(jsonDecode(res.body));
      return jsonBody;
    } else {
      print("İstek Hatalı");
    }
  }

  // kullanıcı Girişi
  Future userLogin(String email, String password) async {
    Map<String, dynamic> body = {
      "email": email,
      "password": password,
    };

    var res = await http.post(Uri.parse(Id + "api/login"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
        },
        body: jsonEncode(body));
    var response = json.encode(res.body);
    if (res.statusCode == 200) {
      SharedPreferences token = await SharedPreferences.getInstance();
      token.setString('token', response);
      return "Success";
    } else {
      return "Kullanıcı Bulunamadı";
    }
  }
}
