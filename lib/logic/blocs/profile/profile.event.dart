import 'package:equatable/equatable.dart';
import '../../../data/models/profile.model.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {
  final String authUserId;
  const LoadProfile(this.authUserId);
  @override List<Object?> get props => [authUserId];
}

class UpdateProfile extends ProfileEvent {
  final ProfileModel profile;
  const UpdateProfile(this.profile);
  @override List<Object?> get props => [profile];
}
