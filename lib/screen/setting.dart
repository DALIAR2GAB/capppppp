import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Account Section
            _buildSectionHeader('Account'),
            _buildListTile('Profile', Icons.account_circle, () {
              // Navigate to Profile page (يمكنك إضافة هذا التنقل في المستقبل)
            }),
            _buildListTile('Change Password', Icons.lock, () {
              // Navigate to Change Password page
            }),

            Divider(),

            // Notifications Section
            _buildSectionHeader('Notifications'),
            _buildSwitchTile('Push Notifications', true),
            _buildSwitchTile('Email Alerts', false),

            Divider(),

            // General Section
            _buildSectionHeader('General'),
            _buildListTile('Language', Icons.language, () {
              // Navigate to Language settings
            }),
            _buildListTile('Privacy Policy', Icons.lock_outline, () {
              // Open Privacy Policy page
            }),

            Divider(),

            // Logout Section
            _buildListTile('Logout', Icons.exit_to_app, () {
              // Add logout functionality here
            }),
          ],
        ),
      ),
    );
  }

  // Custom method to create section headers
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Custom method to build ListTile widgets
  Widget _buildListTile(String title, IconData icon, Function onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.blueAccent),
      title: Text(title, style: TextStyle(fontSize: 16)),
      onTap: () => onTap(),
    );
  }

  // Custom method to build Switch widgets
  Widget _buildSwitchTile(String title, bool value) {
    return ListTile(
      title: Text(title, style: TextStyle(fontSize: 16)),
      trailing: Switch(
        value: value,
        onChanged: (bool newValue) {
          // Handle switch changes here (مثلاً تغيير حالة الإعداد)
        },
        activeColor: Colors.blueAccent,
      ),
    );
  }
}
