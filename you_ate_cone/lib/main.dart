import 'package:flutter/material.dart';
import 'package:youatecone/you_ate_home.dart';

void main() {
  runApp(YouAteApp());
}

class YouAteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'You Ate',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: YouAteHome(),
    );
  }
}

