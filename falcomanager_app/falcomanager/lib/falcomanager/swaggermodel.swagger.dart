import 'swaggermodel.models.swagger.dart';
import 'package:chopper/chopper.dart';

import 'client_mapping.dart';
import 'package:chopper/chopper.dart' as chopper;
import 'swaggermodel.enums.swagger.dart' as enums;
export 'swaggermodel.enums.swagger.dart';
export 'swaggermodel.models.swagger.dart';

part 'swaggermodel.swagger.chopper.dart';

// **************************************************************************
// SwaggerChopperGenerator
// **************************************************************************

@ChopperApi()
abstract class Swaggermodel extends ChopperService {
  static Swaggermodel create(
      {ChopperClient? client,
      Authenticator? authenticator,
      String? baseUrl,
      Iterable<dynamic>? interceptors}) {
    if (client != null) {
      return _$Swaggermodel(client);
    }

    final newClient = ChopperClient(
        services: [_$Swaggermodel()],
        converter: $JsonSerializableConverter(),
        interceptors: interceptors ?? [],
        authenticator: authenticator,
        baseUrl: baseUrl ?? 'http://localhost:8090/falcoservice');
    return _$Swaggermodel(newClient);
  }

  ///addDay
  ///@param bookingid bookingid
  ///@param roomid roomid
  ///@param reservationdate reservationdate
  ///@param nights nights
  Future<chopper.Response>
      apiV1BookingAdddaytobookingBookingidRoomidReservationdateNightsPost(
          {required int? bookingid,
          required int? roomid,
          required String? reservationdate,
          required int? nights}) {
    return _apiV1BookingAdddaytobookingBookingidRoomidReservationdateNightsPost(
        bookingid: bookingid,
        roomid: roomid,
        reservationdate: reservationdate,
        nights: nights);
  }

  ///addDay
  ///@param bookingid bookingid
  ///@param roomid roomid
  ///@param reservationdate reservationdate
  ///@param nights nights
  @Post(
      path:
          '/api/v1/booking/adddaytobooking/{bookingid}/{roomid}/{reservationdate}/{nights}',
      optionalBody: true)
  Future<chopper.Response>
      _apiV1BookingAdddaytobookingBookingidRoomidReservationdateNightsPost(
          {@Path('bookingid') required int? bookingid,
          @Path('roomid') required int? roomid,
          @Path('reservationdate') required String? reservationdate,
          @Path('nights') required int? nights});

  ///delete
  ///@param bookingId
  ///@param customerName
  ///@param code
  ///@param roomId
  ///@param nightNumbers
  ///@param bookingDate
  ///@param sourceBooking
  ///@param details
  ///@param paid
  ///@param deposit
  ///@param guests
  ///@param total
  Future<chopper.Response> apiV1BookingDeleteDelete(
      {int? bookingId,
      String? customerName,
      String? code,
      int? roomId,
      int? nightNumbers,
      String? bookingDate,
      String? sourceBooking,
      String? details,
      String? paid,
      String? deposit,
      int? guests,
      String? total}) {
    return _apiV1BookingDeleteDelete(
        bookingId: bookingId,
        customerName: customerName,
        code: code,
        roomId: roomId,
        nightNumbers: nightNumbers,
        bookingDate: bookingDate,
        sourceBooking: sourceBooking,
        details: details,
        paid: paid,
        deposit: deposit,
        guests: guests,
        total: total);
  }

  ///delete
  ///@param bookingId
  ///@param customerName
  ///@param code
  ///@param roomId
  ///@param nightNumbers
  ///@param bookingDate
  ///@param sourceBooking
  ///@param details
  ///@param paid
  ///@param deposit
  ///@param guests
  ///@param total
  @Delete(path: '/api/v1/booking/delete')
  Future<chopper.Response> _apiV1BookingDeleteDelete(
      {@Query('bookingId') int? bookingId,
      @Query('customerName') String? customerName,
      @Query('code') String? code,
      @Query('roomId') int? roomId,
      @Query('nightNumbers') int? nightNumbers,
      @Query('bookingDate') String? bookingDate,
      @Query('sourceBooking') String? sourceBooking,
      @Query('details') String? details,
      @Query('paid') String? paid,
      @Query('deposit') String? deposit,
      @Query('guests') int? guests,
      @Query('total') String? total});

  ///deleteBookTypeById
  ///@param code code
  Future<chopper.Response> apiV1BookingDeletebycodeCodeGet(
      {required String? code}) {
    return _apiV1BookingDeletebycodeCodeGet(code: code);
  }

