import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../core/constants/app_colors.dart';
import '../core/constants/strings/app_strings.dart';
import '../core/di/injection_container.dart';
import 'feed/presentation/screens/feed_page.dart';
import 'profile/presentation/screens/profile_page.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    BlocProvider(
      create: (context) => InjectionContainer.getFeedBloc(),
      child: FeedScreen(),
    ),
    BlocProvider(
      create: (context) => InjectionContainer.getProfileBloc(),
      child: ProfileScreen(),
    ),
  ];

  Widget _buildCurrentScreen() {
    final extra = GoRouterState.of(context).extra;
    if (extra is Map && extra[AppStrings.refreshFeed] == true) {
      _screens[0] = BlocProvider(
        create: (context) => InjectionContainer.getFeedBloc(),
        child: FeedScreen(refresh: true),
      );
    }
    return _screens[_selectedIndex];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentScreen(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (value) => _onItemTapped(value),
        selectedItemColor: AppColors.primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dynamic_feed),
            label: AppStrings.feedScreenTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppStrings.profileScreenTitle,
          ),
        ],
      ),
    );
  }
}
