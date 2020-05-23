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
        itemBuilder: (context, index) => CaptureItem(
          offTrack: index % 2 == 0,
        ),
        separatorBuilder: (context, index) => Divider(thickness: 0),
        itemCount: 100,
      ),
    );
  }
}

class CaptureItem extends StatelessWidget {
  final bool offTrack;

  const CaptureItem({Key key, this.offTrack = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double offTrackOffset = 40;
    final double padding = offTrack ? offTrackOffset * 2 : 0;

    return Container(
      height: 160,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(flex: 2, child: Container()),
          Flexible(
            flex: 5,
            child: Container(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: padding),
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
          ),
          Flexible(
            flex: 2,
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
