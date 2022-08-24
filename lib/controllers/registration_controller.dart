import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class RegistrationController{
  String baseUrl = 'api.workanetworks.com';
  var status;
  var token;


  registrationData(String firstName, String middleName, String surName,String email, String contact, String password)async {
    String myUrl = '$baseUrl/users';
    final response = await http.post(Uri.parse(myUrl),
      headers: {
      'Accept':'application/json'
      },
      body: {
      'phone':contact,
        'first_name': surName,
        'last_name': firstName,
        'other_name': middleName,
        'account_type':'employee',
        'email': email,
        'password':password,
        're_password':password
      }
    );
    status = response.body.contains('error');
    var data = json.decode(response.body);
    if(status){
      debugPrint('data : ${data['non_field_errors']}');
    }else{
      debugPrint('data : ${data['auth_token']}');
      _save(data['auth_token']);
    }

  }
  _save(String token) async {
    final prefs = await SharedPreferences.getInstance();
    var key = 'token';
    final value = token;
    prefs.setString(key, value);
  }


  read() async {
    final prefs = await SharedPreferences.getInstance();
    var key = 'token';
    final value = prefs.get(key ) ?? 0;
    print('read : $value');
  }


}
