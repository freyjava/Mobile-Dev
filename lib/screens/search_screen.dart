// lib/screens/search_screen.dart
import 'package:course_app/screens/home_screen.dart'; // Ensure this path is correct
import 'package:course_app/widgets/course_grid.dart'; // Ensure this path is correct
import 'package:course_app/widgets/machine_learning_card.dart'; // Ensure this path is correct
import 'package:flutter/material.dart';
import 'package:course_app/widgets/custom_search_bar.dart'; // Adjust path as needed

// Define a simple Course model
class Course {
  final String title;
  final String description;
  final String imageUrl; // Path to course image asset
  final String type; // e.g., 'Course', 'Project', 'Pro session'

  Course({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.type,
  });
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();
  String _searchQuery = '';
  String _selectedCategory = 'All'; // State for active category tab

  // Dummy data for courses to demonstrate filtering
  final List<Course> _allCourses = [
    Course(
      title: 'Computer Network Basics',
      description: 'Learn the fundamentals of computer networks.',
      imageUrl: 'assets/images/microsoftword.png',
      type: 'Course',
    ),
    Course(
      title: 'Advanced Computer Network',
      description: 'Dive deep into advanced networking concepts.',
      imageUrl: 'assets/images/microsoftword.png',
      type: 'Course',
    ),
    Course(
      title: 'Network Security Essentials',
      description: 'Understand key aspects of network security.',
      imageUrl: 'assets/images/microsoftword.png',
      type: 'Course',
    ),
    Course(
      title: 'Introduction to Cyber Security',
      description: 'Explore the world of cyber security.',
      imageUrl: 'assets/images/microsoftword.png',
      type: 'Course',
    ),
    Course(
      title: 'Ethical Hacking',
      description: 'Learn ethical hacking techniques.',
      imageUrl: 'assets/images/microsoftword.png',
      type: 'Pro session',
    ),
    Course(
      title: 'Machine Learning Fundamentals',
      description: 'Get started with machine learning.',
      imageUrl: 'assets/images/microsoftword.png',
      type: 'Course',
    ),
    Course(
      title: 'Data Science with Python',
      description: 'Master data science using Python.',
      imageUrl: 'assets/images/microsoftword.png',
      type: 'Pro session',
    ),
    Course(
      title: 'Build a Personal Portfolio Website',
      description: 'A project-based course on web development.',
      imageUrl: 'assets/images/microsoftword.png',
      type: 'Project',
    ),
    Course(
      title: 'Mobile App Development with Flutter',
      description: 'Build native mobile apps for iOS and Android.',
      imageUrl: 'assets/images/microsoftword.png',
      type: 'Course',
    ),
    Course(
      title: 'Responsive Web Design',
      description: 'Learn to create websites that look great on any device.',
      imageUrl: 'assets/images/microsoftword.png',
      type: 'Project',
    ),
  ];

  List<Course> _filteredCourses = [];

  @override
  void initState() {
    super.initState();
    _filteredCourses = _allCourses; // Initialize with all courses
    controller.addListener(_onSearchChanged);
    _applyFilters(); // Apply initial filters (e.g., 'All' category and empty search)
  }

  // Method to apply both search query and category filters
  void _applyFilters() {
    List<Course> tempFilteredCourses = _allCourses;

    // 1. Filter by selected category
    if (_selectedCategory != 'All') {
      tempFilteredCourses =
          tempFilteredCourses.where((course) {
            return course.type == _selectedCategory;
          }).toList();
    }

    // 2. Filter by search query (applied to the already category-filtered list)
    if (_searchQuery.isNotEmpty) {
      tempFilteredCourses =
          tempFilteredCourses.where((course) {
            return course.title.toLowerCase().contains(
              _searchQuery.toLowerCase(),
            );
          }).toList();
    }

    setState(() {
      _filteredCourses = tempFilteredCourses;
    });
  }

  void _onSearchChanged() {
    _searchQuery = controller.text;
    _applyFilters(); // Recalculate filters whenever search query changes
  }