  ///deleteBookTypeById
  ///@param code code
  @Get(path: '/api/v1/booking/deletebycode/{code}')
  Future<chopper.Response> _apiV1BookingDeletebycodeCodeGet(
      {@Path('code') required String? code});

  ///deleteBookTypeById
  ///@param id id
  Future<chopper.Response> apiV1BookingDeletebyidIdGet({required int? id}) {
    return _apiV1BookingDeletebyidIdGet(id: id);
  }

  ///deleteBookTypeById
  ///@param id id
  @Get(path: '/api/v1/booking/deletebyid/{id}')
  Future<chopper.Response> _apiV1BookingDeletebyidIdGet(
      {@Path('id') required int? id});

  ///findByCode
  ///@param code code
  Future<chopper.Response<List<BookingModel>>> apiV1BookingFindByCodeCodeGet(
      {required String? code}) {
    generatedMapping.putIfAbsent(
        BookingModel, () => BookingModel.fromJsonFactory);

    return _apiV1BookingFindByCodeCodeGet(code: code);
  }

  ///findByCode
  ///@param code code
  @Get(path: '/api/v1/booking/findByCode/{code}')
  Future<chopper.Response<List<BookingModel>>> _apiV1BookingFindByCodeCodeGet(
      {@Path('code') required String? code});

  ///retrieveAll
  Future<chopper.Response<List<BookingModel>>> apiV1BookingFindallGet() {
    generatedMapping.putIfAbsent(
        BookingModel, () => BookingModel.fromJsonFactory);

    return _apiV1BookingFindallGet();
  }

  ///retrieveAll
  @Get(path: '/api/v1/booking/findall')
  Future<chopper.Response<List<BookingModel>>> _apiV1BookingFindallGet();

  ///moveReservation
  ///@param bookingId
  ///@param customerName
  ///@param code
  ///@param roomId
  ///@param nightNumbers
  ///@param bookingDate
  ///@param sourceBooking
  ///@param details
  ///@param paid
  ///@param deposit
  ///@param guests
  ///@param total
  Future<chopper.Response> apiV1BookingMovereservationPost(
      {int? bookingId,
      String? customerName,
      String? code,
      int? roomId,
      int? nightNumbers,
      String? bookingDate,
      String? sourceBooking,
      String? details,
      String? paid,
      String? deposit,
      int? guests,
      String? total}) {
    return _apiV1BookingMovereservationPost(
        bookingId: bookingId,
        customerName: customerName,
        code: code,
        roomId: roomId,
        nightNumbers: nightNumbers,
        bookingDate: bookingDate,
        sourceBooking: sourceBooking,
        details: details,
        paid: paid,
        deposit: deposit,
        guests: guests,
        total: total);
  }

  ///moveReservation
  ///@param bookingId
  ///@param customerName
  ///@param code
  ///@param roomId
  ///@param nightNumbers
  ///@param bookingDate
  ///@param sourceBooking
  ///@param details
  ///@param paid
  ///@param deposit
  ///@param guests
  ///@param total
  @Post(path: '/api/v1/booking/movereservation', optionalBody: true)
  Future<chopper.Response> _apiV1BookingMovereservationPost(
      {@Query('bookingId') int? bookingId,
      @Query('customerName') String? customerName,
      @Query('code') String? code,
      @Query('roomId') int? roomId,
      @Query('nightNumbers') int? nightNumbers,
      @Query('bookingDate') String? bookingDate,
      @Query('sourceBooking') String? sourceBooking,
      @Query('details') String? details,
      @Query('paid') String? paid,
      @Query('deposit') String? deposit,
      @Query('guests') int? guests,
      @Query('total') String? total});

  ///save
  ///@param bookingId
  ///@param customerName
  ///@param code
  ///@param roomId
  ///@param nightNumbers
  ///@param bookingDate
  ///@param sourceBooking
  ///@param details
  ///@param paid
  ///@param deposit
  ///@param guests
  ///@param total
  Future<chopper.Response> apiV1BookingSavePost(
      {int? bookingId,
      String? customerName,
      String? code,
      int? roomId,
      int? nightNumbers,
      String? bookingDate,
      String? sourceBooking,
      String? details,
      String? paid,
      String? deposit,
      int? guests,
      String? total}) {
    return _apiV1BookingSavePost(
        bookingId: bookingId,
        customerName: customerName,
        code: code,
        roomId: roomId,
        nightNumbers: nightNumbers,
        bookingDate: bookingDate,
        sourceBooking: sourceBooking,
        details: details,
        paid: paid,
        deposit: deposit,
        guests: guests,
        total: total);
  }

