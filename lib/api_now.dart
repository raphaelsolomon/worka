import 'dart:convert';

import 'package:http/http.dart' as http;

Future getApi () async{
  var url = Uri.parse('');
  var response = await http.get(url);
  if(response.statusCode == 200){
    return jsonDecode(response.body);
  }else{
    return response.body;
  }
}