import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CaptureDetailsViewModel {}

class CaptureDetails extends StatefulWidget {
  @override
  _CaptureDetailsState createState() => _CaptureDetailsState();
}

class _CaptureDetailsState extends State<CaptureDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(child: _buildContents(context)),
    );
  }

  Widget _buildContents(BuildContext context) {
    return Column(children: [
      Container(
        height: 600,
        color: Colors.red,
        child: Center(
          child: RaisedButton(
            child: Text('Back'),
            onPressed: () => Navigator.of(context).pop(5),
          ),
        ),
      ),
      Container(height: 600, color: Colors.green),
      Container(height: 600, color: Colors.blue),
    ]);
  }
}