  ///save
  ///@param bookingId
  ///@param customerName
  ///@param code
  ///@param roomId
  ///@param nightNumbers
  ///@param bookingDate
  ///@param sourceBooking
  ///@param details
  ///@param paid
  ///@param deposit
  ///@param guests
  ///@param total
  @Post(path: '/api/v1/booking/save', optionalBody: true)
  Future<chopper.Response> _apiV1BookingSavePost(
      {@Query('bookingId') int? bookingId,
      @Query('customerName') String? customerName,
      @Query('code') String? code,
      @Query('roomId') int? roomId,
      @Query('nightNumbers') int? nightNumbers,
      @Query('bookingDate') String? bookingDate,
      @Query('sourceBooking') String? sourceBooking,
      @Query('details') String? details,
      @Query('paid') String? paid,
      @Query('deposit') String? deposit,
      @Query('guests') int? guests,
      @Query('total') String? total});

  ///updateBooking
  ///@param bookingId
  ///@param customerName
  ///@param code
  ///@param roomId
  ///@param nightNumbers
  ///@param bookingDate
  ///@param sourceBooking
  ///@param details
  ///@param paid
  ///@param deposit
  ///@param guests
  ///@param total
  Future<chopper.Response> apiV1BookingUpdatePut(
      {int? bookingId,
      String? customerName,
      String? code,
      int? roomId,
      int? nightNumbers,
      String? bookingDate,
      String? sourceBooking,
      String? details,
      String? paid,
      String? deposit,
      int? guests,
      String? total}) {
    return _apiV1BookingUpdatePut(
        bookingId: bookingId,
        customerName: customerName,
        code: code,
        roomId: roomId,
        nightNumbers: nightNumbers,
        bookingDate: bookingDate,
        sourceBooking: sourceBooking,
        details: details,
        paid: paid,
        deposit: deposit,
        guests: guests,
        total: total);
  }

  ///updateBooking
  ///@param bookingId
  ///@param customerName
  ///@param code
  ///@param roomId
  ///@param nightNumbers
  ///@param bookingDate
  ///@param sourceBooking
  ///@param details
  ///@param paid
  ///@param deposit
  ///@param guests
  ///@param total
  @Put(path: '/api/v1/booking/update', optionalBody: true)
  Future<chopper.Response> _apiV1BookingUpdatePut(
      {@Query('bookingId') int? bookingId,
      @Query('customerName') String? customerName,
      @Query('code') String? code,
      @Query('roomId') int? roomId,
      @Query('nightNumbers') int? nightNumbers,
      @Query('bookingDate') String? bookingDate,
      @Query('sourceBooking') String? sourceBooking,
      @Query('details') String? details,
      @Query('paid') String? paid,
      @Query('deposit') String? deposit,
      @Query('guests') int? guests,
      @Query('total') String? total});

  ///deleteRoom
  ///@param roomTypeModel.roomTypeId
  ///@param roomTypeModel.typeName
  ///@param roomTypeModel.guests
  ///@param roomTypeModel.bedType
  ///@param roomId
  ///@param roomNumber
  Future<chopper.Response> apiV1RoomDeleteDelete(
      {int? roomTypeModelRoomTypeId,
      String? roomTypeModelTypeName,
      int? roomTypeModelGuests,
      String? roomTypeModelBedType,
      int? roomId,
      int? roomNumber}) {
    return _apiV1RoomDeleteDelete(
        roomTypeModelRoomTypeId: roomTypeModelRoomTypeId,
        roomTypeModelTypeName: roomTypeModelTypeName,
        roomTypeModelGuests: roomTypeModelGuests,
        roomTypeModelBedType: roomTypeModelBedType,
        roomId: roomId,
        roomNumber: roomNumber);
  }

  ///deleteRoom
  ///@param roomTypeModel.roomTypeId
  ///@param roomTypeModel.typeName
  ///@param roomTypeModel.guests
  ///@param roomTypeModel.bedType
  ///@param roomId
  ///@param roomNumber
  @Delete(path: '/api/v1/room/delete')
  Future<chopper.Response> _apiV1RoomDeleteDelete(
      {@Query('roomTypeModel.roomTypeId') int? roomTypeModelRoomTypeId,
      @Query('roomTypeModel.typeName') String? roomTypeModelTypeName,
      @Query('roomTypeModel.guests') int? roomTypeModelGuests,
      @Query('roomTypeModel.bedType') String? roomTypeModelBedType,
      @Query('roomId') int? roomId,
      @Query('roomNumber') int? roomNumber});

  ///deleteRoomTypeById
  ///@param id id
  Future<chopper.Response> apiV1RoomDeletebyidIdGet({required int? id}) {
    return _apiV1RoomDeletebyidIdGet(id: id);
  }

