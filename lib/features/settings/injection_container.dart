part of '../../injection_container.dart';

Future<void> initSettings() async {
  sl.registerFactory(() => LocalStorageKeyValue(sl()));
}
