import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youatecone/capture/capture.dart';
import 'package:youatecone/capture/capture_list.dart';

class CaptureOverviewLandingViewModel extends ChangeNotifier {
  bool get loading => _loading;

  List<Capture> get captures => _captures;

  List<Capture> _captures;
  bool _loading = false;

  Future<void> updateContents() async {
    if (_captures != null) return;
    _setLoadingAndNotify(true);

    _captures = await _loadModelData();
    await Future.delayed(Duration(seconds: 2));

    _setLoadingAndNotify(false);
  }

  Future<List<Capture>> _loadModelData() async {
    String jsonString = await rootBundle.loadString('assets/data/basic_captures.json');
    final jsonContent = json.decode(jsonString);
    return CaptureHistory.fromJson(jsonContent).items;
  }

  void _setLoadingAndNotify(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}

class CaptureOverviewLanding extends StatefulWidget {
  @override
  _CaptureOverviewLandingState createState() => _CaptureOverviewLandingState();
}

class _CaptureOverviewLandingState extends State<CaptureOverviewLanding> {
  CaptureOverviewLandingViewModel _model = CaptureOverviewLandingViewModel();

  @override
  void initState() {
    _model.addListener(_updateContents);
    _model.updateContents();

    super.initState();
  }

  @override
  void dispose() {
    _model.removeListener(_updateContents);
    super.dispose();
  }

  void _updateContents() => setState(() {});

  @override
  Widget build(BuildContext context) {
    if (_model.loading) return _buildLoadingIndicator();

    return Container(
      child: CaptureList(captures: _model.captures),
    );
  }

  Widget _buildLoadingIndicator() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
