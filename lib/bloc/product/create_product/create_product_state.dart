// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_product_bloc.dart';

@immutable
abstract class CreateProductState {}

class CreateProductInitial extends CreateProductState {}

class CreateProductLoading extends CreateProductState {}

class CreateProductloaded extends CreateProductState {
  final ProductResponseModel productResponseModel;
  CreateProductloaded({
    required this.productResponseModel,
  });
}
