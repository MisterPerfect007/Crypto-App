part of '../../injection_container.dart';

Future<void> initSearchCoin() async {
  //!Presenter
  //*Bloc
  sl.registerFactory(() => SearchCoinBloc(network: sl(), getSearchCoin: sl()));

  //!domain
  //*usecase
  sl.registerLazySingleton(() => GetSearchCoin(sl()));

  sl.registerLazySingleton<SearchCoinRepository>(
      () => SearchCoinRepositoryImpl(sl()));

  //!data
  sl.registerLazySingleton<SearchItemDataSource>(
    () => SearchItemDataSourceImpl(client: sl()));
}