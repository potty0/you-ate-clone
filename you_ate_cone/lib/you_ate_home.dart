import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YouAteHome extends StatefulWidget {
  @override
  _YouAteHomeState createState() => _YouAteHomeState();
}

class _YouAteHomeState extends State<YouAteHome> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(context, _selectedTabIndex),
      appBar: _buildHeader(context, _selectedTabIndex),
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

  Widget _buildHeader(BuildContext context, int index) {
    const colors = [Colors.blue, Colors.red, Colors.green];
    return AppBar(title: Text('Page $index'), backgroundColor: colors[index]);
  }

  Widget _buildPage(BuildContext context, int index) {
    const colors = [Colors.red, Colors.green, Colors.blue];

    return Container(
      color: colors[index],
      child: Center(
        child: Text('You ate! - page index:$index'),
      ),
    );
  }
}
