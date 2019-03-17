import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'cart_model.dart';
import 'list_item.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Favorites Meals'),
      ),
      body: Center(child: _buildList()),
    );
  }

  Widget _buildList() {
    return ScopedModelDescendant<CartModel>(builder: (context, child, cart) {
      return ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            // masukkan info dari ScopedModel
            return RecipeItem(meal: cart.items[index]);
          });
    });
  }
}
