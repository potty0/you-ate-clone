import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youatecone/capture_overview_landing.dart';

class YouAteHome extends StatefulWidget {
  @override
  _YouAteHomeState createState() => _YouAteHomeState();
}

class _YouAteHomeState extends State<YouAteHome> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedTabIndex,
        children: [
          Profile(),
          CaptureOverviewLanding(),
          Chat(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.face), title: Text('Profile')),
          BottomNavigationBarItem(icon: Icon(Icons.stars), title: Text('Capture')),
          BottomNavigationBarItem(icon: Icon(Icons.message), title: Text('Chat')),
        ],
        currentIndex: _selectedTabIndex,
        onTap: (index) => setState(() => _selectedTabIndex = index),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Center(child: Icon(Icons.face, size: 200)),
    );
  }
}

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(child: Text('Chat')),
    );
  }
}
