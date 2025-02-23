import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Profile Header
          const Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 40),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Doe',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Collector since 2023',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Collection Stats
          Card(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Collection Stats',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                ),
                const Divider(height: 0),
                _buildStatTile('Total Cards', '1,234'),
                const Divider(height: 0),
                _buildStatTile('Complete Sets', '3'),
                const Divider(height: 0),
                _buildStatTile('Wish List Items', '25'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Quick Actions
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildActionTile('Export Collection', Icons.file_download),
                _buildActionTile('Share Profile', Icons.share),
                _buildActionTile('Scan Card', Icons.qr_code_scanner),
                _buildActionTile('View Wishlist', Icons.favorite),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Recent Activity
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildActivityTile(
                  'Added Blue-Eyes White Dragon',
                  '2 hours ago',
                  Icons.add_circle_outline,
                ),
                _buildActivityTile(
                  'Updated Dark Magician condition',
                  '5 hours ago',
                  Icons.edit_outlined,
                ),
                _buildActivityTile(
                  'Removed Kuriboh',
                  'Yesterday',
                  Icons.remove_circle_outline,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildStatTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildActionTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        // TODO: Implement action
      },
    );
  }

  static Widget _buildActivityTile(String title, String time, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(time),
      dense: true,
    );
  }
}
