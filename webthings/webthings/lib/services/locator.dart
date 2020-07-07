import "package:get_it/get_it.dart";
import 'package:webthings/services/local_storage.dart';
GetIt locator = GetIt.instance;

Future<void> setupLocator() async {
  var instance = await LocalStorageService.getInstance();
  locator.registerSingleton<LocalStorageService>(instance);
}