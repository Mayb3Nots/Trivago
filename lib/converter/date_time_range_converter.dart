import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class DateTimeRangeConverter
    implements JsonConverter<DateTimeRange, Map<String, dynamic>> {
  const DateTimeRangeConverter();
  @override
  DateTimeRange fromJson(Map<String, dynamic> json) {
    if (json['start'] is Timestamp) {
      return DateTimeRange(
          start: (json['start'] as Timestamp).toDate(),
          end: (json['end'] as Timestamp).toDate());
    } else {
      return DateTimeRange(start: json['start'], end: json['end']);
    }
  }

  @override
  Map<String, DateTime> toJson(DateTimeRange object) {
    return {'start': object.start, 'end': object.end};
  }
}

extension DateTimeExtension on DateTime {
  DateTime get dateOnly => DateTime(year, month, day);
  bool? isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.dateOnly.isAtSameMomentAs(date.dateOnly);
    return isAtSameMomentAs || date.dateOnly.isAfter(dateTime.dateOnly);
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.dateOnly.isAtSameMomentAs(date.dateOnly);
    return isAtSameMomentAs || date.dateOnly.isBefore(dateTime.dateOnly);
  }

  bool isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final date = this;
    final isAfter = date.isAfterOrEqualTo(fromDateTime) ?? false;
    final isBefore = date.isBeforeOrEqualTo(toDateTime) ?? false;
    return isAfter && isBefore;
  }
}
