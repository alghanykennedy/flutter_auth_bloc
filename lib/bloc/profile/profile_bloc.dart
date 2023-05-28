// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:flutter_auth_bloc/data/datasources/auth_datasource.dart';
import 'package:flutter_auth_bloc/data/models/response/profile_response_model.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthDataSource authDataSource;
  ProfileBloc(
    this.authDataSource,
  ) : super(ProfileInitial()) {
    on<GetProfileEvent>((event, emit) async {
      try {
        emit(ProfileLoading());
        final result = await authDataSource.getProfile();
        emit(ProfileLoaded(profile: result));
      } catch (e) {
        emit(ProfileError(message: 'network problem: ${e.toString()}'));
      }
    });
  }
}
