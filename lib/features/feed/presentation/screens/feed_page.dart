import 'package:devgram/core/constants/strings/app_strings.dart';
import 'package:devgram/core/constants/strings/validation_messages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/common_widgets/button_widgets.dart';
import '../../../../core/common_widgets/fab_widget.dart';
import '../../../../core/common_widgets/parent_widget.dart';
import '../../../../core/common_widgets/post_card_widget.dart';
import '../../../../core/common_widgets/text_widget.dart';
import '../../domain/entities/post_entity.dart';
import '../bloc/feed_bloc.dart';

class FeedScreen extends StatefulWidget {
  final bool refresh;

  const FeedScreen({Key? key, this.refresh = false}) : super(key: key);

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  late FeedBloc feedBloc;

  @override
  void initState() {
    feedBloc = BlocProvider.of<FeedBloc>(context);
    feedBloc.add(FetchAllPosts());
    super.initState();
  }

  @override
  void didUpdateWidget(FeedScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.refresh) {
      feedBloc.add(RefreshPosts());
    }
  }

  refreshPosts() {
    feedBloc.add(FetchAllPosts());
  }

  @override
  Widget build(BuildContext context) {
    return ParentWidget(
      context: context,
      childWidget: postsListWidget(),
      hasHeader: true,
      appbarTitle: AppStrings.feedScreenTitle,
      floatingActionButton: FABWidget.getFAB(context),
    );
  }

  Widget postsListWidget() {
    return BlocBuilder<FeedBloc, FeedState>(builder: (context, state) {
      if (state is LoadingPosts) {
        return Center(child: CircularProgressIndicator());
      } else if (state is LoadedPosts) {
        return _buildPostsList(state.posts);
      } else if (state is ErrorLoadingPosts) {
        return Center(child: Text(state.error));
      } else {
        return NoDataWidget();
      }
    });
  }

  _buildPostsList(List<PostEntity> posts) {
    return RefreshIndicator(
      onRefresh: () async {
        feedBloc.add(RefreshPosts());
        return;
      },
      child: posts.isEmpty
          ? NoDataWidget()
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onDoubleTap: () async {
                    feedBloc.add(LikedPost(posts[index]));
                  },
                  child: PostCard(
                      post: posts[index],
                      currentUserId: feedBloc.currentUserId),
                );
              },
            ),
    );
  }

  Widget NoDataWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 20,
        children: [
          TextWidget(text: AppValidationMessages.postsNotFound),
          ButtonWidgets.elevatedButton(AppStrings.refresh, refreshPosts,
              width: 120)
        ],
      ),
    );
  }
}
