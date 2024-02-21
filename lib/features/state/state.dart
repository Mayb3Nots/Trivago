import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:trivago/converter/date_time_range_converter.dart';
import 'package:trivago/models/room_models/room_model_data.dart';

part 'state.freezed.dart';
part 'state.g.dart';

//dart run build_runner watch -d
@freezed
class HomeState with _$HomeState {
  const HomeState._();
  @DateTimeRangeConverter()
  const factory HomeState({
    required DateTime selectedDate,
    DateTimeRange? timeRange,
    String? customerName,
    String? id,
    int? totalPrice,
    DistrictsID? districtID,
    int? personCount,
    bool? byCash,
    bool? hasBreakfast,
    String? roomName,
    bool? unknownBool1,
    bool? unknownBool2,
    bool? unknownBool3,
    int? phoneNumber,
    int? roomBooked,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}
