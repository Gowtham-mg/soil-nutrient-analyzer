import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:soilnutrientanalyzer/app_response.dart';
import 'package:soilnutrientanalyzer/model/user.dart';
import 'package:soilnutrientanalyzer/repository/login_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  final Box box;

  AuthBloc(this.authRepository, this.box) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    yield AuthLoading();
    if (event is SignInFBGoogleEvent) {
      AppResponse<User> response = await authRepository.googleAuth();
      if (response.isSuccess) {
        yield SocialAuthSuccess(response.data);
      } else {
        yield AuthErrorState(response.error);
      }
    } else if (event is SignInEvent) {
      try {
        AppResponse<User> result = await authRepository.signIn(
          event.email,
          event.password,
        );
        await box.put('email', result.data.email);
        await box.put('username', result.data.id);
        if (result.isSuccess) {
          yield SignInSuccess();
        } else {
          yield AuthErrorState(result.error);
        }
      } catch (e) {
        yield AuthErrorState(e.toString());
      }
    } else if (event is SignUpEvent) {
      try {
        AppResponse<User> result = await authRepository.signUp(
          event.email,
          event.password,
        );
        await box.put('email', result.data.email);
        await box.put('username', result.data.id);
        if (result.isSuccess) {
          yield SignUpSuccess();
        } else {
          yield AuthErrorState(result.error);
        }
      } catch (e) {
        yield AuthErrorState(e.toString());
      }
    }
  }
}

abstract class AuthEvent extends Equatable {}

class SignUpEvent extends AuthEvent {
  final String email;
  final String password;

  SignUpEvent(this.email, this.password);
  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent(this.email, this.password);

  @override
  List<Object> get props => [this.email, this.password];
}

class SignInFBGoogleEvent extends AuthEvent {
  final String provider;

  SignInFBGoogleEvent(this.provider);
  @override
  List<Object> get props => [];
}

abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class SocialAuthSuccess extends AuthState {
  final User user;

  SocialAuthSuccess(this.user);
  @override
  List<Object> get props => [this.user];
}

class SignInSuccess extends AuthState {
  SignInSuccess();
  @override
  List<Object> get props => [];
}

class SignUpSuccess extends AuthState {
  SignUpSuccess();
  @override
  List<Object> get props => [];
}

class AuthErrorState extends AuthState {
  final String error;

  AuthErrorState(this.error);
  @override
  List<Object> get props => [this.error];
}
