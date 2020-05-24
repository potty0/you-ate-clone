import 'package:json_annotation/json_annotation.dart';

part 'capture.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake, createToJson: false)
class Capture {
  @JsonKey(name: 'image_url')
  final String imagePath;

  @JsonKey(fromJson: parseEpochTimestamp)
  final DateTime timestamp;

  final bool offTrack;

  Capture(this.imagePath, this.timestamp, this.offTrack);

  factory Capture.fromJson(Map<String, dynamic> json) => _$CaptureFromJson(json);

  @override
  String toString() => 'image url:$imagePath, timestamp:$timestamp, off track:$offTrack';
}

@JsonSerializable(nullable: false, createToJson: false)
class CaptureHistory {
  @JsonKey(name: 'captures')
  List<Capture> items;

  CaptureHistory(this.items);

  factory CaptureHistory.fromJson(Map<String, dynamic> json) => _$CaptureHistoryFromJson(json);
}

DateTime parseEpochTimestamp(int timestamp) => DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
