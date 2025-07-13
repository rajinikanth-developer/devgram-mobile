import 'package:bloc/bloc.dart';
import 'package:devgram/core/constants/strings/validation_messages.dart';
import 'package:equatable/equatable.dart';

import '../../../auth/data/models/user_model.dart';
import '../../../feed/data/models/post_model.dart';
import '../../domain/usecases/get_userdata_usecase.dart';
import '../../domain/usecases/get_userposts_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetUserpostsUsecase getUserPostsUsecase;
  final GetUserdataUsecase getUserDataUsecase;
  UserModel? currentUser = null;
  List<PostModel> userPosts = [];
  String currentUserId = '';

  ProfileBloc(
      {required this.getUserPostsUsecase, required this.getUserDataUsecase})
      : super(ProfileInitial()) {
    on<LoadUserData>(fetchUserData);
  }
  void fetchUserData(LoadUserData event, Emitter<ProfileState> emit) async {
    emit(LoadingUserData());
    try {
      final userEntity = await getUserDataUsecase();
      if (userEntity != null) {
        currentUser = UserModel.fromEntity(userEntity);
        currentUserId = currentUser!.id;
        final postEntities = await getUserPostsUsecase();
        userPosts = postEntities.map((entity) => entity.toModel()).toList();
        emit(UserDataLoaded(currentUser!, userPosts));
      } else {
        emit(UserDataLoadingFailed(AppValidationMessages.userNotFound));
      }
    } catch (e) {
      emit(UserDataLoadingFailed(e.toString()));
    }
  }
}
