import 'package:crypto_trends/features/coinList/presenter/utils/utils_functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("Should caculate and return the right pourcentage", (){
    final result1 = calculate7DPercentage([1,2]);
    final result2 = calculate7DPercentage([1,2,1]);
    final result3 = calculate7DPercentage([0.001,00.1,0.0111]);
    final result4 = calculate7DPercentage([10,00.1,9]);

    expect(result1, 100);
    expect(result2, 0);
    expect(result3, 1010);
    expect(result4, -10);
  });
}