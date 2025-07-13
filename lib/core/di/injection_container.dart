import 'package:devgram/core/constants/strings/app_strings.dart';
import 'package:hive/hive.dart';
import '../../features/auth/data/datasources/auth_local_ds.dart';
import '../../features/auth/data/models/user_model.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/domain/usecases/signup_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/feed/data/datasources/feed_local_ds.dart';
import '../../features/feed/data/models/post_model.dart';
import '../../features/feed/data/repositories/feed_repository_impl.dart';
import '../../features/feed/domain/repositories/feed_repository.dart';
import '../../features/feed/domain/usecases/get_posts_usecase.dart';
import '../../features/feed/domain/usecases/like_post_usecase.dart';
import '../../features/feed/presentation/bloc/feed_bloc.dart';
import '../../features/post/domain/usecases/create_post_usecase.dart';
import '../../features/post/presentation/bloc/create_post_bloc.dart';
import '../../features/profile/domain/usecases/get_userposts_usecase.dart';
import '../../features/profile/domain/usecases/get_userdata_usecase.dart';
import '../../features/profile/presentation/bloc/profile_bloc.dart';

class InjectionContainer {
  // Auth dependencies
  static AuthBloc getAuthBloc() {
    return AuthBloc(
      loginUseCase: getLoginUseCase(),
      registerUseCase: getRegisterUseCase(),
      logoutUsecase: getLogoutUseCase(),
    );
  }

  static LoginUseCase getLoginUseCase() {
    return LoginUseCase(getAuthRepository());
  }

  static RegisterUseCase getRegisterUseCase() {
    return RegisterUseCase(getAuthRepository());
  }

  static LogoutUsecase getLogoutUseCase() {
    return LogoutUsecase(getAuthRepository());
  }

  static AuthRepository getAuthRepository() {
    return AuthRepositoryImpl(
      localDataSource: getAuthLocalDataSource(),
    );
  }

  static AuthLocalDataSource getAuthLocalDataSource() {
    return AuthLocalDataSourceImpl(
      userBox: Hive.box<UserModel>(AppStrings.userBox),
    );
  }

  // Feed dependencies
  static FeedBloc getFeedBloc() {
    return FeedBloc(
      getPostsUseCase: getGetPostsUseCase(),
      likePostUsecase: getLikePostUseCase(),
      repository: getAuthRepository(),
    );
  }

  static GetPostsUseCase getGetPostsUseCase() {
    return GetPostsUseCase(getFeedRepository());
  }

  static LikePostUsecase getLikePostUseCase() {
    return LikePostUsecase(getFeedRepository());
  }

  static FeedRepository getFeedRepository() {
    return FeedRepositoryImpl(
      localDataSource: getFeedLocalDataSource(),
    );
  }

  static FeedLocalDataSource getFeedLocalDataSource() {
    return FeedLocalDataSourceImpl(
      postsBox: Hive.box<PostModel>(AppStrings.postsBox),
      authLocalDataSource: getAuthLocalDataSource(),
    );
  }

  // Post dependencies
  static CreatePostBloc getCreatePostBloc() {
    return CreatePostBloc(
      createPostUsecase: getCreatePostUsecase(),
    );
  }

  static CreatePostUsecase getCreatePostUsecase() {
    return CreatePostUsecase(getFeedRepository());
  }

  // Profile dependencies
  static ProfileBloc getProfileBloc() {
    return ProfileBloc(
      getUserPostsUsecase: getGetUserpostsUsecase(),
      getUserDataUsecase: getGetUserdataUsecase(),
    );
  }

  static GetUserpostsUsecase getGetUserpostsUsecase() {
    return GetUserpostsUsecase(getFeedRepository());
  }

  static GetUserdataUsecase getGetUserdataUsecase() {
    return GetUserdataUsecase(getAuthRepository());
  }
}
