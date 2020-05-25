import 'package:json_annotation/json_annotation.dart';

part 'capture_attributes.g.dart';

@JsonSerializable(nullable: false, createToJson: false)
class CaptureAttributeOption {
  String question;

  @JsonKey(name: 'options')
  List<String> answers;

  CaptureAttributeOption(this.question, this.answers);

  factory CaptureAttributeOption.fromJson(Map<String, dynamic> json) => _$CaptureAttributeOptionFromJson(json);
}

@JsonSerializable(nullable: false, createToJson: false)
class CaptureAttributes {
  List<CaptureAttributeOption> sections;

  CaptureAttributes(this.sections);

  factory CaptureAttributes.fromJson(Map<String, dynamic> json) => _$CaptureAttributesFromJson(json);
}
