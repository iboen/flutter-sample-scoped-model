class Meals {
  final List<Meal> meals;

  Meals({this.meals});

  factory Meals.fromJson(Map<String, dynamic> json) {
    var list = json["meals"] as List;

    List<Meal> listMeals = list.map((i) => Meal.fromJson(i)).toList();

    return Meals(meals: listMeals);
  }
}

class Meal {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  Meal({this.idMeal, this.strMeal, this.strMealThumb});

  factory Meal.fromJson(Map<String, dynamic> json) {
    return Meal(
        idMeal: json["idMeal"],
        strMeal: json["strMeal"],
        strMealThumb: json["strMealThumb"]);
  }
}
