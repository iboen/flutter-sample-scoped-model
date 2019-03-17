import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:http/http.dart' as http;
import 'meal.dart';
import 'favorites.dart';
import 'cart_model.dart';
import 'dart:convert';

void main() {
  final cart = CartModel();

  runApp(ScopedModel(model: cart, child: MyApp()));
}

Future<Meals> _fetchMeals() async {
  var query1;
  final response =
      await http.get('https://www.themealdb.com/api/json/v1/1/search.php');

  if (response.statusCode == 200) {
    // If server returns an OK response, parse the JSON
    return Meals.fromJson(json.decode(response.body));
  } else {
    // If that response was not OK, throw an error.
    throw Exception('Failed to load post');
  }
}

Widget _buildList(List<Meal> meals) {
  return ListView.builder(
      itemCount: meals.length,
      itemBuilder: (context, index) {
        return _buildListItem(context, meals[index]);
      });
}

Widget _buildListItem(context, Meal meal) {
  return ListTile(
      title: Text(meal.strMeal),
      trailing: IconButton(
          icon: Icon(Icons.favorite_border),
          onPressed: () {
            ScopedModel.of<CartModel>(context).add(meal);
            // TODO ubah icon kalau sudah difav
          }),
      leading: Image.network(meal.strMealThumb, width: 48, height: 48));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue, brightness: Brightness.dark),
      home: RecipesPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class RecipesPage extends StatefulWidget {
  RecipesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return new _RecipesState();
  }
}

class _RecipesState extends State<RecipesPage> {
  Future<Meals> meals;

  @override
  void initState() {
    super.initState();
    meals = _fetchMeals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: const Text('Welcome to Flutter'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.bookmark),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Favorites()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: FutureBuilder<Meals>(
          future: meals,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return _buildList(snapshot.data.meals);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
