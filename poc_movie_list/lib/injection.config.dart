// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'injection.config.micropackage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

extension GetItInjectableX on GetIt {
  GetIt $initGetIt({
    String environment,
    EnvironmentFilter environmentFilter,
  }) {
    final gh = GetItHelper(this, environment, environmentFilter);
    MicroPackagesConfig.registerMicroModules(this);
    return this;
  }
}
