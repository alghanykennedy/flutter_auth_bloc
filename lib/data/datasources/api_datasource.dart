import 'dart:convert';

import 'package:flutter_auth_bloc/data/models/request/register_mode.dart';
import 'package:flutter_auth_bloc/data/models/response/register_response_model.dart';
import 'package:http/http.dart' as http;

class ApiDataSource {
  Future<RegisterResponseModel> register(RegisterModel registerModel) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/users/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(registerModel.toMap()),
    );

    if (response.statusCode == 200) {
      return RegisterResponseModel.fromJson(jsonDecode(response.body));
    }
    final result = RegisterResponseModel.fromJson(jsonDecode(response.body));
    return result;
  }
}
