import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logout'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'logout') {
                _logout();
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: ListTile(
                    leading: Icon(Icons.logout, color: Colors.black),
                    title: Text('Logout'),
                  ),
                ),
              ];
            },
          ),
        ],
      ),
      body: Center(child: Text('You are on the logout page')),
    );
  }

  // Logout function that exits the app
  void _logout() {
    // Perform necessary logout operations, like clearing session or auth tokens

    // Exit the app
    Future.delayed(Duration(milliseconds: 300), () {
      SystemNavigator.pop(); // Close the app
    });
  }
}
