import 'package:flutter_bloc/flutter_bloc.dart';
import 'profile.event.dart';
import 'profile.state.dart';
import '../../../data/repositories/profiles.repository.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfilesRepository repository;
  ProfileBloc({required this.repository}) : super(ProfileInitial()) {
    on<LoadProfile>(_onLoadProfile);
    on<UpdateProfile>(_onUpdateProfile);
  }

  Future<void> _onLoadProfile(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final p = await repository.getByAuthUserId(event.authUserId);
      if (p == null) {
        emit(ProfileError('Profile not found'));
      } else {
        emit(ProfileLoaded(p));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final updated = await repository.update(event.profile);
      emit(ProfileOperationSuccess(updated));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
