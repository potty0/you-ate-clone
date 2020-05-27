import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _loggedInKey = 'loggedInKey';

class LoginAssistant extends ChangeNotifier {
  bool get loggedIn => _loggedIn ?? false;

  bool _loggedIn;

  Future<bool> autoLogin() async {
    await Future.delayed(Duration(seconds: 2));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _loggedIn = prefs.getBool(_loggedInKey) ?? false;

    return _loggedIn;
  }

  Future<void> login() async {
    await Future.delayed(Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_loggedInKey, true);

    _setLoggedInAndNotify(true);
  }

  Future<void> logout() async {
    await Future.delayed(Duration(seconds: 1));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_loggedInKey, false);

    _setLoggedInAndNotify(false);
  }

  void _setLoggedInAndNotify(bool loggedIn) {
    _loggedIn = loggedIn;
    notifyListeners();
  }
}
