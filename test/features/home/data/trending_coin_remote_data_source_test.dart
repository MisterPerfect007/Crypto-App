import 'package:crypto_trends/features/home/data/trending_coin_remote_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'trending_coin_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main(){
  late MockClient client;
  late TrendingCoinRemoteDataSource dataSource;
  setUp((){
    client = MockClient();
    dataSource = TrendingCoinRemoteDataSource(client: client);
  });

  test("call to the API with correct Uri and headers", (){
    when(client.get(any, headers: anyNamed("headers"))).thenAnswer((_) async => http.Response("{}", 200));
  });
}