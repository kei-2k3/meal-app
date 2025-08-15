import 'package:flutter/material.dart';
import 'package:meal_app/model/meal.dart';
import 'package:meal_app/screens/categories_screen.dart';
import 'package:meal_app/screens/meals_screen.dart';
import 'package:meal_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      _showInfoMessage('Marked as a favorite.');
    }
  }

  void _selectedScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
    );
    var activeScreenTitle = 'Categories';

    if (_selectedScreenIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activeScreenTitle = 'Your Favorites';
    }
    return Scaffold(
      appBar: AppBar(title: Text(activeScreenTitle)),
      drawer: const MainDrawer(),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedScreen,
        currentIndex: _selectedScreenIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Category',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
