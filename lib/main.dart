// ignore_for_file: deprecated_member_use

import 'package:ext_interview/presentation/cart_page.dart';
import 'package:ext_interview/presentation/plant_section.dart';
import 'package:ext_interview/presentation/profile_section.dart';
import 'package:ext_interview/presentation/schedule_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(PlantShopApp());
}

class PlantShopApp extends StatelessWidget {
  const PlantShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'SF Pro Display',
      ),
      home: MainNavigationPage(),
    );
  }
}

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage>
    with TickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final List<Widget> _pages = [
    PlantShopHomePage(),
    SchedulePage(),
    CartPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 300),
        child: _pages[_currentIndex],
      ),
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchPage()),
            );
          },
          backgroundColor: Color(0xFF2d5a3d),
          elevation: 8,
          child: Icon(Icons.search, color: Colors.white, size: 28),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomNavItem(Icons.home_outlined, Icons.home, 'Home', 0),
              _buildBottomNavItem(Icons.calendar_today_outlined, Icons.calendar_today, 'Schedule', 1),
              SizedBox(width: 40), 
              _buildBottomNavItem(Icons.shopping_cart_outlined, Icons.shopping_cart, 'Cart', 2),
              _buildBottomNavItem(Icons.person_outline, Icons.person, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData outlinedIcon, IconData filledIcon, String label, int index) {
    bool isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? filledIcon : outlinedIcon,
              color: isSelected ? Color(0xFF2d5a3d) : Colors.grey[400],
              size: 24,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Color(0xFF2d5a3d) : Colors.grey[400],
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}



class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> allItems = [
    {
      'name': 'Monstera Deliciosa',
      'category': 'Indoor Plants',
      'price': 'RM 45.00',
      'rating': 4.8,
      'image': 'assets/Image.jpg',
      'description': 'Beautiful split-leaf philodendron perfect for homes',
    },
    {
      'name': 'Snake Plant',
      'category': 'Air Purifying',
      'price': 'RM 35.00',
      'rating': 4.9,
      'image': 'assets/Image.jpg',
      'description': 'Low maintenance plant that purifies air',
    },
    {
      'name': 'Fiddle Leaf Fig',
      'category': 'Indoor Plants',
      'price': 'RM 85.00',
      'rating': 4.7,
      'image': 'assets/Image.jpg',
      'description': 'Statement plant with large violin-shaped leaves',
    },
    {
      'name': 'Plant Care Service',
      'category': 'Services',
      'price': 'RM 120.00',
      'rating': 4.9,
      'image': 'assets/Image.jpg',
      'description': 'Professional plant care and maintenance',
    },
    {
      'name': 'Pothos Golden',
      'category': 'Trailing Plants',
      'price': 'RM 25.00',
      'rating': 4.6,
      'image': 'assets/Image.jpg',
      'description': 'Easy-growing trailing plant with golden variegation',
    },
    {
      'name': 'Garden Design',
      'category': 'Services',
      'price': 'RM 300.00',
      'rating': 4.8,
      'image': 'assets/Image.jpg',
      'description': 'Custom garden design and landscaping service',
    },
  ];
  
  List<Map<String, dynamic>> filteredItems = [];
  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    
    filteredItems = allItems;
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = allItems.where((item) {
        final nameMatch = item['name'].toLowerCase().contains(query.toLowerCase());
        final categoryMatch = item['category'].toLowerCase().contains(query.toLowerCase());
        final descriptionMatch = item['description'].toLowerCase().contains(query.toLowerCase());
        final categoryFilter = selectedCategory == 'All' || item['category'] == selectedCategory;
        
        return (nameMatch || categoryMatch || descriptionMatch) && categoryFilter;
      }).toList();
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      selectedCategory = category;
      _filterItems(_searchController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final categories = ['All', 'Indoor Plants', 'Air Purifying', 'Trailing Plants', 'Services'];
    
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Color(0xFF2d5a3d),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Search Plants & Services',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Color(0xFF2d5a3d),
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _filterItems,
                decoration: InputDecoration(
                  hintText: 'Search for plants, services...',
                  prefixIcon: Icon(Icons.search, color: Color(0xFF2d5a3d)),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(Icons.clear, color: Colors.grey),
                          onPressed: () {
                            _searchController.clear();
                            _filterItems('');
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),
            ),
          ),
          
          Container(
            height: 60,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                final isSelected = selectedCategory == category;
                
                return GestureDetector(
                  onTap: () => _filterByCategory(category),
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Color(0xFF2d5a3d) : Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? Color(0xFF2d5a3d) : Colors.grey[300]!,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey[700],
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          Expanded(
            child: filteredItems.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'No results found',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          'Try searching for something else',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.all(20),
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      
                      return Container(
                        margin: EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 5),
                            ),
                          ],
                        ),
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Selected: ${item['name']}'),
                                backgroundColor: Color(0xFF2d5a3d),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(15),
                          child: Padding(
                            padding: EdgeInsets.all(15),
                            child: Row(
                              children: [
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey[200],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.asset(
                                      item['image'],
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Color(0xFF2d5a3d).withOpacity(0.1),
                                          child: Icon(
                                            item['category'] == 'Services'
                                                ? Icons.build
                                                : Icons.local_florist,
                                            color: Color(0xFF2d5a3d),
                                            size: 35,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['name'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey[800],
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: Color(0xFF2d5a3d).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          item['category'],
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Color(0xFF2d5a3d),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        item['description'],
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 10),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            item['price'],
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFF2d5a3d),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                                size: 16,
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                item['rating'].toString(),
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}