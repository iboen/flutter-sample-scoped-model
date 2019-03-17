import 'package:flutter/material.dart';
import 'meal.dart';

class RecipeItem extends StatelessWidget {
  Meal meal;

  RecipeItem({this.meal});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(meal.strMeal),
      leading: Image.network(
        meal.strMealThumb,
        width: 48,
        height: 48,
      ),
    );
  }
}
