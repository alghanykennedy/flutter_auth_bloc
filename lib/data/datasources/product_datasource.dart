import 'dart:convert';

import 'package:flutter_auth_bloc/data/models/request/product_model.dart';
import 'package:flutter_auth_bloc/data/models/response/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductDataSources {
  Future<ProductResponseModel> createProduct(ProductModel model) async {
    final headers = {'Content-Type': 'application/json'};
    final response = await http.post(
      Uri.parse('https://api.escuelajs.co/api/v1/products'),
      headers: headers,
      body: model.toJson(), // Convert model to JSON string
    );
    return ProductResponseModel.fromJson(response.body);
  }

  Future<ProductResponseModel> updateProduct(ProductModel model, int id) async {
    final headers = {'Content-Type': 'application/json'};
    final response = await http.put(
      Uri.parse('https://api.escuelajs.co/api/v1/products/$id'),
      headers: headers,
      body: model.toMap(), // Convert model to JSON string
    );
    return ProductResponseModel.fromJson(response.body);
  }

  Future<ProductResponseModel> getProductById(int id) async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products/$id'),
    );
    return ProductResponseModel.fromJson(response.body);
  }

  Future<List<ProductResponseModel>> getAllProduct() async {
    final response = await http.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products'),
    );

    final result = List<ProductResponseModel>.from(jsonDecode(response.body)
        .map((x) => ProductResponseModel.fromMap(x))).toList();

    return result;
  }
}
