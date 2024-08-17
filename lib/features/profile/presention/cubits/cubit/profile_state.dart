part of 'profile_cubit.dart';

sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSucess extends ProfileState {
  UserModel userModel;
  ProfileSucess( {required this.userModel});
}

final class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure(this.error);
}

final class EditProfileLoading extends ProfileState {}

final class EditProfileSucess extends ProfileState {}

final class EditProfileFailure extends ProfileState {
  final String error;
  EditProfileFailure(this.error);
}
final class FollowUserLoading extends ProfileState {}
final class FollowUserSuccess extends ProfileState {}
final class FollowUserFailure extends ProfileState {
  final String error;
  FollowUserFailure(this.error);
}

