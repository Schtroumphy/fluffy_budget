import 'package:flutter/widgets.dart';
import 'package:json_annotation/json_annotation.dart';

class IconDataConverter implements JsonConverter<IconData, int> {
  const IconDataConverter();

  @override
  IconData fromJson(int codePoint) => IconData(codePoint, fontFamily: 'MaterialIcons');

  @override
  int toJson(IconData icon) => icon.codePoint;
}