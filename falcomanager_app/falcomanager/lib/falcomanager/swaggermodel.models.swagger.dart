// ignore_for_file: type=lint

import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';
import 'dart:convert';
import 'swaggermodel.enums.swagger.dart' as enums;

part 'swaggermodel.models.swagger.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomTypeModel {
  RoomTypeModel({
    this.bedType,
    this.guests,
    this.roomTypeId,
    this.typeName,
  });

  factory RoomTypeModel.fromJson(Map<String, dynamic> json) =>
      _$RoomTypeModelFromJson(json);

  @JsonKey(
      name: 'bedType',
      toJson: roomTypeModelBedTypeToJson,
      fromJson: roomTypeModelBedTypeFromJson)
  final enums.RoomTypeModelBedType? bedType;
  @JsonKey(name: 'guests')
  final int? guests;
  @JsonKey(name: 'roomTypeId')
  final num? roomTypeId;
  @JsonKey(name: 'typeName')
  final String? typeName;
  static const fromJsonFactory = _$RoomTypeModelFromJson;
  static const toJsonFactory = _$RoomTypeModelToJson;
  Map<String, dynamic> toJson() => _$RoomTypeModelToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RoomTypeModel &&
            (identical(other.bedType, bedType) ||
                const DeepCollectionEquality()
                    .equals(other.bedType, bedType)) &&
            (identical(other.guests, guests) ||
                const DeepCollectionEquality().equals(other.guests, guests)) &&
            (identical(other.roomTypeId, roomTypeId) ||
                const DeepCollectionEquality()
                    .equals(other.roomTypeId, roomTypeId)) &&
            (identical(other.typeName, typeName) ||
                const DeepCollectionEquality()
                    .equals(other.typeName, typeName)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(bedType) ^
      const DeepCollectionEquality().hash(guests) ^
      const DeepCollectionEquality().hash(roomTypeId) ^
      const DeepCollectionEquality().hash(typeName) ^
      runtimeType.hashCode;
}

extension $RoomTypeModelExtension on RoomTypeModel {
  RoomTypeModel copyWith(
      {enums.RoomTypeModelBedType? bedType,
      int? guests,
      num? roomTypeId,
      String? typeName}) {
    return RoomTypeModel(
        bedType: bedType ?? this.bedType,
        guests: guests ?? this.guests,
        roomTypeId: roomTypeId ?? this.roomTypeId,
        typeName: typeName ?? this.typeName);
  }
}

@JsonSerializable(explicitToJson: true)
class BookingModel {
  BookingModel({
    this.bookingDate,
    this.bookingId,
    this.code,
    this.customerName,
    this.deposit,
    this.details,
    this.guests,
    this.nightNumbers,
    this.paid,
    this.roomId,
    this.sourceBooking,
    this.total,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) =>
      _$BookingModelFromJson(json);

  @JsonKey(name: 'bookingDate')
  final String? bookingDate;
  @JsonKey(name: 'bookingId')
  final num? bookingId;
  @JsonKey(name: 'code')
  final String? code;
  @JsonKey(name: 'customerName')
  final String? customerName;
  @JsonKey(name: 'deposit')
  final String? deposit;
  @JsonKey(name: 'details')
  final String? details;
  @JsonKey(name: 'guests')
  final int? guests;
  @JsonKey(name: 'nightNumbers')
  final int? nightNumbers;
  @JsonKey(
      name: 'paid',
      toJson: bookingModelPaidToJson,
      fromJson: bookingModelPaidFromJson)
  final enums.BookingModelPaid? paid;
  @JsonKey(name: 'roomId')
  final int? roomId;
  @JsonKey(
      name: 'sourceBooking',
      toJson: bookingModelSourceBookingToJson,
      fromJson: bookingModelSourceBookingFromJson)
  final enums.BookingModelSourceBooking? sourceBooking;
  @JsonKey(name: 'total')
  final String? total;
  static const fromJsonFactory = _$BookingModelFromJson;
  static const toJsonFactory = _$BookingModelToJson;
  Map<String, dynamic> toJson() => _$BookingModelToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is BookingModel &&
            (identical(other.bookingDate, bookingDate) ||
                const DeepCollectionEquality()
                    .equals(other.bookingDate, bookingDate)) &&
            (identical(other.bookingId, bookingId) ||
                const DeepCollectionEquality()
                    .equals(other.bookingId, bookingId)) &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.customerName, customerName) ||
                const DeepCollectionEquality()
                    .equals(other.customerName, customerName)) &&
            (identical(other.deposit, deposit) ||
                const DeepCollectionEquality()
                    .equals(other.deposit, deposit)) &&
            (identical(other.details, details) ||
                const DeepCollectionEquality()
                    .equals(other.details, details)) &&
            (identical(other.guests, guests) ||
                const DeepCollectionEquality().equals(other.guests, guests)) &&
            (identical(other.nightNumbers, nightNumbers) ||
                const DeepCollectionEquality()
                    .equals(other.nightNumbers, nightNumbers)) &&
            (identical(other.paid, paid) ||
                const DeepCollectionEquality().equals(other.paid, paid)) &&
            (identical(other.roomId, roomId) ||
                const DeepCollectionEquality().equals(other.roomId, roomId)) &&
            (identical(other.sourceBooking, sourceBooking) ||
                const DeepCollectionEquality()
                    .equals(other.sourceBooking, sourceBooking)) &&
            (identical(other.total, total) ||
                const DeepCollectionEquality().equals(other.total, total)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(bookingDate) ^
      const DeepCollectionEquality().hash(bookingId) ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(customerName) ^
      const DeepCollectionEquality().hash(deposit) ^
      const DeepCollectionEquality().hash(details) ^
      const DeepCollectionEquality().hash(guests) ^
      const DeepCollectionEquality().hash(nightNumbers) ^
      const DeepCollectionEquality().hash(paid) ^
      const DeepCollectionEquality().hash(roomId) ^
      const DeepCollectionEquality().hash(sourceBooking) ^
      const DeepCollectionEquality().hash(total) ^
      runtimeType.hashCode;
}

