import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/strings/validation_messages.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/domain/repositories/auth_repository.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/usecases/get_posts_usecase.dart';
import '../../domain/usecases/like_post_usecase.dart';

part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetPostsUseCase getPostsUseCase;
  final LikePostUsecase likePostUsecase;
  final AuthRepository repository;
  late List<PostEntity> allPosts;
  UserEntity? currentUser;
  String currentUserId = '';

  FeedBloc({
    required this.getPostsUseCase,
    required this.likePostUsecase,
    required this.repository,
  }) : super(FeedInitial()) {
    on<FetchAllPosts>(_onFetchPosts);
    on<RefreshPosts>(_onRefreshPosts);
    on<LikedPost>(_onLikePost);
  }

  Future<void> _onFetchPosts(
    FetchAllPosts event,
    Emitter<FeedState> emit,
  ) async {
    emit(LoadingPosts());
    try {
      final posts = await getPostsUseCase();
      if (posts.isNotEmpty) {
        final user = await repository.getCurrentUser();
        currentUserId = user!.id;
        allPosts = posts;
        emit(LoadedPosts(posts: allPosts));
      } else {
        emit(ErrorLoadingPosts(AppValidationMessages.postsNotFound));
      }
    } catch (e) {
      emit(ErrorLoadingPosts(e.toString()));
    }
  }

  Future<void> _onRefreshPosts(
    RefreshPosts event,
    Emitter<FeedState> emit,
  ) async {
    await _onFetchPosts(FetchAllPosts(), emit);
  }

  Future<void> _onLikePost(
    LikedPost event,
    Emitter<FeedState> emit,
  ) async {
    if (currentUserId.isEmpty) return;
    await likePostUsecase(event.post);
    add(RefreshPosts());
  }
}