  ///deleteRoomTypeById
  ///@param id id
  @Get(path: '/api/v1/room/deletebyid/{id}')
  Future<chopper.Response> _apiV1RoomDeletebyidIdGet(
      {@Path('id') required int? id});

  ///retrieveAll
  Future<chopper.Response<List<RoomModel>>> apiV1RoomFindallGet() {
    generatedMapping.putIfAbsent(RoomModel, () => RoomModel.fromJsonFactory);

    return _apiV1RoomFindallGet();
  }

  ///retrieveAll
  @Get(path: '/api/v1/room/findall')
  Future<chopper.Response<List<RoomModel>>> _apiV1RoomFindallGet();

  ///insertRoom
  ///@param roomTypeModel.roomTypeId
  ///@param roomTypeModel.typeName
  ///@param roomTypeModel.guests
  ///@param roomTypeModel.bedType
  ///@param roomId
  ///@param roomNumber
  Future<chopper.Response> apiV1RoomSavePost(
      {int? roomTypeModelRoomTypeId,
      String? roomTypeModelTypeName,
      int? roomTypeModelGuests,
      String? roomTypeModelBedType,
      int? roomId,
      int? roomNumber}) {
    return _apiV1RoomSavePost(
        roomTypeModelRoomTypeId: roomTypeModelRoomTypeId,
        roomTypeModelTypeName: roomTypeModelTypeName,
        roomTypeModelGuests: roomTypeModelGuests,
        roomTypeModelBedType: roomTypeModelBedType,
        roomId: roomId,
        roomNumber: roomNumber);
  }

  ///insertRoom
  ///@param roomTypeModel.roomTypeId
  ///@param roomTypeModel.typeName
  ///@param roomTypeModel.guests
  ///@param roomTypeModel.bedType
  ///@param roomId
  ///@param roomNumber
  @Post(path: '/api/v1/room/save', optionalBody: true)
  Future<chopper.Response> _apiV1RoomSavePost(
      {@Query('roomTypeModel.roomTypeId') int? roomTypeModelRoomTypeId,
      @Query('roomTypeModel.typeName') String? roomTypeModelTypeName,
      @Query('roomTypeModel.guests') int? roomTypeModelGuests,
      @Query('roomTypeModel.bedType') String? roomTypeModelBedType,
      @Query('roomId') int? roomId,
      @Query('roomNumber') int? roomNumber});

  ///updateRoom
  ///@param roomTypeModel.roomTypeId
  ///@param roomTypeModel.typeName
  ///@param roomTypeModel.guests
  ///@param roomTypeModel.bedType
  ///@param roomId
  ///@param roomNumber
  Future<chopper.Response> apiV1RoomUpdatePut(
      {int? roomTypeModelRoomTypeId,
      String? roomTypeModelTypeName,
      int? roomTypeModelGuests,
      String? roomTypeModelBedType,
      int? roomId,
      int? roomNumber}) {
    return _apiV1RoomUpdatePut(
        roomTypeModelRoomTypeId: roomTypeModelRoomTypeId,
        roomTypeModelTypeName: roomTypeModelTypeName,
        roomTypeModelGuests: roomTypeModelGuests,
        roomTypeModelBedType: roomTypeModelBedType,
        roomId: roomId,
        roomNumber: roomNumber);
  }

  ///updateRoom
  ///@param roomTypeModel.roomTypeId
  ///@param roomTypeModel.typeName
  ///@param roomTypeModel.guests
  ///@param roomTypeModel.bedType
  ///@param roomId
  ///@param roomNumber
  @Put(path: '/api/v1/room/update', optionalBody: true)
  Future<chopper.Response> _apiV1RoomUpdatePut(
      {@Query('roomTypeModel.roomTypeId') int? roomTypeModelRoomTypeId,
      @Query('roomTypeModel.typeName') String? roomTypeModelTypeName,
      @Query('roomTypeModel.guests') int? roomTypeModelGuests,
      @Query('roomTypeModel.bedType') String? roomTypeModelBedType,
      @Query('roomId') int? roomId,
      @Query('roomNumber') int? roomNumber});

  ///deleteRoomType
  ///@param roomTypeId
  ///@param typeName
  ///@param guests
  ///@param bedType
  Future<chopper.Response> apiV1RoomtypeDeleteDelete(
      {int? roomTypeId, String? typeName, int? guests, String? bedType}) {
    return _apiV1RoomtypeDeleteDelete(
        roomTypeId: roomTypeId,
        typeName: typeName,
        guests: guests,
        bedType: bedType);
  }

