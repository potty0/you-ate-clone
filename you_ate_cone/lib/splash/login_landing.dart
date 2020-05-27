import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginLanding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Please login to continue', textAlign: TextAlign.center),
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            MaterialButton(
              color: Colors.blue,
              child: Text('Login'),
              onPressed: () => print('login'),
            ),
          ]),
        ],
      ),
    );
  }
}
