import 'package:course_app/screens/search_screen.dart';
import 'package:course_app/widgets/course_grid.dart';
import 'package:course_app/widgets/quote_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Helper function to create styled grid items
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchScreen()),
                );
              },
              icon: const Icon(Icons.search),
            ),
            IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Unlock your potential',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'with',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 4),
              Text(
                'Worktency',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Discover industry-leading courses designed to equip you with real-world skills. Join our community and start your journey to success today.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Image.asset('assets/images/workImage.png'),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.bookmark_add_outlined),
            label: const Text("Explore Courses"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: Colors.grey.shade100,
              foregroundColor: Colors.blue.shade600,
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.assignment_returned_outlined),
            label: const Text('Join as Educator'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: Colors.deepOrange,
              foregroundColor: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          const CourseGrid(),
          const SizedBox(height: 32),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Meet Our Teachers',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/images/teacher2.png', height: 170),
              Image.asset('assets/images/teacher3.png', height: 170),
              Image.asset('assets/images/teacher4.png', height: 170),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              Icon(Icons.arrow_forward_ios, color: Colors.deepOrange),
              Icon(Icons.arrow_forward_ios, color: Colors.deepOrange),
              Icon(Icons.arrow_forward_ios, color: Colors.deepOrange),
              SizedBox(width: 30),
              Expanded(
                child: Text(
                  'To reach our only One Goal,\nwhat we can share with you today',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const QuoteList(),
          const SizedBox(height: 12),
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
          Image.asset("assets/images/itclogo.png"),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.facebook, size: 40),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.play_arrow, size: 40),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.gif_box, size: 40)),
            ],
          ),
          const SizedBox(height: 16),
          Center(child: Text('2023 Worktency, Inc. All rights reserved.')),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: 0,
        onTap: (index) {
          // Implement navigation logic if needed
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
