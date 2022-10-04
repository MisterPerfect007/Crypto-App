part of '../../injection_container.dart';

Future<void> initSettings() async {


    //!data
    sl.registerLazySingleton(
      () async => LocalStorageKeyValue(await SharedPreferences.getInstance()));
}