import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/models/meal.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  // ignore: unused_element
  void _toggleMealFavoritsStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      _favoriteMeals.remove(meal);
    } else {
      _favoriteMeals.add(meal);
    }
  }

  void _setPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage =  CategoriesScreen(onToggleFavorite: _toggleMealFavoritsStatus,);
    var activePageTitle = "Catogries";

    // '0' for category screen,  '1' for fav screen
    if (_selectPageIndex == 1) {
      // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
      activePage =  MealsScreen(meals: _favoriteMeals ,onToggleFavorite: _toggleMealFavoritsStatus,);
      activePageTitle = "Your Favorites";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
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
