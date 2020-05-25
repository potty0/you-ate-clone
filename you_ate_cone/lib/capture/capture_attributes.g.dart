// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_attributes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptureAttributeOption _$CaptureAttributeOptionFromJson(
    Map<String, dynamic> json) {
  return CaptureAttributeOption(
    json['question'] as String,
    (json['options'] as List).map((e) => e as String).toList(),
  );
}

CaptureAttributes _$CaptureAttributesFromJson(Map<String, dynamic> json) {
  return CaptureAttributes(
    (json['sections'] as List)
        .map((e) => CaptureAttributeOption.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}
