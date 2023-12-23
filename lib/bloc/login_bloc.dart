import 'dart:convert';
import 'package:cardoor/helpers/api.dart';
import 'package:cardoor/helpers/api_url.dart';
import 'package:cardoor/model/login.dart';

class LoginBloc {
  static Future<Login> login({String? email, String? password}) async {
    String apiUrl = ApiUrl.login;
    var body = {"email": email, "password": password};
    // print('body : $body');
    var response = await Api().post(apiUrl, body);

    var jsonObj = json.decode(response.body);
    return Login.fromJson(jsonObj);
  }
}
