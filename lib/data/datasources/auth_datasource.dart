import 'dart:convert';

import 'package:flutter_auth_bloc/data/localsources/auth_local_storage.dart';
import 'package:flutter_auth_bloc/data/models/request/login_model.dart';
import 'package:flutter_auth_bloc/data/models/request/register_mode.dart';
import 'package:flutter_auth_bloc/data/models/response/login_response_model.dart';
import 'package:flutter_auth_bloc/data/models/response/profile_response_model.dart';
import 'package:flutter_auth_bloc/data/models/response/register_response_model.dart';
import 'package:http/http.dart' as http;

class AuthDataSource {
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

  Future<LoginResponseModel> login(LoginModel loginModel) async {
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/auth/login'),
      body: loginModel.toMap(),
    );

    final result = LoginResponseModel.fromJson(response.body);
    return result;
  }

  Future<ProfileResponseModel> getProfile() async {
    final token = await AuthLocalStorage().getToken();
    var headers = {'Authorization': 'Bearer $token'};
    final response = await http.get(
        Uri.parse('https://api.escuelajs.co/api/v1/auth/profile'),
        headers: headers);

    if (response.statusCode == 200) {
      return ProfileResponseModel.fromJson(jsonDecode(response.body));
    }
    final result = ProfileResponseModel.fromJson(jsonDecode(response.body));
    return result;
  }
}
