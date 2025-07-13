part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

class LoadingUserData extends ProfileState {
  const LoadingUserData();
}

class UserDataLoaded extends ProfileState {
  final UserModel userData;
  final List<PostModel> userPosts;
  const UserDataLoaded(this.userData, this.userPosts);
}

class UserDataLoadingFailed extends ProfileState {
  final String error;
  const UserDataLoadingFailed(this.error);
}
