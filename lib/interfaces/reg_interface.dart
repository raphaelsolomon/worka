import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:worka/models/register/user_register_model.dart';

abstract class IRegister {
  String baseUrl = 'api.workanetworks.com';
  Future<UserModel?> register(
      String firstname,
      String middlename,
      String surname,
      String email,
      String contact,
      String password,
      String re_password,
      String acc_type) async {
    String api = '$baseUrl/users';
    final data = {
      'phone': contact,
      'first_name': surname,
      'last_name': firstname,
      'other_name': middlename,
      'account_type': acc_type,
      'email': email,
      'password': password,
      're_password': re_password
    };
    final dio = Dio();
    Response response;
    response = await dio.post(api, data: data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      return UserModel(firstname, middlename, surname, email, contact, password,
          re_password, acc_type);
    }
    return null;
  }

  Future<UserModel?> getUser() async {
    SharedPreferences storage = await SharedPreferences.getInstance();
    final token = storage.getString('TOKEN');
    final email = storage.getString('EMAIL');
    final firstname = storage.getString('FIRSTNAME');
    final middlename = storage.getString('MIDDLENAME');
    final surname = storage.getString('SURNAME');
    final contact = storage.getString('CONTACT');
    final password = storage.getString('password');
    final re_password = storage.getString('re_password');
    final acc_type = storage.getString('acc_type');

    if (token != null &&
        email != null &&
        firstname != null &&
        middlename != null &&
        surname != null &&
        contact != null &&
        password != null &&
        re_password != null &&
        acc_type != null) {
      return UserModel(firstname, middlename, surname, email, contact, password,
          re_password, acc_type);
    } else {
      return null;
    }
  }

  // Future<bool> logout() async {
  //   SharedPreferences storage = await SharedPreferences.getInstance();
  //   return true;
  // }
}
