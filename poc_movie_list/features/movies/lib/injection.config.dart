// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:shared_ui/shared_ui.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'src/presentation/screen/favorite_movies.dart';
import 'src/presentation/widgets/main_tab_bar.dart';
import 'src/presentation/screen/movie_search.dart';
import 'src/domain/services/movie_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

extension GetItInjectableX on GetIt {
  GetIt registerMoviesModuleDependencies({
    String environment,
    EnvironmentFilter environmentFilter,
  }) {
    final gh = GetItHelper(this, environment, environmentFilter);
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
    return this;
  }
}
