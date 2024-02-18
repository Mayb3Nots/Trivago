// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booked_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BookingDataImpl _$$BookingDataImplFromJson(Map<String, dynamic> json) =>
    _$BookingDataImpl(
      vacantDuration: const DateTimeRangeConverter()
          .fromJson(json['vacantDuration'] as Map<String, dynamic>),
      customerName: json['customerName'] as String,
      totalPrice: json['totalPrice'] as int,
      id: json['id'] as String,
      personCount: json['personCount'] as int,
      phoneNumber: json['phoneNumber'] as int,
      byCash: json['byCash'] as bool,
      districtID: $enumDecode(_$DistrictsIDEnumMap, json['districtID']),
      roomName: json['roomName'] as String,
      hasBreakfastService: json['hasBreakfastService'] as bool,
      unknownBool1: json['unknownBool1'] as bool,
      unknownBool2: json['unknownBool2'] as bool,
      unknownBool3: json['unknownBool3'] as bool,
    );

Map<String, dynamic> _$$BookingDataImplToJson(_$BookingDataImpl instance) =>
    <String, dynamic>{
      'vacantDuration':
          const DateTimeRangeConverter().toJson(instance.vacantDuration),
      'customerName': instance.customerName,
      'totalPrice': instance.totalPrice,
      'id': instance.id,
      'personCount': instance.personCount,
      'phoneNumber': instance.phoneNumber,
      'byCash': instance.byCash,
      'districtID': _$DistrictsIDEnumMap[instance.districtID]!,
      'roomName': instance.roomName,
      'hasBreakfastService': instance.hasBreakfastService,
      'unknownBool1': instance.unknownBool1,
      'unknownBool2': instance.unknownBool2,
      'unknownBool3': instance.unknownBool3,
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

_$GroupBookingDataImpl _$$GroupBookingDataImplFromJson(
        Map<String, dynamic> json) =>
    _$GroupBookingDataImpl(
      vacantDuration: const DateTimeRangeConverter()
          .fromJson(json['vacantDuration'] as Map<String, dynamic>),
      customerName: json['customerName'] as String,
      id: json['id'] as String,
      totalPrice: json['totalPrice'] as int,
      personCount: json['personCount'] as int,
      phoneNumber: json['phoneNumber'] as int,
      byCash: json['byCash'] as bool,
      roomBooked: json['roomBooked'] as int,
      districtID: $enumDecode(_$DistrictsIDEnumMap, json['districtID']),
      hasBreakfastService: json['hasBreakfastService'] as bool,
      unknownBool1: json['unknownBool1'] as bool,
      unknownBool2: json['unknownBool2'] as bool,
      unknownBool3: json['unknownBool3'] as bool,
    );

Map<String, dynamic> _$$GroupBookingDataImplToJson(
        _$GroupBookingDataImpl instance) =>
    <String, dynamic>{
      'vacantDuration':
          const DateTimeRangeConverter().toJson(instance.vacantDuration),
      'customerName': instance.customerName,
      'id': instance.id,
      'totalPrice': instance.totalPrice,
      'personCount': instance.personCount,
      'phoneNumber': instance.phoneNumber,
      'byCash': instance.byCash,
      'roomBooked': instance.roomBooked,
      'districtID': _$DistrictsIDEnumMap[instance.districtID]!,
      'hasBreakfastService': instance.hasBreakfastService,
      'unknownBool1': instance.unknownBool1,
      'unknownBool2': instance.unknownBool2,
      'unknownBool3': instance.unknownBool3,
    };
