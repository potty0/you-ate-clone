import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _loggedInKey = 'loggedInKey';

class LoginAssistant {
  bool get loggedIn => _loggedIn ?? false;

  bool _loggedIn;

  Future<void> login() async {
    _setAndStoreLoggedIn(true);
  }

  Future<void> logout() async {
    _setAndStoreLoggedIn(false);
  }

  Future<void> _setAndStoreLoggedIn(bool loggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    _loggedIn = loggedIn;
    prefs.setBool(_loggedInKey, _loggedIn);
  }

  Future<bool> attemptAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    _loggedIn = prefs.getBool(_loggedInKey) ?? false;

    return _loggedIn;
  }
}

class LoginService extends InheritedWidget {
  final LoginAssistant service;

  LoginService({Key key, this.service, Widget child}) : super(key: key, child: child);

  static LoginAssistant of(BuildContext context) {
    final serviceContainer = context.dependOnInheritedWidgetOfExactType<LoginService>();
    return serviceContainer.service;
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}
