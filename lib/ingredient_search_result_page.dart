import 'package:bachelors_cookbook/data_source.dart';
import 'package:flutter/material.dart';
import 'my_widgets.dart';

class IngredientSearchResultPage extends StatelessWidget {
  IngredientSearchResultPage({super.key, required this.selectedIngredients}) {
    foodItems = DataSource().getRecipeByIngredients(
      ingredients: selectedIngredients,
    );
  }
  List<Ingredient>? selectedIngredients;

  List<RecipeItem> foodItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double cardWidth = 180.0; // Minimum card width
          int crossAxisCount = (constraints.maxWidth / cardWidth).floor().clamp(
            1,
            4,
          );

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(height: 16),
                SizedBox(child: BackButton(style: ButtonStyle())),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 8.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.85, // Same as FoodCard
                    ),
                    itemCount: foodItems.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(6),
                        child: FoodCard(foodItem: foodItems[index]),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
