import 'package:crypto_trends/features/coinInfo/presenter/utils/functions.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Should return '??' when price is null", () {
    final result = customFormater(null);
    expect(result, "??");
  });

  test("Should return '0.0' when price is 0.0", () {
    final result = customFormater(0);
    expect(result, "0.0");
  });

  test("Should return result up to 2 floating when price > 1", () {
    final result = customFormater(1.28912);
    expect(result, "1.28912");
  });
  test("Should return result up to 6 floating when price > 0.001", () {
    final result = customFormater(0.01);
    expect(result, "0.01");
  });
  test("Should return result up to 15 floating when price > 0.000000000000001",
      () {
    final result = customFormater(0.000000000001);
    expect(result, "0.000000000001");
  });
  test("Should return result up to 20 floating when price < 0.000000000000001",
      () {
    final result = customFormater(0.000000000000000001);
    expect(result, "0.000000000000000001");
  });
}
