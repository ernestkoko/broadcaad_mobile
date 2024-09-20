import 'package:assessment_app/extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assessment_app/blocs/auth/auth_bloc.dart';
import 'package:assessment_app/blocs/bloc.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            // Navigate to login screen
            Navigator.pop(context);
          } else if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<AuthBloc>();
          final loading = state is AuthLoading;
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: bloc.signUpEmailController,
                    canRequestFocus: !loading,
                    decoration: InputDecoration(
                        labelText: 'Email', errorText: bloc.signUpEmailError),
                    onChanged: (text) => bloc.add(OnSignUpTextChangeEvent())),
                TextField(
                  controller: bloc.signUpPasswordController,
                  decoration: InputDecoration(
                      labelText: 'Password',
                      errorText: bloc.signupPasswordError),
                  obscureText: true,
                  canRequestFocus: !loading,
                  onChanged: (text) => bloc.add(OnSignUpTextChangeEvent()),
                ),
                10.verticalSpace,
                ElevatedButton(
                  onPressed: loading
                      ? null
                      : () => context.read<AuthBloc>().add(SignUpEvent()),
                  child: loading ? 10.progressIndicator : Text('Sign Up'),
                ),
                TextButton(
                  onPressed: loading ? null : () => Navigator.of(context).pop(),
                  child: Text('Have an account? Login'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
