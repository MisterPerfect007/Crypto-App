import 'package:crypto_trends/core/coinPercentage/coin_percentage_format.dart';
import 'package:crypto_trends/ui/colors/colors.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late CoinPercentageFormat format;
  const positive = 12.234;
  const positiveInt = 12;
  const negative = -12.2342;
  const negativeInt = -12;

  group("isPositive", () {
    test('Should return true if percentage is positive', () {
      format = const CoinPercentageFormat(percentage: positive);

      final result = format.isPositive;

      expect(result, true);
    });
    test('Should return false if percentage is negative', () {
      format = const CoinPercentageFormat(percentage: negative);

      final result = format.isPositive;

      expect(result, false);
    });
  });

  group("getColor", () {
    test("Should return mainGreen color if % is positive", () {
      format = const CoinPercentageFormat(percentage: positive);

      final result = format.getColor;

      expect(result, AppColors.mainGreen);
    });

    test("Should return pureRed color if % is negative", () {
      format = const CoinPercentageFormat(percentage: negative);

      final result = format.getColor;

      expect(result, AppColors.pureRed);
    });
  });

  group("fixedPercentage", () {
    test(
        'Should return percentage fixed to 2 when percentage is decimal',
        () {
      format = const CoinPercentageFormat(percentage: positive);
      final result = format.fixedPercentage();

      expect(result, '12.23');
    });

    test(
        'Should return percentage fixed to 2 when percentage is decimal négative ',
        () {
      format = const CoinPercentageFormat(percentage: negative);
      final result = format.fixedPercentage();

      expect(result, '12.23');
    });

    test(
        'Should return percentage fixed to 2 when percentage int positive number',
        () {
      format = CoinPercentageFormat(percentage: positiveInt.toDouble());
      final result = format.fixedPercentage();

      expect(result, '12.00');
    });

    test(
        'Should return a decimal signed (-) percentage fixed to 2 when percentage int negative number',
        () {
      format = CoinPercentageFormat(percentage: negativeInt.toDouble());
      final result = format.fixedPercentage();

      expect(result, '12.00');
    });
  });
}
