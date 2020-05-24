// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Capture _$CaptureFromJson(Map<String, dynamic> json) {
  return Capture(
    Uri.parse(json['image_uri'] as String),
    DateTime.parse(json['timestamp'] as String),
    json['off_track'] as bool,
  );
}

CaptureList _$CaptureListFromJson(Map<String, dynamic> json) {
  return CaptureList(
    (json['captures'] as List)
        .map((e) => Capture.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
