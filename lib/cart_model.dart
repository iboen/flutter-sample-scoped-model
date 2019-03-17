import 'package:scoped_model/scoped_model.dart';
import 'dart:collection';
import 'meal.dart';

class CartModel extends Model {
  /// Internal, private state of the cart.
  final List<Meal> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Meal> get items => UnmodifiableListView(_items);

  /// The current total price of all items (assuming all items cost $1).
  int get totalPrice => _items.length;

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Meal item) {
    _items.add(item);
    // This call tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }
}