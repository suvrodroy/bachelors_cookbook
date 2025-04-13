import 'package:bachelors_cookbook/data_source.dart';
import 'package:bachelors_cookbook/recipe_content_page.dart';
import 'package:flutter/material.dart';

class Ingredient {
  final String? name;
  final String? avatar;
  Ingredient({this.name, this.avatar});
}

class FoodCard extends StatelessWidget {
  final RecipeItem foodItem;
  final double elevation;
  final double aspectRatio;

  const FoodCard({
    super.key,
    required this.foodItem,
    this.elevation = 0.0,
    this.aspectRatio = 0.85,
  });

  @override
  Widget build(BuildContext context) {
    String imagePath = foodItem.imagePath;
    String foodName = foodItem.foodName;
    double rating = foodItem.rating;

    return RatioMaterial(
      aspectRatio: aspectRatio,
      child: Material(
        elevation: elevation,
        shadowColor: const Color(0xFFff9100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Rounded Image using Container and DecorationImage
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // InkWell for Splash (positioned on top)
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) =>
                                RecipeContentPage(recipeId: foodItem.recipeId),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(16.0),
                  child: Container(),
                ),
              ),
            ),
            // Overlay with Text and Rating (remains the same)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      foodName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        for (int i = 0; i < rating.floor(); i++)
                          const Icon(
                            Icons.star,
                            color: Colors.yellow,
                            size: 16.0,
                          ),
                        if (rating - rating.floor() > 0)
                          const Icon(
                            Icons.star_half,
                            color: Colors.yellow,
                            size: 16.0,
                          ),
                        for (int i = 0; i < 5 - rating.ceil(); i++)
                          const Icon(
                            Icons.star_border,
                            color: Colors.yellow,
                            size: 16.0,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RatioMaterial extends StatelessWidget {
  final double aspectRatio;
  final Widget child;
  final double elevation;
  final ShapeBorder? shape;
  final Color? color;

  const RatioMaterial({
    Key? key,
    required this.aspectRatio,
    required this.child,
    this.elevation = 0.0,
    this.shape,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AspectRatio(aspectRatio: aspectRatio, child: child);
      },
    );
  }
}

/// start Carousel Class

class FixedHeightCarousel extends StatefulWidget {
  final List<Widget> items;
  final double aspectRatio; // Add aspectRatio parameter

  const FixedHeightCarousel({
    Key? key,
    required this.items,
    this.aspectRatio = 0.85, // Default aspect ratio
  }) : super(key: key);

  @override
  State<FixedHeightCarousel> createState() => _FixedHeightCarouselState();
}

class _FixedHeightCarouselState extends State<FixedHeightCarousel> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
    ); // Set viewportFraction
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _animateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardWidth = MediaQuery.of(context).size.width * 0.8;
    final cardHeight = cardWidth / widget.aspectRatio;

    return SizedBox(
      height: cardHeight,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none, // Disable clipping on the Stack
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: PageView.builder(
              clipBehavior: Clip.none, // Disable clipping on the PageView
              controller: _pageController,
              itemCount: widget.items.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: widget.items[index],
                  ),
                );
              },
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
            ),
          ),
          if (widget.items.length > 1)
            Positioned(
              left: 16.0,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed:
                    _currentPage > 0
                        ? () => _animateToPage(_currentPage - 1)
                        : null,
              ),
            ),
          if (widget.items.length > 1)
            Positioned(
              right: 16.0,
              child: IconButton(
                icon: const Icon(Icons.arrow_forward_ios),
                onPressed:
                    _currentPage < widget.items.length - 1
                        ? () => _animateToPage(_currentPage + 1)
                        : null,
              ),
            ),
          if (widget.items.length > 1)
            Positioned(
              bottom: 8.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  widget.items.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: CircleAvatar(
                      radius: 4.0,
                      backgroundColor:
                          _currentPage == index ? Colors.blue : Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/*  // Example usage:
class CarouselExample extends StatelessWidget {
  const CarouselExample({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fixed Height Carousel')),
      body: Column(
        children: [
          FixedHeightCarousel(
            items: [
              Card(
                elevation: 8.0,
                child: Container(
                  color: Colors.red,
                  width: 300,
                  height: 200,
                  child: const Center(
                    child: Text(
                      'Item 1',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 8.0,
                child: Container(
                  color: Colors.green,
                  width: 300,
                  height: 200,
                  child: const Center(
                    child: Text(
                      'Item 2',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 8.0,
                child: Container(
                  color: Colors.blue,
                  width: 300,
                  height: 200,
                  child: const Center(
                    child: Text(
                      'Item 3',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 8.0,
                child: Container(
                  color: Colors.orange,
                  width: 300,
                  height: 200,
                  child: const Center(
                    child: Text(
                      'Item 4',
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text('Other content below the carousel'),
        ],
      ),
    );
  }
}
    */
