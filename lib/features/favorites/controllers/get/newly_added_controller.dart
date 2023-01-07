import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:get/get.dart';

class FavoriteNewlyAddedController extends GetxController {
  RxList favorites = [].obs;
  add(Coin coin) {
    if (!favorites.contains(coin)) {
      favorites.add(coin);
    }
  }
}
