// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableMicroPackagesGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:movies/movies.dart';
import 'package:shared_ui/shared_ui.dart';

class MicroPackagesConfig {
  static registerMicroModules(_i1.GetIt getIt) {
    MoviesModule.registerModuleDependencies(getIt);
    SharedUiModule.registerModuleDependencies(getIt);
  }
}
