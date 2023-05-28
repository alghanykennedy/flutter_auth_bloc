// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_auth_bloc/data/models/response/product_response_model.dart';
import 'package:meta/meta.dart';

import 'package:flutter_auth_bloc/data/datasources/product_datasource.dart';
import 'package:flutter_auth_bloc/data/models/request/product_model.dart';

part 'create_product_event.dart';
part 'create_product_state.dart';

class CreateProductBloc extends Bloc<CreateProductEvent, CreateProductState> {
  ProductDataSources productDataSources;
  CreateProductBloc(
    this.productDataSources,
  ) : super(CreateProductInitial()) {
    on<DoCreateProductEvent>((event, emit) async {
      emit(CreateProductLoading());
      final result = await productDataSources.createProduct(event.productModel);
      emit(CreateProductloaded(productResponseModel: result));
    });
  }
}
