import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:trivago/models/room_models/room_model_data.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

enum RoomStatus { occupied, vacant, unavailable }

@freezed
class RoomModel with _$RoomModel {
  @JsonSerializable()
  const RoomModel._();
  const factory RoomModel(
      {required String name,
      required int defaultPrice,
      required DistrictsID district}) = _Room;

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
}
