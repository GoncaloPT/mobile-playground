import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';
import 'package:movies/movies.dart';
import 'package:shared_ui/shared_ui.dart';

final getIt = GetIt.instance;
@MicroPackageRootInit(
  generateForDir: ['lib'],
  asExtension: false
)
void configureInjection(Environments environment) {
    $initGetIt(getIt,environment: environment.toString());
    // Register all the micropackages


}
enum Environments{
  development,
  production
}



