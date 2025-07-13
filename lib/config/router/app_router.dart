import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/constants/path_constants.dart';
import '../../core/constants/strings/app_strings.dart';
import '../../core/di/injection_container.dart';
import '../../features/auth/presentation/screens/login_page.dart';
import '../../features/auth/presentation/screens/signup_page.dart';
import '../../features/dashboard.dart';
import '../../features/feed/presentation/screens/feed_page.dart';
import '../../features/post/presentation/screens/create_post.dart';
import '../../features/profile/presentation/screens/profile_page.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: PathConstants.loginScreen,
  routes: [
    GoRoute(
      path: PathConstants.loginScreen,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: PathConstants.signUpScreen,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: PathConstants.dashboardScreen,
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: PathConstants.feedScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => InjectionContainer.getFeedBloc(),
        child: FeedScreen(),
      ),
    ),
    GoRoute(
      path: PathConstants.profileScreen,
      builder: (context, state) => BlocProvider(
        create: (context) => InjectionContainer.getProfileBloc(),
        child: ProfileScreen(),
      ),
    ),
    GoRoute(
        path: PathConstants.createPostScreen,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => InjectionContainer.getCreatePostBloc(),
            child: CreatePostScreen(
              sourceScreen: state.extra as String? ?? AppStrings.feed,
            ),
          );
        }),
  ],
);