extension $BookingModelExtension on BookingModel {
  BookingModel copyWith(
      {String? bookingDate,
      num? bookingId,
      String? code,
      String? customerName,
      String? deposit,
      String? details,
      int? guests,
      int? nightNumbers,
      enums.BookingModelPaid? paid,
      int? roomId,
      enums.BookingModelSourceBooking? sourceBooking,
      String? total}) {
    return BookingModel(
        bookingDate: bookingDate ?? this.bookingDate,
        bookingId: bookingId ?? this.bookingId,
        code: code ?? this.code,
        customerName: customerName ?? this.customerName,
        deposit: deposit ?? this.deposit,
        details: details ?? this.details,
        guests: guests ?? this.guests,
        nightNumbers: nightNumbers ?? this.nightNumbers,
        paid: paid ?? this.paid,
        roomId: roomId ?? this.roomId,
        sourceBooking: sourceBooking ?? this.sourceBooking,
        total: total ?? this.total);
  }
}

@JsonSerializable(explicitToJson: true)
class RoomModel {
  RoomModel({
    this.roomId,
    this.roomNumber,
    this.roomTypeModel,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);

  @JsonKey(name: 'roomId')
  final num? roomId;
  @JsonKey(name: 'roomNumber')
  final int? roomNumber;
  @JsonKey(name: 'roomTypeModel')
  final RoomTypeModel? roomTypeModel;
  static const fromJsonFactory = _$RoomModelFromJson;
  static const toJsonFactory = _$RoomModelToJson;
  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  @override
  String toString() => jsonEncode(this);

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is RoomModel &&
            (identical(other.roomId, roomId) ||
                const DeepCollectionEquality().equals(other.roomId, roomId)) &&
            (identical(other.roomNumber, roomNumber) ||
                const DeepCollectionEquality()
                    .equals(other.roomNumber, roomNumber)) &&
            (identical(other.roomTypeModel, roomTypeModel) ||
                const DeepCollectionEquality()
                    .equals(other.roomTypeModel, roomTypeModel)));
  }

  @override
  int get hashCode =>
      const DeepCollectionEquality().hash(roomId) ^
      const DeepCollectionEquality().hash(roomNumber) ^
      const DeepCollectionEquality().hash(roomTypeModel) ^
      runtimeType.hashCode;
}

extension $RoomModelExtension on RoomModel {
  RoomModel copyWith(
      {num? roomId, int? roomNumber, RoomTypeModel? roomTypeModel}) {
    return RoomModel(
        roomId: roomId ?? this.roomId,
        roomNumber: roomNumber ?? this.roomNumber,
        roomTypeModel: roomTypeModel ?? this.roomTypeModel);
  }
}

String? roomTypeModelBedTypeToJson(
    enums.RoomTypeModelBedType? roomTypeModelBedType) {
  return enums.$RoomTypeModelBedTypeMap[roomTypeModelBedType];
}

enums.RoomTypeModelBedType roomTypeModelBedTypeFromJson(
  Object? roomTypeModelBedType, [
  enums.RoomTypeModelBedType? defaultValue,
]) {
  if (roomTypeModelBedType is String) {
    return enums.$RoomTypeModelBedTypeMap.entries
        .firstWhere(
            (element) =>
                element.value.toLowerCase() ==
                roomTypeModelBedType.toLowerCase(),
            orElse: () => const MapEntry(
                enums.RoomTypeModelBedType.swaggerGeneratedUnknown, ''))
        .key;
  }

  final parsedResult = defaultValue == null
      ? null
      : enums.$RoomTypeModelBedTypeMap.entries
          .firstWhereOrNull((element) => element.value == defaultValue)
          ?.key;

  return parsedResult ??
      defaultValue ??
      enums.RoomTypeModelBedType.swaggerGeneratedUnknown;
}