  ///deleteRoomType
  ///@param roomTypeId
  ///@param typeName
  ///@param guests
  ///@param bedType
  @Delete(path: '/api/v1/roomtype/delete')
  Future<chopper.Response> _apiV1RoomtypeDeleteDelete(
      {@Query('roomTypeId') int? roomTypeId,
      @Query('typeName') String? typeName,
      @Query('guests') int? guests,
      @Query('bedType') String? bedType});

  ///deleteRoomTypeById
  ///@param id id
  Future<chopper.Response> apiV1RoomtypeDeletebyidIdGet({required int? id}) {
    return _apiV1RoomtypeDeletebyidIdGet(id: id);
  }

  ///deleteRoomTypeById
  ///@param id id
  @Get(path: '/api/v1/roomtype/deletebyid/{id}')
  Future<chopper.Response> _apiV1RoomtypeDeletebyidIdGet(
      {@Path('id') required int? id});

  ///getAllRoomTypes
  Future<chopper.Response<List<RoomTypeModel>>> apiV1RoomtypeFindallGet() {
    generatedMapping.putIfAbsent(
        RoomTypeModel, () => RoomTypeModel.fromJsonFactory);

    return _apiV1RoomtypeFindallGet();
  }

  ///getAllRoomTypes
  @Get(path: '/api/v1/roomtype/findall')
  Future<chopper.Response<List<RoomTypeModel>>> _apiV1RoomtypeFindallGet();

  ///insertRoomType
  ///@param roomTypeId
  ///@param typeName
  ///@param guests
  ///@param bedType
  Future<chopper.Response> apiV1RoomtypeSavePost(
      {int? roomTypeId, String? typeName, int? guests, String? bedType}) {
    return _apiV1RoomtypeSavePost(
        roomTypeId: roomTypeId,
        typeName: typeName,
        guests: guests,
        bedType: bedType);
  }

  ///insertRoomType
  ///@param roomTypeId
  ///@param typeName
  ///@param guests
  ///@param bedType
  @Post(path: '/api/v1/roomtype/save', optionalBody: true)
  Future<chopper.Response> _apiV1RoomtypeSavePost(
      {@Query('roomTypeId') int? roomTypeId,
      @Query('typeName') String? typeName,
      @Query('guests') int? guests,
      @Query('bedType') String? bedType});

  ///updateRoomType
  ///@param roomTypeId
  ///@param typeName
  ///@param guests
  ///@param bedType
  Future<chopper.Response> apiV1RoomtypeUpdatePut(
      {int? roomTypeId, String? typeName, int? guests, String? bedType}) {
    return _apiV1RoomtypeUpdatePut(
        roomTypeId: roomTypeId,
        typeName: typeName,
        guests: guests,
        bedType: bedType);
  }

  ///updateRoomType
  ///@param roomTypeId
  ///@param typeName
  ///@param guests
  ///@param bedType
  @Put(path: '/api/v1/roomtype/update', optionalBody: true)
  Future<chopper.Response> _apiV1RoomtypeUpdatePut(
      {@Query('roomTypeId') int? roomTypeId,
      @Query('typeName') String? typeName,
      @Query('guests') int? guests,
      @Query('bedType') String? bedType});
}

typedef $JsonFactory<T> = T Function(Map<String, dynamic> json);

class $CustomJsonDecoder {
  $CustomJsonDecoder(this.factories);

  final Map<Type, $JsonFactory> factories;

  dynamic decode<T>(dynamic entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }

    if (entity is T) {
      return entity;
    }

    if (isTypeOf<T, Map>()) {
      return entity;
    }

    if (isTypeOf<T, Iterable>()) {
      return entity;
    }

    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = factories[T];
    if (jsonFactory == null || jsonFactory is! $JsonFactory<T>) {
      return throw "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?";
    }

    return jsonFactory(values);
  }

  List<T> _decodeList<T>(Iterable values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}

class $JsonSerializableConverter extends chopper.JsonConverter {
  @override
  chopper.Response<ResultType> convertResponse<ResultType, Item>(
      chopper.Response response) {
    if (response.bodyString.isEmpty) {
      // In rare cases, when let's say 204 (no content) is returned -
      // we cannot decode the missing json with the result type specified
      return chopper.Response(response.base, null, error: response.error);
    }

    final jsonRes = super.convertResponse(response);
    return jsonRes.copyWith<ResultType>(
        body: $jsonDecoder.decode<Item>(jsonRes.body) as ResultType);
  }
}

final $jsonDecoder = $CustomJsonDecoder(generatedMapping);
