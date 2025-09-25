import 'package:flutter/material.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
return      // Enhanced Hero Plant Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFF8F9FA), Color(0xFFE9ECEF)],
                ),
              ),
              padding: EdgeInsets.only(bottom: 40),
              child: Column(
                children: [
                  Container(
              width: double.infinity,
                  height: 250,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/Home Banner.jpg',
                            fit: BoxFit.fitHeight,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Colors.green[100]!, Colors.green[200]!],
                                  ),
                                ),
                                child: Center(
                                  child: Icon(Icons.local_florist, size: 60, color: Colors.green[600]),
                                ),
                              );
                            },
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Icon(Icons.favorite_outline, color: Colors.grey[600], size: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildEnhancedActionButton('SHOP',  Icons.shopping_bag_outlined),
                      _buildEnhancedActionButton('SERVICES', Icons.build_outlined),
                      _buildEnhancedActionButton('POSTS', Icons.article_outlined),
                    ],
                  ),
                  
                  SizedBox(height: 40),
                  
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildEnhancedServiceIcon(Icons.local_florist, 'Plant\nCare', Color(0xFF2d5a3d)),
                        _buildEnhancedServiceIcon(Icons.water_drop, 'Watering', Color(0xFF3498DB)),
                        _buildEnhancedServiceIcon(Icons.eco, 'Organic', Color(0xFF27AE60)),
                        _buildEnhancedServiceIcon(Icons.agriculture, 'Garden', Color(0xFFE67E22)),
                        _buildEnhancedServiceIcon(Icons.grass, 'Landscape', Color(0xFF8E44AD)),
                      ],
                    ),
                  ),
                ],
              ),
            );  }
            
}
  Widget _buildEnhancedServiceIcon(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
            ),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: color,
            size: 24,
          ),
        ),
        SizedBox(height: 12),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
    Widget _buildEnhancedActionButton(String text, IconData icon) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
       color: Color(0xFF2d5a3d),
        borderRadius: BorderRadius.circular(10),
      
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 18),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
