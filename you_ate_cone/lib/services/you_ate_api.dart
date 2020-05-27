import 'dart:convert';

import 'package:youatecone/capture/capture.dart';
import 'package:http/http.dart' as http;

class YouAteApi {
  Future<List<Capture>> getCaptures() async {
    return http
        .get('https://dl.dropbox.com/s/80mc6b5fqgxfvc5/basic_captures.json')
        .then((response) => json.decode(response.body))
        .then((json) => CaptureHistory.fromJson(json).items);
  }
}
