part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {}

class OnLoginTextChangeEvent extends AuthEvent {}

class OnSignUpTextChangeEvent extends AuthEvent {}
