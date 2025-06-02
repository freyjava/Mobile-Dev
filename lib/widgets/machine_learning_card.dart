import 'package:flutter/material.dart';

class MachineLearningCard extends StatefulWidget {
  const MachineLearningCard({super.key});

  @override
  State<MachineLearningCard> createState() => _MachineLearningCardState();
}

class _MachineLearningCardState extends State<MachineLearningCard> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Helper method to build a pagination dot
  Widget _buildDot(Color color) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  @override
  Widget build(BuildContext context) {
    // The PageView will contain multiple identical cards for demonstration.
    // In a real application, you would pass a list of data to generate different cards.
    return Padding(
      // Added Padding widget here
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
      ), // Horizontal padding
      child: Column(
        // Use a Column to stack the PageView and the dots
        mainAxisSize: MainAxisSize.min, // Take minimum vertical space
        children: [
          SizedBox(
            height: 470, // Adjusted height for the PageView to fit the card
            child: PageView.builder(
              controller: _pageController,
              itemCount: 4, // Number of "pages" or cards to swipe through
              itemBuilder: (context, index) {
                return Card(
                  elevation: 8, // Shadow for the card
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      20.0,
                    ), // Rounded corners for the card
                  ),
                  child: Container(
                    width: 350, // Fixed width for the card, adjust as needed
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize:
                          MainAxisSize.min, // Make column take minimum space
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Image Section
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            12.0,
                          ), // Rounded corners for the image
                          child: Image.asset(
                            // Changed to Image.network for placeholder
                            'assets/images/meeting.png', // Placeholder image URL
                            fit: BoxFit.cover,
                            width:
                                double
                                    .infinity, // Image takes full width of the card
                            height: 200, // Fixed height for the image
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 200,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(
                                    Icons.error_outline,
                                    color: Colors.grey,
                                    size: 50,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20), // Spacing below the image
                        // Title Section
                        Text(
                          'Introduction to Machine Learning (Card ${index + 1})', // Title updated for clarity
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 10), // Spacing below the title
                        // Quote Section
                        const Text(
                          '"Machine learning and AI are the engines driving the technological revolution of our time, transforming the way we work, live, and innovate"',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        const SizedBox(height: 20), // Spacing below the quote
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20), // Spacing between the card and the dots
          // Pagination Dots Section (now dynamic based on current page and outside the card)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (dotIndex) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: _buildDot(
                  _currentPage == dotIndex
                      ? Colors.deepOrange
                      : Colors.grey[300]!,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
