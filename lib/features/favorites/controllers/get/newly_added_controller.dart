import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:get/get.dart';

class FavoriteNewlyAddedController extends GetxController {
  RxList favorites = [].obs;
  add(Coin coin) {
    if (!favorites.map((e) => e.id).toList().contains(coin.id)) {
      favorites.add(coin);
    }
  }
}
