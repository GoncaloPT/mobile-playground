import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:poc_movie_list/features/movies/presentation/screen/favorite_movies.dart';
import 'package:poc_movie_list/features/movies/presentation/screen/movie_search.dart';

@injectable
class MainTabBar extends StatefulWidget {
  final FavoriteMovies _favoriteMovies;
  final MovieSearch _movieSearch;

  MainTabBar(this._favoriteMovies, this._movieSearch);

  @override
  State<StatefulWidget> createState() =>
      _MainTabBarState(this._favoriteMovies, this._movieSearch);
}

class _MainTabBarState extends State<MainTabBar> with TickerProviderStateMixin {
  List<Widget> _widgets;

  int _selectedIndex = 0;

  // page controller - to handle animations
  TabController _pageController;
  final FavoriteMovies _favoriteMovies;
  final MovieSearch _movieSearch;

  _MainTabBarState(this._favoriteMovies, this._movieSearch);

  /// On tabs bar item tap
  void _onItemTapped(int index) {
    _pageController.animateTo(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _widgets = <Widget>[_favoriteMovies, _movieSearch];
    _pageController = TabController(vsync: this, length: 2);
    _pageController.addListener(() {
      /// Listener for swipe page change
      setState(() {
        _selectedIndex = _pageController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), title: Text('Favorites')),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('Search')),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).accentColor,
          onTap: _onItemTapped,
        ),
        body: TabBarView(
          children: _widgets,
          controller: _pageController,
        ),
      ),
    );
  }
}
