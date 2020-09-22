import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:poc_movie_list/injection.config.dart';

final getIt = GetIt.instance;
@injectableInit
void configureInjection(Environments environment) => $initGetIt(getIt,environment: environment.toString());


enum Environments{
  DEVELOPMENT,
  PRODUCTION
}
