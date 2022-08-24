import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:worka/models/login/user_model.dart';
import 'package:worka/interfaces/login_interface.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';

class LoginService extends ILogin{
  @override
  Future<UserModel?> login(String password, String email, BuildContext c) async {
    final api = Uri.parse('${ROOT}auth/login/');

    final data = {"password":password, "email":email};
    http.Response response;
    response = await http.post(api, body: data);
    if(response.statusCode == 200 || response.statusCode == 201){
      SharedPreferences storage = await SharedPreferences.getInstance();
      final body = json.decode(response.body);
     await storage.setString('TOKEN', body['auth_token']);
     c.read<Controller>().setToken(body['auth_token'], body['user']);
      await storage.setString('EMAIL', email);
      return UserModel(email, body['auth_token']);


    }else{
      return null;
    }


  }
  @override
  Future<UserModel?> getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('TOKEN');
    final email = storage.getString('EMAIL');
    if (token != null && email != null) {
      return UserModel(email, token);
    } else {
      return null;
    }
  }
  @override
  Future<bool> logout() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final email = storage.getString('EMAIL');
    final token = storage.getString('TOKEN');
    if (email != null && token != null) {
      await storage.remove('TOKEN');
      await storage.remove('EMAIL');
      return true;
    } else {
      return false;
    }
  }


}