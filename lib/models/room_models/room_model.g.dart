// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      name: json['name'] as String,
      defaultPrice: json['defaultPrice'] as int,
      district: $enumDecode(_$DistrictsIDEnumMap, json['district']),
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'defaultPrice': instance.defaultPrice,
      'district': _$DistrictsIDEnumMap[instance.district]!,
    };

const _$DistrictsIDEnumMap = {
  DistrictsID.A: 'A',
  DistrictsID.B: 'B',
  DistrictsID.C: 'C',
  DistrictsID.D: 'D',
  DistrictsID.E: 'E',
  DistrictsID.F: 'F',
  DistrictsID.G: 'G',
};
