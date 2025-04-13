import 'dart:math';

import 'package:bachelors_cookbook/my_widgets.dart';

class RecipeItem {
  final String imagePath;
  final String foodName;
  final double rating;
  final List<String> categories;
  final int recipeId;
  final int requiredTime;

  RecipeItem({
    required this.imagePath,
    required this.foodName,
    required this.rating,
    required this.categories,
    required this.recipeId,
    required this.requiredTime,
  });
}

class RecipeContent {
  List<String> ingredients;
  String steps;
  int recipeId;
  RecipeContent({
    required this.ingredients,
    required this.steps,
    required this.recipeId,
  });
}

class DataSource {
  final List<RecipeItem> _recipeItemData = [
    RecipeItem(
      imagePath: 'assets/images/1305211.png',
      foodName: 'Delicious Burger',
      rating: 4.5,
      categories: ['Lunch'],
      recipeId: 1,
      requiredTime: 30,
    ),
    RecipeItem(
      imagePath: 'assets/images/1305211.png',
      foodName: 'Spicy Pizza',
      rating: 4.0,
      categories: ['Dinner'],
      recipeId: 2,
      requiredTime: 30,
    ),
    RecipeItem(
      imagePath: 'assets/images/1305211.png',
      foodName: 'Fresh Salad',
      rating: 3.8,
      categories: ['Lunch', 'Dinner'],
      recipeId: 3,
      requiredTime: 30,
    ),
    RecipeItem(
      imagePath: 'assets/images/1305211.png',
      foodName: 'Chocolate Cake',
      rating: 4.9,
      categories: ['Snacks'],
      recipeId: 4,
      requiredTime: 30,
    ),
    RecipeItem(
      imagePath: 'assets/images/1305211.png',
      foodName: 'Delicious Burger',
      rating: 4.5,
      categories: ['Lunch'],
      recipeId: 5,
      requiredTime: 30,
    ),
    RecipeItem(
      imagePath: 'assets/images/1305211.png',
      foodName: 'Spicy Pizza',
      rating: 4.0,
      categories: ['Dinner'],
      recipeId: 6,
      requiredTime: 30,
    ),
    RecipeItem(
      imagePath: 'assets/images/1305211.png',
      foodName: 'Fresh Salad',
      rating: 3.8,
      categories: ['Lunch', 'Dinner'],
      recipeId: 7,
      requiredTime: 30,
    ),
    RecipeItem(
      imagePath: 'assets/images/1305211.png',
      foodName: 'Chocolate Cake',
      rating: 4.9,
      categories: ['Snacks'],
      recipeId: 8,
      requiredTime: 30,
    ),
  ];

  final List<RecipeContent> _recipeContentData = [
    RecipeContent(
      recipeId: 1,
      ingredients: ["Bun", "Meat", "Lettuce", "Tomato"], // Now a list
      steps: "1. Take Ground Beef and form it into a ball.\n2. Fry and serve.",
    ),
    RecipeContent(
      recipeId: 2,
      ingredients: [
        "Dough",
        "Tomato Sauce",
        "Cheese",
        "Pepperoni",
      ], // Now a list
      steps:
          "1. Spread tomato sauce on the dough.\n2. Add cheese and toppings.\n3. Bake at 220°C for 15 minutes.",
    ),
    RecipeContent(
      recipeId: 3,
      ingredients: [
        "Lettuce",
        "Tomato",
        "Cucumber",
        "Olive Oil",
        "Vinegar",
      ], // Now a list
      steps:
          "1. Chop lettuce, tomato, and cucumber.\n2. Mix in a bowl.\n3. Drizzle with olive oil and vinegar.",
    ),
    RecipeContent(
      recipeId: 4,
      ingredients: [
        "Flour",
        "Cocoa Powder",
        "Sugar",
        "Eggs",
        "Butter",
      ], // Now a list
      steps:
          "1. Mix flour, cocoa powder, and sugar.\n2. Add eggs and melted butter.\n3. Bake at 180°C for 30 minutes.",
    ),
    RecipeContent(
      recipeId: 5,
      ingredients: ["Bun", "Meat", "Lettuce", "Tomato"], // Now a list
      steps: "1. Take Ground Beef and form it into a ball.\n2. Fry and serve.",
    ),
    RecipeContent(
      recipeId: 6,
      ingredients: [
        "Dough",
        "Tomato Sauce",
        "Cheese",
        "Pepperoni",
      ], // Now a list
      steps:
          "1. Spread tomato sauce on the dough.\n2. Add cheese and toppings.\n3. Bake at 220°C for 15 minutes.",
    ),
    RecipeContent(
      recipeId: 7,
      ingredients: [
        "Lettuce",
        "Tomato",
        "Cucumber",
        "Olive Oil",
        "Vinegar",
      ], // Now a list
      steps:
          "1. Chop lettuce, tomato, and cucumber.\n2. Mix in a bowl.\n3. Drizzle with olive oil and vinegar.",
    ),
    RecipeContent(
      recipeId: 8,
      ingredients: [
        "Flour",
        "Cocoa Powder",
        "Sugar",
        "Eggs",
        "Butter",
      ], // Now a list
      steps:
          "1. Mix flour, cocoa powder, and sugar.\n2. Add eggs and melted butter.\n3. Bake at 180°C for 30 minutes.",
    ),
  ];

  List<RecipeItem> getRecipeOfCategory({String? category}) {
    return _recipeItemData.where((item) {
      if (category != null) {
        return item.categories
            .map((c) => c.toLowerCase())
            .contains(category.toLowerCase());
      }
      return true;
    }).toList();
  }

  List<RecipeItem> getRecipeOfName({String? name}) {
    if (name == null || name.isEmpty) {
      return [];
    }
    return _recipeItemData
        .where(
          (item) => item.foodName.toLowerCase().contains(name.toLowerCase()),
        )
        .toList();
  }

  List<RecipeItem> getRecipeByIngredients({List<Ingredient>? ingredients}) {
    if (ingredients == null || ingredients.isEmpty) {
      return [];
    }
    final recipeIds =
        _recipeContentData
            .where(
              (content) => ingredients.every(
                (ingredient) => content.ingredients.any(
                  (recipeIngredient) => recipeIngredient.toLowerCase().contains(
                    ingredient.name?.toLowerCase() ?? "",
                  ),
                ),
              ),
            )
            .map((content) => content.recipeId)
            .toList();
    return _recipeItemData
        .where((item) => recipeIds.contains(item.recipeId))
        .toList();
  }

  RecipeItem getRandomItem() {
    return _recipeItemData[Random().nextInt(_recipeItemData.length)];
  }

  RecipeItem getItemFromId(int id) {
    return _recipeItemData.singleWhere((item) => item.recipeId == id);
  }

  RecipeContent getContentFromId(int id) {
    return _recipeContentData.singleWhere((item) => item.recipeId == id);
  }
}
