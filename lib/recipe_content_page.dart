import 'package:bachelors_cookbook/data_source.dart';
import 'package:flutter/material.dart';
import 'my_widgets.dart';

class RecipeContentPage extends StatelessWidget {
  final DataSource _dataSource = DataSource();
  final int recipeId;

  RecipeContentPage({required this.recipeId, super.key});

  RecipeItem get recipeItem => _dataSource.getItemFromId(recipeId);

  RecipeContent get recipeContent => _dataSource.getContentFromId(recipeId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.all(16),
                child: FoodCard(foodItem: recipeItem, aspectRatio: 1),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 8,
                  top: 8,
                ),
                child: Material(
                  color: const Color(0xFF313131),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Recipe Ingredients:"),
                        SizedBox(height: 8),
                        Text(
                          recipeContent.ingredients.reduce(
                            (value, element) => value + ', ' + element,
                          ),
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  bottom: 8,
                  top: 8,
                ),
                child: Material(
                  color: const Color(0xFF313131),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Recipe Steps:"),
                        SizedBox(height: 8),
                        Text(
                          recipeContent.steps,
                          style: const TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 64),
            ],
          ),
          SafeArea(
            child: Positioned(
              top: 16.0,
              left: 16.0,
              child: Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: Colors.white54.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: BackButton(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
