import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YouAteHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('You ate!')),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.face), title: Text('Profile')),
        BottomNavigationBarItem(icon: Icon(Icons.stars), title: Text('Capture')),
        BottomNavigationBarItem(icon: Icon(Icons.message), title: Text('Chat')),
      ]),
    );
  }
}
