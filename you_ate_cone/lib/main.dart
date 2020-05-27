import 'package:flutter/material.dart';
import 'package:youatecone/services/login_assistant.dart';
import 'package:youatecone/services/you_ate_api.dart';
import 'package:youatecone/splash/login_landing.dart';
import 'package:youatecone/splash/splash_landing.dart';
import 'package:youatecone/utils/no_animation_material_page_route.dart';
import 'package:youatecone/you_ate_home.dart';

final youAteApi = YouAteApi();
final loginAssistant = LoginAssistant();

class LoginService extends InheritedWidget {
  final LoginAssistant loginAssistant;

  LoginService({Key key, Widget child, this.loginAssistant}) : super(key: key, child: child);

  static LoginAssistant of(BuildContext context) {
    final LoginService service = context.dependOnInheritedWidgetOfExactType<LoginService>();
    return service.loginAssistant;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

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
      home: LoginService(
        loginAssistant: LoginAssistant(),
//        child: SplashLanding(
//          loggedInRouteBuilder: (context) => NoAnimationMaterialPageRoute(builder: (context) => YouAteHome()),
//          loggedOutRouteBuilder: (context) => NoAnimationMaterialPageRoute(builder: (context) => LoginLanding()),
//        ),
        child: YouAteHome(),
      ),
    );
  }
}
