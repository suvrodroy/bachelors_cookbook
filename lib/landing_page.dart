import 'package:flutter/material.dart';
import 'all_item_page.dart';
import 'data_source.dart';
import 'my_widgets.dart';

String currentMealCategory = 'Breakfast';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final DataSource _dataSource = DataSource();
  String? selectedCategory = 'Breakfast';
  // int _selectedIndex = 0;
  //
  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            SizedBox(height: 64),
            // start greetings
            Padding(
              padding: EdgeInsets.all(16),
              child: MyHeadingWidget(
                heading: 'Hey, User with a long name',
                subheading: 'Ready to cook?',
              ),
            ),
            // end greetings

            // start Today's Pick
            Padding(
              padding: EdgeInsets.all(20),
              child: Material(
                color: Theme.of(context).colorScheme.primaryContainer,
                // color: Colors.deepOrangeAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: const BorderSide(color: Color(0xFFff9100), width: 3),
                ),
                child: InkWell(
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Today\'s\nPick',
                          style: TextStyle(
                            // color: Color(0xFFff9100),
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: FoodCard(
                          aspectRatio: 1.0,
                          foodItem: _dataSource.getRandomItem(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // end Today's Pick
            SizedBox(height: 16),
            Center(
              child: Text(
                'Meal Categories',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            // start of category section
            MealCategorySelector(
              selectedCategory: selectedCategory,
              showAll: false,
              onCategorySelect: (String? value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            SizedBox(height: 0),
            FixedHeightCarousel(
              items:
                  _dataSource
                      .getRecipeOfCategory()
                      .take(5)
                      .map((e) => FoodCard(foodItem: e))
                      .toList(),
            ),
            SizedBox(height: 8),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Color(0xFFff9100),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              AllItemsPage(initialCategory: selectedCategory),
                    ),
                  );
                },
                child: const Text('View More'),
              ),
            ),

            SizedBox(height: 32),
            // start of popular section
            Center(
              child: Text(
                'Most Popular Recipes',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            FixedHeightCarousel(
              items:
                  _dataSource
                      .getRecipeOfCategory()
                      .take(5)
                      .map((e) => FoodCard(foodItem: e))
                      .toList(),
            ),

            // end of popular section
            SizedBox(height: 64),
          ],
        ),
      ],
    );
  }
}

class MyHeadingWidget extends StatelessWidget {
  final String heading;
  final String subheading;

  MyHeadingWidget({required this.heading, required this.subheading});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            heading,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(height: 8),
        Text(
          subheading,
          style: TextStyle(fontSize: 16, color: Colors.grey),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
