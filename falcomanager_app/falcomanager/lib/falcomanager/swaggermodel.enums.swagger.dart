import 'package:json_annotation/json_annotation.dart';

enum RoomTypeModelBedType {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('SINGOLO_X_1')
  singoloX1,
  @JsonValue('SINGOLO_X_2')
  singoloX2,
  @JsonValue('SINGOLO_X_3')
  singoloX3,
  @JsonValue('SINGOLO_X_4')
  singoloX4,
  @JsonValue('DOPPIO_X_1')
  doppioX1,
  @JsonValue('DOPPIO_X_2')
  doppioX2,
  @JsonValue('MATRIMONIALE_X_1')
  matrimonialeX1,
  @JsonValue('MATRIMONIALE_X_1_SINGOLO_X_1')
  matrimonialeX1SingoloX1,
  @JsonValue('MATRIMONIALE_X_1_SINGOLO_X_2')
  matrimonialeX1SingoloX2,
  @JsonValue('MATRIMONIALE_X_2_SINGOLO_X_1')
  matrimonialeX2SingoloX1,
  @JsonValue('MATRIMONIALE_X_2_SINGOLO_X_2')
  matrimonialeX2SingoloX2,
  @JsonValue('KING_X_1')
  kingX1,
  @JsonValue('KING_X_1_SINGOLO_X_1')
  kingX1SingoloX1
}

const $RoomTypeModelBedTypeMap = {
  RoomTypeModelBedType.singoloX1: 'SINGOLO_X_1',
  RoomTypeModelBedType.singoloX2: 'SINGOLO_X_2',
  RoomTypeModelBedType.singoloX3: 'SINGOLO_X_3',
  RoomTypeModelBedType.singoloX4: 'SINGOLO_X_4',
  RoomTypeModelBedType.doppioX1: 'DOPPIO_X_1',
  RoomTypeModelBedType.doppioX2: 'DOPPIO_X_2',
  RoomTypeModelBedType.matrimonialeX1: 'MATRIMONIALE_X_1',
  RoomTypeModelBedType.matrimonialeX1SingoloX1: 'MATRIMONIALE_X_1_SINGOLO_X_1',
  RoomTypeModelBedType.matrimonialeX1SingoloX2: 'MATRIMONIALE_X_1_SINGOLO_X_2',
  RoomTypeModelBedType.matrimonialeX2SingoloX1: 'MATRIMONIALE_X_2_SINGOLO_X_1',
  RoomTypeModelBedType.matrimonialeX2SingoloX2: 'MATRIMONIALE_X_2_SINGOLO_X_2',
  RoomTypeModelBedType.kingX1: 'KING_X_1',
  RoomTypeModelBedType.kingX1SingoloX1: 'KING_X_1_SINGOLO_X_1'
};

enum BookingModelPaid {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('PAGATO')
  pagato,
  @JsonValue('NON_PAGATO')
  nonPagato
}

const $BookingModelPaidMap = {
  BookingModelPaid.pagato: 'PAGATO',
  BookingModelPaid.nonPagato: 'NON_PAGATO'
};

enum BookingModelSourceBooking {
  @JsonValue('swaggerGeneratedUnknown')
  swaggerGeneratedUnknown,
  @JsonValue('BOOKING')
  booking,
  @JsonValue('EXTERNAL')
  $external
}

const $BookingModelSourceBookingMap = {
  BookingModelSourceBooking.booking: 'BOOKING',
  BookingModelSourceBooking.$external: 'EXTERNAL'
};