  void onCancelTap() {
    controller.clear(); // Clears the text in the TextField
    focusNode.unfocus(); // Hides the keyboard
    // Reset category to 'All' when search is cleared, to show default content
    setState(() {
      _selectedCategory = 'All';
    });
    _applyFilters(); // Re-apply filters to show 'All' content and clear search results
  }

  @override
  void dispose() {
    controller.removeListener(_onSearchChanged); // Important: remove listener
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Widget _buildCourseListItem(Course course) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // Use Image.asset with error handling for course images
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(
                course.imageUrl,
                fit: BoxFit.cover, // Or BoxFit.contain
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to a default icon if image fails to load
                  return const Icon(
                    Icons.image_not_supported,
                    size: 40,
                    color: Colors.grey,
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    course.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course.description,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }

  // Helper to get actual counts for each category
  int _getCategoryCount(String category) {
    if (category == 'All') {
      return _allCourses.length;
    } else {
      return _allCourses.where((course) => course.type == category).length;
    }
  }

  Widget _buildCategoryTab(String title) {
    bool isSelected = _selectedCategory == title;
    int count = _getCategoryCount(title);

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = title;
          _applyFilters(); // Recalculate filters when category changes
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.deepOrange : Colors.grey[200],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '$title ($count)',
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _gridItem(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset('assets/images/logoImage.png', height: 30),
            const Spacer(),
            IconButton(
              onPressed: () {
                focusNode.requestFocus(); // focus search input
              },
              icon: const Icon(Icons.search, color: Colors.black),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.person, color: Colors.black),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(
                controller: controller,
                focusNode: focusNode,
                onCancelTap: onCancelTap,
              ),
              const SizedBox(height: 10),
              // Category Tabs
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildCategoryTab('All'),
                  _buildCategoryTab('Course'),
                  _buildCategoryTab('Project'),
                  _buildCategoryTab('Pro session'),
                ],
              ),
              const SizedBox(height: 20),
              // Display filtered results or default content
              // Show original content ONLY if search is empty AND category is 'All'
              _searchQuery.isEmpty && _selectedCategory == 'All'
                  ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.deepOrange,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Explore your favorite subject",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const MachineLearningCard(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.deepOrange,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Build your competency with us!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const MachineLearningCard(),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.deepOrange,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Best recommend for you!",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const MachineLearningCard(),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Cyber Security",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const CourseGrid(),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Network Administrator",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const CourseGrid(),
                      const SizedBox(height: 16),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          "Crypto Graphy",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const CourseGrid(),
                    ],
                  )
                  : _filteredCourses.isEmpty
                  ? const Center(child: Text('No results found.'))
                  : Column(
                    children:
                        _filteredCourses
                            .map((course) => _buildCourseListItem(course))
                            .toList(),
                  ),
              const SizedBox(height: 16),
              Image.asset('assets/images/logoImage.png', height: 50),
              const SizedBox(height: 12),
              SizedBox(
                height: 5 * 50,
                child: GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _gridItem("About Us"),
                    _gridItem("Social Impact"),
                    _gridItem("Contact Us"),
                    _gridItem("Cookies Setting"),
                    _gridItem("FaQs"),
                    _gridItem("Terms"),
                    _gridItem("Community Forum"),
                    _gridItem("Accessibility Statement"),
                    _gridItem("Term of Service"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: const Text(
                  'Certified',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset("assets/images/itclogo.png"),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.facebook, size: 40),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow, size: 40),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.gif_box, size: 40),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text('2023 Worktency, Inc. All rights reserved.'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: 0, // Set the appropriate index for 'Explore'
        onTap: (index) {
          // Implement navigation logic if needed
          // For example, if index 0 is Explore (current screen)
          // index 1 might navigate to MyCoursesScreen
          // index 2 might navigate to OnlineCoursesScreen
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Explore'),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            label: 'My Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow_rounded),
            label: 'Online Courses',
          ),
        ],
      ),
    );
  }
}
