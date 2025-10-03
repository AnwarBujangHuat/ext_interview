import 'package:ext_interview/view_model/cart_view_model.dart';
import 'package:ext_interview/view_model/plant_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/balance_summary.dart';
import '../widgets/hero_section.dart';
import '../widgets/maps_widget.dart';
import '../widgets/points_section.dart';

class PlantShopHomePage extends StatefulWidget {
  const PlantShopHomePage({super.key});

  @override
  State<PlantShopHomePage> createState() => _PlantShopHomePageState();
}

class _PlantShopHomePageState extends State<PlantShopHomePage> {
  final ScrollController _scrollController = ScrollController();
  int _firstVisibleIndex = 0;
  final double _itemWidth = 200;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      final index = (_scrollController.offset / _itemWidth).floor();
      if (index != _firstVisibleIndex) {
        setState(() {
          _firstVisibleIndex = index;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final plantVM = Provider.of<PlantSectionViewModel>(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1a4d2e), Color(0xFF2d5a3d), Color(0xFF3d6b4e)],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    spacing: 10,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(Icons.menu, color: Colors.white),
                          Column(
                            children: [
                              Text(
                                'PLANTOPIA',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                              ),
                              Text(
                                'WEST SPRINGFIELD',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                          Icon(Icons.notifications_outlined, color: Colors.white),
                        ],
                      ),
                      PointsSection(),
                      BalanceSummary()
                    ],
                  ),
                ),
              ),
            ),
            HeroSection(),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'NEW SERVICES',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2d5a3d),
                            ),
                          ),
                          Text(
                            'Discover our latest plant care services',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'View All',
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF2d5a3d),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: 300,
                    child: ListView.separated(
                      controller: _scrollController,
                      physics: ClampingScrollPhysics(),
                      separatorBuilder: (context, index) => SizedBox(width: 10),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: plantVM.services.length,
                      itemBuilder: (context, index) {
                        final service = plantVM.services[index];
                        return Padding(
                          padding: _firstVisibleIndex != index
                              ? const EdgeInsets.symmetric(vertical: 12.0)
                              : EdgeInsets.zero,
                          child: SizedBox(
                            width: 230,
                            child: _buildEnhancedServiceCard(
                              service.title,
                              service.description,
                              'RM ${service.price.toStringAsFixed(2)}',
                              service.imagePath,
                              Color(0xFF2d5a3d),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF1a4d2e), Color(0xFF2d5a3d)],
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
              child: Column(
                children: [
                  Text(
                    'TRENDING',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Plant Discoveries',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w300,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 30),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: plantVM.trendingPlants.length,
                    itemBuilder: (context, index) {
                      final plant = plantVM.trendingPlants[index];
                      return _buildEnhancedPlantCard(
                        plant.name,
                        plant.description,
                        'RM ${plant.price.toStringAsFixed(2)}',
                        plant.imagePath,
                      );
                    },
                  ),
                ],
              ),
            ),
            buildMapSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildEnhancedServiceCard(String title, String description, String price,
      String imagePath, Color accentColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 8),
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                  color: Colors.grey[200],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [accentColor.withOpacity(0.1), accentColor.withOpacity(0.05)],
                          ),
                        ),
                        child: Center(
                          child: Icon(Icons.local_florist, size: 40, color: accentColor),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.favorite_outline, size: 16, color: Colors.grey[600]),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        final cartVM = Provider.of<CartViewModel>(context, listen: false);
                        cartVM.addItem(
                          CartItem(
                            title: title,
                            subtitle: description,
                            imagePath: imagePath,
                            price: double.tryParse(price.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added to cart!')),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.add,
                          color: accentColor,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEnhancedPlantCard(String name, String description, String price, String imagePath) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(5)),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.green[100]!, Colors.green[50]!],
                            ),
                          ),
                          child: Center(
                            child: Icon(Icons.local_florist, size: 40, color: Colors.green[600]),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.favorite_outline, size: 14, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,                    fontWeight: FontWeight.bold,

                  ),
                ),
               
              ],
            ),
          ),
        ],
      ),
    );
  }
}