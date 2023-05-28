// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:flutter_auth_bloc/data/localsources/auth_local_storage.dart';
import 'package:meta/meta.dart';

import 'package:flutter_auth_bloc/data/datasources/auth_datasource.dart';
import 'package:flutter_auth_bloc/data/models/request/login_model.dart';
import 'package:flutter_auth_bloc/data/models/response/login_response_model.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthDataSource authDataSource;
  LoginBloc(
    this.authDataSource,
  ) : super(LoginInitial()) {
    on<DoLoginEvent>((event, emit) async {
      try {
        emit(LoginLoading());
        final result = await authDataSource.login(event.loginModel);
        await AuthLocalStorage().saveToken(result.accessToken);
        emit(LoginLoaded(loginResponseModel: result));
      } catch (e) {
        emit(LoginError(message: 'Network problem'));
      }
    });
  }
}
