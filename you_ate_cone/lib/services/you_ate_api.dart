import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:youatecone/capture/capture.dart';
import 'package:youatecone/capture/capture_attributes.dart';
import 'package:http/http.dart' as http;

class YouAteApi {
  Future<List<Capture>> getCaptures() async {
    final response = await http.get('https://dl.dropbox.com/s/80mc6b5fqgxfvc5/basic_captures.json');
    final jsonContent = json.decode(response.body);
    return CaptureHistory.fromJson(jsonContent).items;
  }

  Future<List<CaptureAttributeOption>> getCaptureAttributeOptions() async {
    String jsonString = await rootBundle.loadString('assets/data/capture_attibutes.json');
    final jsonContent = json.decode(jsonString);
    return CaptureAttributes.fromJson(jsonContent).sections;
  }
}
