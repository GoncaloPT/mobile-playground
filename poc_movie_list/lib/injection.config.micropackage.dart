// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableMicroPackagesGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:shared_ui/shared_ui.dart';
import 'package:movies/movies.dart';

class MicroPackagesConfig {
  static registerMicroModules(_i1.GetIt getIt) {
    SharedUiModule.registerModuleDependencies(getIt);
    MoviesModule.registerModuleDependencies(getIt);
  }
}
