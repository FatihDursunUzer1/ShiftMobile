import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator=GetIt.I;

void setupLocator()
{
  //locator.registerLazySingleton(() => Changer());
  locator.registerLazySingleton(() async => await SharedPreferences.getInstance());
}