
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF2d5a3d), Color(0xFF3d6b4e)],
                  ),
                ),
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Color(0xFF2d5a3d),
                      ),
                    ),
                    SizedBox(height: 15),
                    Text(
                      'John Gardner',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Plant Enthusiast',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildProfileStat('Orders', '12'),
                        _buildProfileStat('Points', '1,250'),
                        _buildProfileStat('Plants', '24'),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    _buildProfileOption(Icons.edit, 'Edit Profile', () {}),
                    _buildProfileOption(Icons.history, 'Order History', () {}),
                    _buildProfileOption(Icons.favorite, 'Wishlist', () {}),
                    _buildProfileOption(Icons.notifications, 'Notifications', () {}),
                    _buildProfileOption(Icons.help, 'Help & Support', () {}),
                    _buildProfileOption(Icons.settings, 'Settings', () {}),
                    SizedBox(height: 20),
                    _buildProfileOption(Icons.logout, 'Logout', () {}, isLogout: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption(IconData icon, String title, VoidCallback onTap, {bool isLogout = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? Colors.red : Color(0xFF2d5a3d),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isLogout ? Colors.red : Colors.grey[800],
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.grey[400],
        ),
        onTap: onTap,
      ),
    );
  }
}

