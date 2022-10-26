// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'swaggermodel.models.swagger.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomTypeModel _$RoomTypeModelFromJson(Map<String, dynamic> json) =>
    RoomTypeModel(
      bedType: roomTypeModelBedTypeFromJson(json['bedType']),
      guests: json['guests'] as int?,
      roomTypeId: json['roomTypeId'] as num?,
      typeName: json['typeName'] as String?,
    );

Map<String, dynamic> _$RoomTypeModelToJson(RoomTypeModel instance) =>
    <String, dynamic>{
      'bedType': roomTypeModelBedTypeToJson(instance.bedType),
      'guests': instance.guests,
      'roomTypeId': instance.roomTypeId,
      'typeName': instance.typeName,
    };

BookingModel _$BookingModelFromJson(Map<String, dynamic> json) => BookingModel(
      bookingDate: json['bookingDate'] as String?,
      bookingId: json['bookingId'] as num?,
      code: json['code'] as String?,
      customerName: json['customerName'] as String?,
      deposit: json['deposit'] as String?,
      details: json['details'] as String?,
      guests: json['guests'] as int?,
      nightNumbers: json['nightNumbers'] as int?,
      paid: bookingModelPaidFromJson(json['paid']),
      roomId: json['roomId'] as int?,
      sourceBooking: bookingModelSourceBookingFromJson(json['sourceBooking']),
      total: json['total'] as String?,
    );

Map<String, dynamic> _$BookingModelToJson(BookingModel instance) =>
    <String, dynamic>{
      'bookingDate': instance.bookingDate,
      'bookingId': instance.bookingId,
      'code': instance.code,
      'customerName': instance.customerName,
      'deposit': instance.deposit,
      'details': instance.details,
      'guests': instance.guests,
      'nightNumbers': instance.nightNumbers,
      'paid': bookingModelPaidToJson(instance.paid),
      'roomId': instance.roomId,
      'sourceBooking': bookingModelSourceBookingToJson(instance.sourceBooking),
      'total': instance.total,
    };

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      roomId: json['roomId'] as num?,
      roomNumber: json['roomNumber'] as int?,
      roomTypeModel: json['roomTypeModel'] == null
          ? null
          : RoomTypeModel.fromJson(
              json['roomTypeModel'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'roomId': instance.roomId,
      'roomNumber': instance.roomNumber,
      'roomTypeModel': instance.roomTypeModel?.toJson(),
    };
