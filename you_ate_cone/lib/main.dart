import 'package:flutter/material.dart';
import 'package:youatecone/services/login_assistant.dart';
import 'package:youatecone/services/you_ate_api.dart';
import 'package:youatecone/splash/login_landing.dart';
import 'package:youatecone/splash/splash_landing.dart';
import 'package:youatecone/utils/no_animation_material_page_route.dart';
import 'package:youatecone/you_ate_home.dart';

final youAteApi = YouAteApi();
final loginAssistant = LoginAssistant();

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
      home: SplashLanding(
        loginAssistant: loginAssistant,
        loggedInRouteBuilder: (context) => NoAnimationMaterialPageRoute(builder: (context) => YouAteHome()),
        loggedOutRouteBuilder: (context) => NoAnimationMaterialPageRoute(builder: (context) => LoginLanding()),
      ),
    );
  }
}
