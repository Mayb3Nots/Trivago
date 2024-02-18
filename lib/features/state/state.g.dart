// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HomeStateImpl _$$HomeStateImplFromJson(Map<String, dynamic> json) =>
    _$HomeStateImpl(
      selectedDate: DateTime.parse(json['selectedDate'] as String),
      timeRange: _$JsonConverterFromJson<Map<String, dynamic>, DateTimeRange>(
          json['timeRange'], const DateTimeRangeConverter().fromJson),
      customerName: json['customerName'] as String?,
      id: json['id'] as String?,
      totalPrice: json['totalPrice'] as int?,
      districtID: $enumDecodeNullable(_$DistrictsIDEnumMap, json['districtID']),
      personCount: json['personCount'] as int?,
      byCash: json['byCash'] as bool?,
      hasBreakfast: json['hasBreakfast'] as bool?,
      roomName: json['roomName'] as String?,
      unknownBool1: json['unknownBool1'] as bool?,
      unknownBool2: json['unknownBool2'] as bool?,
      unknownBool3: json['unknownBool3'] as bool?,
      phoneNumber: json['phoneNumber'] as int?,
      roomBooked: json['roomBooked'] as int?,
    );

Map<String, dynamic> _$$HomeStateImplToJson(_$HomeStateImpl instance) =>
    <String, dynamic>{
      'selectedDate': instance.selectedDate.toIso8601String(),
      'timeRange': _$JsonConverterToJson<Map<String, dynamic>, DateTimeRange>(
          instance.timeRange, const DateTimeRangeConverter().toJson),
      'customerName': instance.customerName,
      'id': instance.id,
      'totalPrice': instance.totalPrice,
      'districtID': _$DistrictsIDEnumMap[instance.districtID],
      'personCount': instance.personCount,
      'byCash': instance.byCash,
      'hasBreakfast': instance.hasBreakfast,
      'roomName': instance.roomName,
      'unknownBool1': instance.unknownBool1,
      'unknownBool2': instance.unknownBool2,
      'unknownBool3': instance.unknownBool3,
      'phoneNumber': instance.phoneNumber,
      'roomBooked': instance.roomBooked,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$DistrictsIDEnumMap = {
  DistrictsID.A: 'A',
  DistrictsID.B: 'B',
  DistrictsID.C: 'C',
  DistrictsID.D: 'D',
  DistrictsID.E: 'E',
  DistrictsID.F: 'F',
  DistrictsID.G: 'G',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
