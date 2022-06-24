import 'package:crypto_trends/features/coinList/presenter/utils/utils_functions.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'utils_functions_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  group("calculate7DPercentage", () {
    test("Should caculate and return the right pourcentage", () {
      final result1 = calculate7DPercentage([1, 2]);
      final result2 = calculate7DPercentage([12, 2, 11.9122]);
      final result3 = calculate7DPercentage([100, 00.1, 101.12]);
      final result4 = calculate7DPercentage([10, 00.1, 9]);

      expect(result1, 100);
      expect(result2, -0.73167);
      expect(result3, 1.12);
      expect(result4, -10);
    });

    test("Should return null if argument is not a list or an empty", () {
      final result1 = calculate7DPercentage([]);
      final result2 = calculate7DPercentage(null);

      expect(result1, null);
      expect(result2, null);
    });
  });

  group("isNewPriceUp", (){
    late MockSharedPreferences prefs;
    setUp((){
      prefs = MockSharedPreferences();
    });
    test("Should return null when newPrice is null", (){
      when(prefs.getDouble(any)).thenReturn(1);

      final result = isNewPriceUp(id: 'id', prefs: prefs);

      expect(result, null);
    });
    test("Should return null when there is not oldPrice", (){
      when(prefs.getDouble(any)).thenReturn(null);
      when(prefs.setDouble(any, any)).thenAnswer((_) async => true);

      final result = isNewPriceUp(id: 'id', prefs: prefs, newPrice: 1);

      expect(result, null);
    });
    test("Should return false when oldPrice > newPrice", (){
      when(prefs.getDouble(any)).thenReturn(2.2);
      when(prefs.setDouble(any, any)).thenAnswer((_) async => true);

      final result = isNewPriceUp(id: 'id', prefs: prefs, newPrice: 1);

      expect(result, false);
    });
    test("Should return null when oldPrice == newPrice", (){
      when(prefs.getDouble(any)).thenReturn(1);
      when(prefs.setDouble(any, any)).thenAnswer((_) async => true);

      final result = isNewPriceUp(id: 'id', prefs: prefs, newPrice: 1);

      expect(result, null);
    });
    test("Should return true when oldPrice < newPrice", (){
      when(prefs.getDouble(any)).thenReturn(0.000000001);
      when(prefs.setDouble(any, any)).thenAnswer((_) async => true);

      final result = isNewPriceUp(id: 'id', prefs: prefs, newPrice: 1);

      expect(result, true);
    });
  });
}
