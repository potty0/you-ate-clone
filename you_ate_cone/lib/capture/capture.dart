import 'package:json_annotation/json_annotation.dart';

part 'capture.g.dart';

@JsonSerializable(nullable: false, fieldRename: FieldRename.snake, createToJson: false)
class Capture {
  final Uri imageUri;
  final DateTime timestamp;
  final bool offTrack;

  Capture(this.imageUri, this.timestamp, this.offTrack);

  factory Capture.fromJson(Map<String, dynamic> json) => _$CaptureFromJson(json);
}

@JsonSerializable(nullable: false, createToJson: false)
class CaptureList {
  @JsonKey(name: 'captures')
  List<Capture> history;

  CaptureList(this.history);

  factory CaptureList.fromJson(Map<String, dynamic> json) => _$CaptureListFromJson(json);
}
