import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youatecone/services/login_assistant.dart';
import 'package:youatecone/splash/no_animation_material_page_route.dart';
import 'package:youatecone/you_ate_home.dart';

class LoginLanding extends StatelessWidget {
  const LoginLanding({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Please login', textAlign: TextAlign.center),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(child: Text('Login'), onPressed: () => _onLoginSelected(context)),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _onLoginSelected(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Confirmation'),
          content: Text('Hi, are you sure you want to login?'),
          actions: [
            CupertinoDialogAction(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                _onConfirmLoginSelected(context);
              },
            ),
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
              isDestructiveAction: true,
            ),
          ],
        );
      },
    );
  }

  void _onConfirmLoginSelected(BuildContext context) {
    final loginService = LoginService.of(context);
    loginService
        .login()
        .then((_) => Navigator.of(context).push(NoAnimationMaterialPageRoute(builder: (context) => YouAteHome())));
  }
}
