import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:your_list_flutter_app/services/auth.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';


/// This class is responcible for keeping track of the authentication states
/// This class also extends bloc plugin more information for usage
/// could be found on their website
///
/// This patter has similar to mix of MVC and strategy patters
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthService _userRepository;

  AuthenticationBloc({@required AuthService authService})
      : assert(authService != null),
        _userRepository = authService;

  /// Setting up initial state at which we want to start the app
  @override
  AuthenticationState get initialState => Uninitialized();

  /// Which state should be started by given event
  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,
      ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  /// Determining whether should used go to log in screen or to
  /// home screen
  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final name = await _userRepository.getUser();
        yield Authenticated(name);
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(await _userRepository.getUser());
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    _userRepository.signOut();
  }
}
