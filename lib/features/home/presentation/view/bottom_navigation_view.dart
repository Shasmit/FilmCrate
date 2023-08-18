import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:filmcrate/config/constants/app_color_theme.dart';
import 'package:filmcrate/features/movies/presentation/view/movie_screen.dart';
import 'package:filmcrate/features/profile/presentation/view/profile_view.dart';
import 'package:filmcrate/features/search/presentation/view/search_screen.dart';
import 'package:filmcrate/features/watchlist/presentation/view/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../profile/presentation/viewmodel/profile_view_model.dart';
import '../../../watchlist/presentation/viewmodel/watchlist_view_model.dart';

class BottomNavView extends ConsumerStatefulWidget {
  const BottomNavView({super.key});

  @override
  ConsumerState<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends ConsumerState<BottomNavView> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(profileViewModelProvider.notifier).getUserProfile();
      ref.read(watchListViewModelProvider.notifier).getWatchList();
    });
    super.initState();
  }

  int index = 0;
  final screens = [
    const MovieScreen(),
    const SearchScreen(),
    const WatchListScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.movie_filter, size: 30),
      const Icon(Icons.search, size: 30),
      const Icon(Icons.bookmark, size: 30),
      const Icon(Icons.person_2, size: 30)
    ];
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(
            color: AppColors.navbarbackColors,
          ),
        ),
        child: CurvedNavigationBar(
          key: navigationKey,
          color: AppColors.navbarbodyColors,
          buttonBackgroundColor: AppColors.navbarbodyColors,
          backgroundColor: Colors.transparent,
          height: 60,
          index: index,
          items: items,
          onTap: (index) => setState(() => this.index = index),
        ),
      ),
    );
  }
}
