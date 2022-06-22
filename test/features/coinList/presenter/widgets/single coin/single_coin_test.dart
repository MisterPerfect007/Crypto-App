import 'package:crypto_trends/features/coinList/presenter/utils/utils_functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("Should caculate and return the right pourcentage", (){
    final result1 = calculate7DPercentage([1,2]);
    final result2 = calculate7DPercentage([12,2,11.9122]);
    final result3 = calculate7DPercentage([100,00.1,101.12]);
    final result4 = calculate7DPercentage([10,00.1,9]);

    expect(result1, 100);
    expect(result2, -0.73167);
    expect(result3, 1.12);
    expect(result4, -10);
  });

  test("Should return null if argument is not a list or an empty", (){
    final result1 = calculate7DPercentage([]);
    final result2 = calculate7DPercentage(null);

    expect(result1, null);
    expect(result2, null);
  });
}