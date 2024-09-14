import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/data/dummy_data.dart';

final mealsprovider = Provider(
  //    we create provide like this ONLY when is //! STATIC data
  (ref) {
    //   otherwise (see example in favorites_provider.dart file )
    return dummyMeals;
  },
);
