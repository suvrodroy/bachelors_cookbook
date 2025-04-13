import 'package:bachelors_cookbook/data_source.dart';
import 'package:flutter/material.dart';
import 'my_widgets.dart';

class AllItemsPage extends StatefulWidget {
  const AllItemsPage({super.key, this.initialCategory});

  final String? initialCategory;

  @override
  State<AllItemsPage> createState() => _AllItemsPageState();
}

class _AllItemsPageState extends State<AllItemsPage> {
  String? selectedCategory;
  final DataSource _dataSource = DataSource();

  @override
  void initState() {
    selectedCategory = widget.initialCategory;
    super.initState();
  }

  List<RecipeItem> get foodItems =>
      _dataSource.getRecipeOfCategory(category: selectedCategory);

  // const AllItemsPage({Key? key, required this.foodItems}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Color(0xFF212121),
      //   title: Text('app bar'),
      // ),
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
                MealCategorySelector(
                  selectedCategory: selectedCategory,
                  onCategorySelect: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),
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

class MealCategorySelector extends StatefulWidget {
  const MealCategorySelector({
    super.key,
    this.showAll = true,
    this.selectedCategory,
    required this.onCategorySelect,
  });

  final ValueChanged<String?> onCategorySelect;
  final String? selectedCategory;
  final bool showAll;

  @override
  _MealCategorySelectorState createState() => _MealCategorySelectorState();
}

class _MealCategorySelectorState extends State<MealCategorySelector> {
  final List<String> _categories = ['Breakfast', 'Lunch', 'Dinner', 'Snacks'];

  @override
  Widget build(BuildContext context) {
    List<String> effectiveCategories = _categories;
    if (widget.showAll) {
      effectiveCategories.add('All');
    }

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(effectiveCategories.length, (index) {
            return TextButton(
              onPressed: () {
                setState(() {
                  if (effectiveCategories[index] == 'All') {
                    widget.onCategorySelect(null);
                  } else {
                    widget.onCategorySelect(effectiveCategories[index]);
                  }
                });
              },
              style: ButtonStyle(
                foregroundColor: WidgetStateProperty.resolveWith<Color>((
                  Set<WidgetState> states,
                ) {
                  if (effectiveCategories[index] == widget.selectedCategory ||
                      (effectiveCategories[index] == 'All' &&
                          widget.selectedCategory == null)) {
                    return Color(0xFFff9100); // White when pressed
                  }
                  return Colors.grey[600]!; // Grey[600] when not pressed
                }),
              ),
              child: Text(
                effectiveCategories[index],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            );
          }),
        ),
      ),
    );
  }
}
