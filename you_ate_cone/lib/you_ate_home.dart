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
      body: IndexedStack(
        index: _selectedTabIndex,
        children: [
          Profile(),
          Capture(),
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

class Capture extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemBuilder: (context, _) => CaptureItem(),
        separatorBuilder: (context, index) => Divider(thickness: 0),
        itemCount: 100,
      ),
    );
  }
}

class CaptureItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(flex: 1, child: Container()),
          Flexible(
            flex: 2,
            child: Container(
              child: Center(
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey,
                    boxShadow: [BoxShadow(blurRadius: 20, spreadRadius: 1, color: Colors.black45)],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Text('HH:mm', textAlign: TextAlign.right),
                )
              ],
            ),
          ),
        ],
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
