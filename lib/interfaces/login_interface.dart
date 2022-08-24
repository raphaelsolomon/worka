import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:worka/models/login/user_model.dart';
import 'package:worka/phoenix/Controller.dart';
import 'package:worka/phoenix/model/Constant.dart';

class ILogin {
  Future<UserModel?> login(
      String password, String email, BuildContext context) async {
    const api = '${ROOT}auth/login/';
    final response = await Dio()
        .post(api, data: {'password': password.trim(), 'email': email.trim()});
    if (response.statusCode == 200) {
      print(response.data);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      context.read<Controller>().setToken(
          '${response.data['auth_token']}', '${response.data['user']}');
      preferences.setString('token', '${response.data['auth_token']}');
      preferences.setString(TYPE, '${response.data['user']}');
      preferences.setString('DETAILS', '${response.data}');
      context.read<Controller>().getprofileReview();
      return UserModel(email, '${response.data['auth_token']}');
    }
    return null;
  }

  Future<UserModel?> getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('token');
    final email = storage.getString('EMAIL');
    if (token != null && email != null) {
      return UserModel(email, token);
    } else {
      return null;
    }
  }

  Future<bool> logout() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    await storage.clear();
    return true;
  }

  Future<String> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString('token') ?? '';
  }

  Future<String> getType() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(TYPE) ?? '';
  }
}
