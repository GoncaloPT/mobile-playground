import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';



final getIt = GetIt.instance;
@InjectableInit(
  generateForDir: ['lib','features/movies/lib'],
  initializerName: 'registerMoviesModuleDependencies',
  asExtension: true
)
/// for local ( internal library dependency injection
void configureInjection() {
  getIt.registerMoviesModuleDependencies();
}


