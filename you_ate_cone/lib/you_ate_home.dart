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
    switch (index) {
      case 0:
        return Profile();

      case 1:
        return Capture();

      case 2:
        return Chat();

      default:
        throw ArgumentError('Unsupported tab index:$index');
    }
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

class Capture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(title: Text('Item $index'));
        },
      ),
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