List<String> roomTypeModelBedTypeListToJson(
    List<enums.RoomTypeModelBedType>? roomTypeModelBedType) {
  if (roomTypeModelBedType == null) {
    return [];
  }

  return roomTypeModelBedType
      .map((e) => enums.$RoomTypeModelBedTypeMap[e]!)
      .toList();
}

List<enums.RoomTypeModelBedType> roomTypeModelBedTypeListFromJson(
  List? roomTypeModelBedType, [
  List<enums.RoomTypeModelBedType>? defaultValue,
]) {
  if (roomTypeModelBedType == null) {
    return defaultValue ?? [];
  }

  return roomTypeModelBedType
      .map((e) => roomTypeModelBedTypeFromJson(e.toString()))
      .toList();
}

String? bookingModelPaidToJson(enums.BookingModelPaid? bookingModelPaid) {
  return enums.$BookingModelPaidMap[bookingModelPaid];
}

enums.BookingModelPaid bookingModelPaidFromJson(
  Object? bookingModelPaid, [
  enums.BookingModelPaid? defaultValue,
]) {
  if (bookingModelPaid is String) {
    return enums.$BookingModelPaidMap.entries
        .firstWhere(
            (element) =>
                element.value.toLowerCase() == bookingModelPaid.toLowerCase(),
            orElse: () => const MapEntry(
                enums.BookingModelPaid.swaggerGeneratedUnknown, ''))
        .key;
  }

  final parsedResult = defaultValue == null
      ? null
      : enums.$BookingModelPaidMap.entries
          .firstWhereOrNull((element) => element.value == defaultValue)
          ?.key;

  return parsedResult ??
      defaultValue ??
      enums.BookingModelPaid.swaggerGeneratedUnknown;
}

List<String> bookingModelPaidListToJson(
    List<enums.BookingModelPaid>? bookingModelPaid) {
  if (bookingModelPaid == null) {
    return [];
  }

  return bookingModelPaid.map((e) => enums.$BookingModelPaidMap[e]!).toList();
}

List<enums.BookingModelPaid> bookingModelPaidListFromJson(
  List? bookingModelPaid, [
  List<enums.BookingModelPaid>? defaultValue,
]) {
  if (bookingModelPaid == null) {
    return defaultValue ?? [];
  }

  return bookingModelPaid
      .map((e) => bookingModelPaidFromJson(e.toString()))
      .toList();
}

String? bookingModelSourceBookingToJson(
    enums.BookingModelSourceBooking? bookingModelSourceBooking) {
  return enums.$BookingModelSourceBookingMap[bookingModelSourceBooking];
}

enums.BookingModelSourceBooking bookingModelSourceBookingFromJson(
  Object? bookingModelSourceBooking, [
  enums.BookingModelSourceBooking? defaultValue,
]) {
  if (bookingModelSourceBooking is String) {
    return enums.$BookingModelSourceBookingMap.entries
        .firstWhere(
            (element) =>
                element.value.toLowerCase() ==
                bookingModelSourceBooking.toLowerCase(),
            orElse: () => const MapEntry(
                enums.BookingModelSourceBooking.swaggerGeneratedUnknown, ''))
        .key;
  }

  final parsedResult = defaultValue == null
      ? null
      : enums.$BookingModelSourceBookingMap.entries
          .firstWhereOrNull((element) => element.value == defaultValue)
          ?.key;

  return parsedResult ??
      defaultValue ??
      enums.BookingModelSourceBooking.swaggerGeneratedUnknown;
}

List<String> bookingModelSourceBookingListToJson(
    List<enums.BookingModelSourceBooking>? bookingModelSourceBooking) {
  if (bookingModelSourceBooking == null) {
    return [];
  }

  return bookingModelSourceBooking
      .map((e) => enums.$BookingModelSourceBookingMap[e]!)
      .toList();
}

List<enums.BookingModelSourceBooking> bookingModelSourceBookingListFromJson(
  List? bookingModelSourceBooking, [
  List<enums.BookingModelSourceBooking>? defaultValue,
]) {
  if (bookingModelSourceBooking == null) {
    return defaultValue ?? [];
  }

  return bookingModelSourceBooking
      .map((e) => bookingModelSourceBookingFromJson(e.toString()))
      .toList();
}

// ignore: unused_element
String? _dateToJson(DateTime? date) {
  if (date == null) {
    return null;
  }

  final year = date.year.toString();
  final month = date.month < 10 ? '0${date.month}' : date.month.toString();
  final day = date.day < 10 ? '0${date.day}' : date.day.toString();

  return '$year-$month-$day';
}
