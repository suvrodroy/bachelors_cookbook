import 'package:bachelors_cookbook/recipe_content_page.dart';
import 'package:bachelors_cookbook/search_page.dart';
import 'package:flutter/material.dart';
import 'landing_page.dart';
import 'all_item_page.dart';
import 'ingredient_search_page.dart';
import 'profile_page.dart';

void main() {
  runApp(BachelorsCookbook());
}

class BachelorsCookbook extends StatefulWidget {
  const BachelorsCookbook({super.key});

  @override
  State<BachelorsCookbook> createState() => _BachelorsCookbookState();
}

class _BachelorsCookbookState extends State<BachelorsCookbook> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    LandingPage(),
    SearchPage(),
    FilterPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF141414),
        colorScheme: ThemeData.dark().colorScheme.copyWith(
          primaryContainer: Color(0xFF252525),
          primary: Color(0xFFff9100),
        ),
      ),
      home: Scaffold(
        body: Stack(
          children: [
            _widgetOptions.elementAt(_selectedIndex),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavigationBar(
                backgroundColor: Colors.black.withValues(alpha: 0.5),
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.search),
                    label: 'Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.filter),
                    label: 'Ingredient Search',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'profile',
                  ),
                ],
                currentIndex: _selectedIndex,
                // selectedItemColor: Colors.amber[800],
                selectedItemColor: Color(0xFFff9100),
                onTap: _onItemTapped,
              ),
            ),
          ],
        ),
      ),
    );
    ;
  }
}
