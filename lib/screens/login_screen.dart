import 'package:assessment_app/extensions/app_num.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:assessment_app/blocs/auth/auth_bloc.dart';
import 'package:assessment_app/blocs/bloc.dart';
import 'screens.dart';

class LoginScreen extends StatelessWidget {
  void _listener(context, state) {
    if (state is AuthSuccess) {
      // Navigate to home screen (not implemented)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Logged in successfully")),
      );
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomeScreen()));
    } else if (state is AuthFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(state.error)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: _listener,
        builder: (context, state) {
          final bloc = context.read<AuthBloc>();
          final loading = state is AuthLoading;
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: bloc.emailController,
                  canRequestFocus: !loading,
                  decoration: InputDecoration(
                      labelText: 'Email', errorText: bloc.emailError),
                  onChanged: (text) {
                    bloc.add(OnLoginTextChangeEvent());
                  },
                ),
                TextField(
                  controller: bloc.passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: bloc.passwordError,
                  ),
                  obscureText: true,
                  canRequestFocus: !loading,
                  onChanged: (text) {
                    bloc.add(OnLoginTextChangeEvent());
                  },
                ),
                10.verticalSpace,
                ElevatedButton(
                  onPressed: loading
                      ? null
                      : () => context.read<AuthBloc>().add(LoginEvent()),
                  child: loading ? 10.progressIndicator : Text('Login'),
                ),
                TextButton(
                  onPressed: loading
                      ? null
                      : () => Navigator.push(context,
                          MaterialPageRoute(builder: (_) => SignUpScreen())),
                  child: Text('Don\'t have an account? Sign up'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
