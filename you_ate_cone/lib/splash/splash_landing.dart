import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youatecone/services/login_assistant.dart';

class SplashLanding extends StatefulWidget {
  final Function loggedInRouteBuilder;
  final Function loggedOutRouteBuilder;

  const SplashLanding({
    Key key,
    this.loggedInRouteBuilder,
    this.loggedOutRouteBuilder,
  }) : super(key: key);

  @override
  _SplashLandingState createState() => _SplashLandingState();
}

class _SplashLandingState extends State<SplashLanding> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _attemptAutoLogin(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('You ate')),
      ),
    );
  }

  Future<void> _attemptAutoLogin(BuildContext context) async {
    final service = LoginService.of(context);
    final loggedIn = await service.attemptAutoLogin();

    final route = loggedIn ? widget.loggedInRouteBuilder(context) : widget.loggedOutRouteBuilder(context);
    Navigator.of(context).push(route);
  }
}
