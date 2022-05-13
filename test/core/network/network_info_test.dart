import 'package:crypto_trends/core/network/network_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late MockInternetConnectionChecker internetConnectionChecker;
  late NetworkInfoImpl networkInfoImpl;
  setUp(() {
    internetConnectionChecker = MockInternetConnectionChecker();
    networkInfoImpl =
        NetworkInfoImpl(internetConnectionChecker: internetConnectionChecker);
  });

  test("Should call the hasConnection getter", () async {
    when(internetConnectionChecker.hasConnection).thenAnswer((_) async => true);

    await networkInfoImpl.isConnected;

    verify(internetConnectionChecker.hasConnection).called(1);
  });
  test("Should return true when there is internet connection", () async {
    when(internetConnectionChecker.hasConnection).thenAnswer((_) async => true);

    final result = await networkInfoImpl.isConnected;

    expect(result, true);
  });

  test("Should return false when there is no internet connection", () async {
    when(internetConnectionChecker.hasConnection).thenAnswer((_) async => false);

    final result = await networkInfoImpl.isConnected;

    expect(result, false);
  });
}
