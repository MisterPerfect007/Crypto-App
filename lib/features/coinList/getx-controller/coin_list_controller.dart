import 'package:crypto_trends/features/coinList/domain/entities/coin.dart';
import 'package:get/get.dart';

class CoinListController extends GetxController{
  RxList coinList = [].obs;
  updateCoinList(List<Coin> newList) => coinList.value = newList;
}
