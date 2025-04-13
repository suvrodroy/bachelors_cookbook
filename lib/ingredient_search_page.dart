import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';
import 'ingredient_search_result_page.dart';
import 'my_widgets.dart';

List<Ingredient> ingredientList = [
  Ingredient(name: "Flour"),
  Ingredient(name: "Sugar"),
  Ingredient(name: "Eggs"),
  Ingredient(name: "Milk"),
  Ingredient(name: "Butter"),
  Ingredient(name: "Salt"),
  Ingredient(name: "Pepper"),
  Ingredient(name: "Garlic"),
  Ingredient(name: "Onion"),
  Ingredient(name: "Tomatoes"),
  Ingredient(name: "Chicken"),
  Ingredient(name: "Beef"),
  Ingredient(name: "Vegetable Oil"),
  Ingredient(name: "Olive Oil"),
  Ingredient(name: "Soy Sauce"),
  Ingredient(name: "Rice"),
  Ingredient(name: "Pasta"),
  Ingredient(name: "Cheese"),
  Ingredient(name: "Carrots"),
  Ingredient(name: "Potatoes"),
  // Add more ingredients as needed
];

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key, this.initialSelectedIngredientList})
    : super(key: key);
  final List<Ingredient>? initialSelectedIngredientList;

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  List<Ingredient>? _selectedIngredientList;

  @override
  void initState() {
    super.initState();
    _selectedIngredientList = widget.initialSelectedIngredientList ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 32),
        Expanded(
          child: FilterListWidget<Ingredient>(
            themeData: FilterListThemeData.dark(context),
            listData: ingredientList,
            selectedListData: _selectedIngredientList,
            onApplyButtonClick: (list) {
              setState(() {
                _selectedIngredientList = list;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => IngredientSearchResultPage(
                          selectedIngredients: list,
                        ),
                  ),
                );
              });
              // You might also want to navigate back or perform other actions here
            },
            choiceChipLabel: (item) {
              return item?.name ?? "";
            },

            validateSelectedItem: (list, val) {
              return list?.contains(val) ?? false;
            },
            onItemSearch: (ingredient, query) {
              return (ingredient.name?.toLowerCase() ?? "").contains(
                query.toLowerCase(),
              );
            },
          ),
        ),
        SizedBox(height: 64),
      ],
    );
  }
}
