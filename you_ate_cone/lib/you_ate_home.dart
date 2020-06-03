import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youatecone/capture/capture_overview_landing.dart';
import 'package:youatecone/profile/profile_landing.dart';

class YouAteHome extends StatefulWidget {
  final int initialTabIndex;

  const YouAteHome({Key key, this.initialTabIndex = 1}) : super(key: key);

  @override
  _YouAteHomeState createState() => _YouAteHomeState();
}

class _YouAteHomeState extends State<YouAteHome> {
  int _selectedTabIndex = 0;

  @override
  void initState() {
    _selectedTabIndex = widget.initialTabIndex;
    super.initState();
  }

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

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(child: Text('Chat')),
    );
  }
}
