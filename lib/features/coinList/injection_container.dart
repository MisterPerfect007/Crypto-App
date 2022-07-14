// import 'package:crypto_trends/features/coinList/data/repository/get_coin_list_repository_implementation.dart';
// import 'package:crypto_trends/features/coinList/presenter/bloc/coin_list_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
// import 'package:internet_connection_checker/internet_connection_checker.dart';

// import '../../core/network/network_info.dart';
// import 'data/datasources/coin_list_remote_data_source.dart';
// import 'domain/repositories/get_coin_list_repository.dart';
// import 'domain/usecases/get_coin_list.dart';

// // final GetIt sl = GetIt.instance;

// Future<void> initCoinList(GetIt sl) async {
//   //!Presenter
//   //*Bloc
//   sl.registerFactory(() => CoinListBloc(getRemoteCoinList: sl(), network: sl()));

//   //!domain
//   //*usecase
//   sl.registerLazySingleton(() => GetRemoteCoinList(repository: sl()));

//   sl.registerLazySingleton<CoinListRepository>(
//       () => CoinListRepositoryImpl(remote: sl()));

//   //!data
//   sl.registerLazySingleton<CoinListRemoteDataSource>(
//     () => CoinListRemoteDataSourceImpl(client: sl()));

//   //!External
//   sl.registerLazySingleton(() => http.Client());
//   sl.registerLazySingleton(() => NetworkInfoImpl(internetConnectionChecker: InternetConnectionChecker()));
// }