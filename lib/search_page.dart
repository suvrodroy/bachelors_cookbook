import 'package:bachelors_cookbook/data_source.dart';
import 'package:flutter/material.dart';
import 'my_widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final DataSource _dataSource = new DataSource();
  String? effectiveSearch;
  int _animationKey = 0;
  List<RecipeItem> foodItems = [];
  final fieldText = TextEditingController();

  get crossAxisCount => null;

  void _updateFoodItems(String? value) {
    setState(() {
      effectiveSearch = value;
      foodItems = _dataSource.getRecipeOfName(name: effectiveSearch);
      _animationKey++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = 180.0; // Minimum card width
        int crossAxisCount = (constraints.maxWidth / cardWidth).floor().clamp(
          1,
          4,
        );

        return Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(height: 64),
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(32),
                          ),
                          filled: true,
                          fillColor: Color(0xFF313131),
                          hintText: "Enter your choice",
                          suffixIcon: IconButton(
                            onPressed: () {
                              fieldText.clear();
                            },
                            icon: Icon(Icons.clear),
                          ),
                        ),
                        onSubmitted: (String value) {
                          _updateFoodItems(value);
                        },
                        controller: fieldText,
                      ),
                    ),
                  ),
                ],
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (child, animation) {
                      return FadeTransition(opacity: animation, child: child);
                    },
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.85, // Same as FoodCard
                      ),
                      key: ValueKey<int>(_animationKey),
                      itemCount: foodItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.all(6),
                          child: FoodCard(foodItem: foodItems[index]),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
