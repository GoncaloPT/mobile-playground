// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'injection.injection.micropackage.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  MicroPackagesConfig.registerMicroModules(get);
  return get;
}
