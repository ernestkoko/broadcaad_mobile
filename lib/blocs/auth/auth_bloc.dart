import 'dart:async';
import 'dart:developer';

import 'package:assessment_app/extensions/app_string.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:assessment_app/repositories/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignUpEvent>(_onSignUp);
    on<OnLoginTextChangeEvent>(_onLoginChange);
    on<OnSignUpTextChangeEvent>(_onSignUpChange);
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();

  String? _emailError;

  String? get emailError => _emailError;
  String? _passwordError;

  String? get passwordError => _passwordError;

  String? _signUpEmailError;

  String? get signUpEmailError => _signUpEmailError;
  String? _signupPasswordError;

  String? get signupPasswordError => _signupPasswordError;
  bool _loginButtonClicked = false;
  bool _signUpButtonClicked = false;

  Future _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    try {
      _loginButtonClicked = true;
      emit(AuthLoading());
      if (!_validateLogin()) {
        emit(AuthInitial());
        return;
      }
      await authRepository.signIn(
          emailController.text, passwordController.text);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      log(e.runtimeType.toString()+"mm");
      emit(AuthFailure(e.message ?? e.toString()));
    } catch (e) {
      log(e.runtimeType.toString());
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    try {
      _signUpButtonClicked = true;
      emit(AuthLoading());
      if (!_validateSignUp()) {
        emit(AuthInitial());
        return;
      }
      await authRepository.signUp(
          signUpEmailController.text, signUpPasswordController.text);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  FutureOr<void> _onLoginChange(
      OnLoginTextChangeEvent event, Emitter<AuthState> emit) {
    log("Loginchange");
    log(_loginButtonClicked.toString());
    emit(AuthLoading());
    _validateLogin();
    emit(AuthInitial());
  }

  FutureOr<void> _onSignUpChange(
      OnSignUpTextChangeEvent event, Emitter<AuthState> emit) {
    emit(AuthLoading());
    _validateSignUp();
    emit(AuthInitial());
  }

  bool _validateLogin() {
    bool valid = true;
    if (!_loginButtonClicked) return valid;

    if (emailController.text.isEmpty) {
      _emailError = "Email can not be empty";
      valid = false;
    } else {
      if (!emailController.text.isEmail) {
        _emailError = "Email can not be empty";
        valid = false;
      } else {
        _emailError = null;
      }
    }

    //password
    if (passwordController.text.isEmpty) {
      _passwordError = "Password can not be empty";
      valid = false;
    } else {
      if (passwordController.text.length < 4) {
        _passwordError = "Password too short ";
        valid = false;
      } else {
        _passwordError = null;
      }
    }
    return valid;
  }

  bool _validateSignUp() {
    bool valid = true;
    if (!_signUpButtonClicked) return valid;
    if (signUpEmailController.text.isEmpty) {
      _signUpEmailError = "Email can not be empty";
      valid = false;
    } else {
      if (!signUpEmailController.text.isEmail) {
        _signUpEmailError = "Email can not be empty";
        valid = false;
      } else {
        _signUpEmailError = null;
      }
    }

    //password
    if (signUpPasswordController.text.isEmpty) {
      _signupPasswordError = "Password can not be empty";
      valid = false;
    } else {
      if (signUpPasswordController.text.length < 4) {
        _signupPasswordError = "Password too short ";
        valid = false;
      } else {
        _signupPasswordError = null;
      }

    }
    return valid;
  }
}
