import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youatecone/capture/capture_attributes.dart';
import 'package:youatecone/content/cler_content.dart';

class CaptureDetailsViewModel extends ChangeNotifier with CLERModel {
  @override
  bool get loading => _loading;

  @override
  String get error => null;

  @override
  bool get hasData => sections.isNotEmpty;

  List<CaptureAttributeOption> get sections => _sections ?? [];

  bool _loading = false;
  List<CaptureAttributeOption> _sections;

  Future<void> updateContents() async {
    if (_sections != null || _loading) return;
    _setLoadingAndNotify(true);

    String jsonString = await rootBundle.loadString('assets/data/capture_attibutes.json');
    final jsonContent = json.decode(jsonString);
    _sections = CaptureAttributes.fromJson(jsonContent).sections;

    _setLoadingAndNotify(false);
  }

  void _setLoadingAndNotify(bool loading) {
    _loading = loading;
    notifyListeners();
  }
}
