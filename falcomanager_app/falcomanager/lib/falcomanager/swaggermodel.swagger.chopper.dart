//Generated code

part of 'swaggermodel.swagger.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line, always_specify_types, prefer_const_declarations, unnecessary_brace_in_string_interps
class _$Swaggermodel extends Swaggermodel {
  _$Swaggermodel([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final definitionType = Swaggermodel;

  @override
  Future<Response<dynamic>>
      _apiV1BookingAdddaytobookingBookingidRoomidReservationdateNightsPost(
          {required int? bookingid,
          required int? roomid,
          required String? reservationdate,
          required int? nights}) {
    final $url =
        '/api/v1/booking/adddaytobooking/${bookingid}/${roomid}/${reservationdate}/${nights}';
    final $request = Request('POST', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1BookingDeleteDelete(
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
    final $url = '/api/v1/booking/delete';
    final $params = <String, dynamic>{
      'bookingId': bookingId,
      'customerName': customerName,
      'code': code,
      'roomId': roomId,
      'nightNumbers': nightNumbers,
      'bookingDate': bookingDate,
      'sourceBooking': sourceBooking,
      'details': details,
      'paid': paid,
      'deposit': deposit,
      'guests': guests,
      'total': total
    };
    final $request =
        Request('DELETE', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1BookingDeletebycodeCodeGet(
      {required String? code}) {
    final $url = '/api/v1/booking/deletebycode/${code}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1BookingDeletebyidIdGet({required int? id}) {
    final $url = '/api/v1/booking/deletebyid/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<BookingModel>>> _apiV1BookingFindByCodeCodeGet(
      {required String? code}) {
    final $url = '/api/v1/booking/findByCode/${code}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<BookingModel>, BookingModel>($request);
  }

  @override
  Future<Response<List<BookingModel>>> _apiV1BookingFindallGet() {
    final $url = '/api/v1/booking/findall';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<BookingModel>, BookingModel>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1BookingMovereservationPost(
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
    final $url = '/api/v1/booking/movereservation';
    final $params = <String, dynamic>{
      'bookingId': bookingId,
      'customerName': customerName,
      'code': code,
      'roomId': roomId,
      'nightNumbers': nightNumbers,
      'bookingDate': bookingDate,
      'sourceBooking': sourceBooking,
      'details': details,
      'paid': paid,
      'deposit': deposit,
      'guests': guests,
      'total': total
    };
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1BookingSavePost(
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
    final $url = '/api/v1/booking/save';
    final $params = <String, dynamic>{
      'bookingId': bookingId,
      'customerName': customerName,
      'code': code,
      'roomId': roomId,
      'nightNumbers': nightNumbers,
      'bookingDate': bookingDate,
      'sourceBooking': sourceBooking,
      'details': details,
      'paid': paid,
      'deposit': deposit,
      'guests': guests,
      'total': total
    };
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1BookingUpdatePut(
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
    final $url = '/api/v1/booking/update';
    final $params = <String, dynamic>{
      'bookingId': bookingId,
      'customerName': customerName,
      'code': code,
      'roomId': roomId,
      'nightNumbers': nightNumbers,
      'bookingDate': bookingDate,
      'sourceBooking': sourceBooking,
      'details': details,
      'paid': paid,
      'deposit': deposit,
      'guests': guests,
      'total': total
    };
    final $request = Request('PUT', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RoomDeleteDelete(
      {int? roomTypeModelRoomTypeId,
      String? roomTypeModelTypeName,
      int? roomTypeModelGuests,
      String? roomTypeModelBedType,
      int? roomId,
      int? roomNumber}) {
    final $url = '/api/v1/room/delete';
    final $params = <String, dynamic>{
      'roomTypeModel.roomTypeId': roomTypeModelRoomTypeId,
      'roomTypeModel.typeName': roomTypeModelTypeName,
      'roomTypeModel.guests': roomTypeModelGuests,
      'roomTypeModel.bedType': roomTypeModelBedType,
      'roomId': roomId,
      'roomNumber': roomNumber
    };
    final $request =
        Request('DELETE', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RoomDeletebyidIdGet({required int? id}) {
    final $url = '/api/v1/room/deletebyid/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RoomModel>>> _apiV1RoomFindallGet() {
    final $url = '/api/v1/room/findall';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<RoomModel>, RoomModel>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RoomSavePost(
      {int? roomTypeModelRoomTypeId,
      String? roomTypeModelTypeName,
      int? roomTypeModelGuests,
      String? roomTypeModelBedType,
      int? roomId,
      int? roomNumber}) {
    final $url = '/api/v1/room/save';
    final $params = <String, dynamic>{
      'roomTypeModel.roomTypeId': roomTypeModelRoomTypeId,
      'roomTypeModel.typeName': roomTypeModelTypeName,
      'roomTypeModel.guests': roomTypeModelGuests,
      'roomTypeModel.bedType': roomTypeModelBedType,
      'roomId': roomId,
      'roomNumber': roomNumber
    };
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RoomUpdatePut(
      {int? roomTypeModelRoomTypeId,
      String? roomTypeModelTypeName,
      int? roomTypeModelGuests,
      String? roomTypeModelBedType,
      int? roomId,
      int? roomNumber}) {
    final $url = '/api/v1/room/update';
    final $params = <String, dynamic>{
      'roomTypeModel.roomTypeId': roomTypeModelRoomTypeId,
      'roomTypeModel.typeName': roomTypeModelTypeName,
      'roomTypeModel.guests': roomTypeModelGuests,
      'roomTypeModel.bedType': roomTypeModelBedType,
      'roomId': roomId,
      'roomNumber': roomNumber
    };
    final $request = Request('PUT', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RoomtypeDeleteDelete(
      {int? roomTypeId, String? typeName, int? guests, String? bedType}) {
    final $url = '/api/v1/roomtype/delete';
    final $params = <String, dynamic>{
      'roomTypeId': roomTypeId,
      'typeName': typeName,
      'guests': guests,
      'bedType': bedType
    };
    final $request =
        Request('DELETE', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RoomtypeDeletebyidIdGet({required int? id}) {
    final $url = '/api/v1/roomtype/deletebyid/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<List<RoomTypeModel>>> _apiV1RoomtypeFindallGet() {
    final $url = '/api/v1/roomtype/findall';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<List<RoomTypeModel>, RoomTypeModel>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RoomtypeSavePost(
      {int? roomTypeId, String? typeName, int? guests, String? bedType}) {
    final $url = '/api/v1/roomtype/save';
    final $params = <String, dynamic>{
      'roomTypeId': roomTypeId,
      'typeName': typeName,
      'guests': guests,
      'bedType': bedType
    };
    final $request = Request('POST', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> _apiV1RoomtypeUpdatePut(
      {int? roomTypeId, String? typeName, int? guests, String? bedType}) {
    final $url = '/api/v1/roomtype/update';
    final $params = <String, dynamic>{
      'roomTypeId': roomTypeId,
      'typeName': typeName,
      'guests': guests,
      'bedType': bedType
    };
    final $request = Request('PUT', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }
}
