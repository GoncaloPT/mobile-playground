library shared_ui;
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.dart';
export 'app_bar.dart';

@microPackage
class SharedUiModule {
  static void registerModuleDependencies(GetIt get){
    configureInjection();
  }
}