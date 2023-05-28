// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_auth_bloc/data/datasources/auth_datasource.dart';
import 'package:flutter_auth_bloc/data/models/request/register_mode.dart';

import '../../data/models/response/register_response_model.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthDataSource dataSource;
  RegisterBloc(
    this.dataSource,
  ) : super(RegisterInitial()) {
    on<SaveRegisterEvent>((event, emit) async {
      emit(RegisterLoading());
      final result = await dataSource.register(event.request);
      emit(RegisterLoaded(registerResponseModel: result));
    });
  }
}
