import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youatecone/services/login_assistant.dart';

class SplashLanding extends StatefulWidget {
  final Function loggedInRouteBuilder;
  final Function loggedOutRouteBuilder;

  final LoginAssistant loginAssistant;

  const SplashLanding({Key key, this.loggedInRouteBuilder, this.loggedOutRouteBuilder, this.loginAssistant})
      : super(key: key);

  @override
  _SplashLandingState createState() => _SplashLandingState();
}

class _SplashLandingState extends State<SplashLanding> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkLoggedInState());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('You Ate'),
        ),
      ),
    );
  }

  Future<void> _checkLoggedInState() async {
    final loggedIn = await widget.loginAssistant.autoLogin();
    final route = loggedIn ? widget.loggedInRouteBuilder(context) : widget.loggedOutRouteBuilder(context);
    Navigator.of(context).push(route);
  }
}
