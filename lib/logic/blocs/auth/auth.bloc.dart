import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth.event.dart';
import 'auth.state.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide AuthState;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SupabaseClient supabase;

  AuthBloc({required this.supabase}) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
    on<LoggedOut>(_onLoggedOut);
  }

  Future<void> _onAppStarted(AppStarted _, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = supabase.auth.currentUser;
    if (user != null) {
      emit(Authenticated(user.id));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onLoggedIn(LoggedIn _, Emitter<AuthState> emit) async {
    final user = supabase.auth.currentUser;
    if (user != null)
      emit(Authenticated(user.id));
    else
      emit(Unauthenticated());
  }

  Future<void> _onLoggedOut(LoggedOut _, Emitter<AuthState> emit) async {
    await supabase.auth.signOut();
    emit(Unauthenticated());
  }
}
