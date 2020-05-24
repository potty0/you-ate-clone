import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youatecone/capture/capture.dart';
import 'package:youatecone/capture/capture_list.dart';

class CaptureOverviewLanding extends StatefulWidget {
  @override
  _CaptureOverviewLandingState createState() => _CaptureOverviewLandingState();
}

class _CaptureOverviewLandingState extends State<CaptureOverviewLanding> {
  List<Capture> _captures;

  @override
  void initState() {
    _loadCaptures();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CaptureList(captures: _captures ?? []),
    );
  }

  Future<void> _loadCaptures() async {
    String jsonString = await rootBundle.loadString('assets/data/basic_captures.json');
    final jsonContent = json.decode(jsonString);
    _captures = CaptureHistory.fromJson(jsonContent).items;
    print('history items:$_captures');
  }
}
