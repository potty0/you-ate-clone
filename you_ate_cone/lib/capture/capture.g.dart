// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Capture _$CaptureFromJson(Map<String, dynamic> json) {
  return Capture(
    json['image_url'] as String,
    parseEpochTimestamp(json['timestamp'] as int),
    json['off_track'] as bool,
  );
}

CaptureHistory _$CaptureHistoryFromJson(Map<String, dynamic> json) {
  return CaptureHistory(
    (json['captures'] as List)
        .map((e) => Capture.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
