import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widget/main_drawer.dart';

import 'package:meals/providers/meals_provider.dart';
import 'package:meals/providers/favorites_provider.dart';

const kinitialFilters = {
  // using map (keys)
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectPageIndex = 0;

  Map<Filter, bool> _selectedfilters = kinitialFilters;

  void _setPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  void _setScreen(String identifire) async {
    Navigator.of(context).pop();

    if (identifire == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedfilters,
          ),
        ),
      );
      setState(() {
        _selectedfilters = result ?? kinitialFilters;
      }); //^    by "??" if result is null then kinitialFilters
    } //^    will be assingd to _selectedfilters
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsprovider);

    final availableMeals = meals.where((meal) {
      if (_selectedfilters[Filter.glutenFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_selectedfilters[Filter.lactoseFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_selectedfilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (_selectedfilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = "Catogries";

    // '0' for category screen,  '1' for fav screen
    if (_selectPageIndex == 1) {
      // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
      final favoriteMeals = ref.watch(favoriteMealsProvider);
      activePage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _setPage,
        currentIndex: _selectPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "favorits"),
        ],
      ),
    );
  }
}
