import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:assessment_app/repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc(this.authRepository) : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is LoginEvent) {
      yield AuthLoading();
      try {
        // Intentional Bug: Incorrect password validation
        if (event.password.length > 4) {
          throw Exception('Password too short');
        }
        await authRepository.signIn(event.email, event.password);
        yield AuthSuccess();
      } catch (e) {
        yield AuthFailure(e.toString());
      }
    } else if (event is SignUpEvent) {
      yield AuthLoading();
      try {
        await authRepository.signUp(event.email, event.password);
        yield AuthSuccess();
      } catch (e) {
        yield AuthFailure(e.toString());
      }
    }
  }
}
