import 'package:get/get.dart';

class FavoriteController extends GetxController {
  RxList<String> favorites = ["notLoaded"].obs;
  updateFavorite(List<String> favoriteList) => favorites.value = favoriteList;
}
