import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier()
      : super([]); // we can't add or remove element form this passed list

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);
    if (mealIsFavorite) {
      //to remove meal form favorite_list
      state = state
          .where((element) => element.id != meal.id)
          .toList(); //^ by '.where()' we  filtered a list and get new list
      return false;
    } else {
      //to add meal to favorite_list
      state = [
        ...state,
        meal
      ]; //^  create new list , pulling-out all elemnt of previous state(list) and adding new_meal (meal)

      return true;
    }
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) {
    return FavoriteMealsNotifier();
  },
);
