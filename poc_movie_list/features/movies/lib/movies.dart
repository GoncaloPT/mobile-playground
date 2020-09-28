library movies;

import 'package:get_it/get_it.dart';
import 'package:movies/injection.dart';
import 'package:injectable/injectable.dart';
export 'src/presentation/screen/favorite_movies.dart';
export 'src/presentation/screen/movie_search.dart';
export 'src/presentation/widgets/main_tab_bar.dart';
export 'src/domain/services/movie_service.dart';


@microPackage
class MoviesModule{
  static void registerModuleDependencies(GetIt get){
    configureInjection();
  }
}