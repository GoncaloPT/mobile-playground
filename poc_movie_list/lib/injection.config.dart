// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'utils/app-bar.dart';
import 'features/movies/presentation/screen/favorite_movies.dart';
import 'features/movies/presentation/widgets/main_tab_bar.dart';
import 'features/movies/presentation/screen/movie_search.dart';
import 'features/movies/domain/services/movie_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<AppBarFactory>(() => AppBarFactory());
  gh.factory<MovieSearch>(
      () => MovieSearch(get<MovieService>(), get<AppBarFactory>()));
  gh.factory<FavoriteMovies>(() => FavoriteMovies(
        get<AppBarFactory>(),
        get<MovieService>(),
        get<MovieSearch>(),
      ));
  gh.factory<MainTabBar>(
      () => MainTabBar(get<FavoriteMovies>(), get<MovieSearch>()));

  // Eager singletons must be registered in the right order
  gh.singleton<MovieService>(MovieService());
  return get;
}
