import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:youatecone/capture/capture.dart';
import 'package:youatecone/capture/capture_attributes.dart';

class YouAteApi {
  Future<List<Capture>> getCaptures() async {
    String jsonString = await rootBundle.loadString('assets/data/basic_captures.json');
    final jsonContent = json.decode(jsonString);
    return CaptureHistory.fromJson(jsonContent).items;
  }

  Future<List<CaptureAttributeOption>> getCaptureAttributes() async {
    String jsonString = await rootBundle.loadString('assets/data/capture_attributes.json');
    final jsonContent = json.decode(jsonString);
    return CaptureAttributes.fromJson(jsonContent).sections;
  }
}
