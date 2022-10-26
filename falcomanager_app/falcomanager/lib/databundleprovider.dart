import 'dart:math';
import 'package:FalcoManager/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'falcomanager/swaggermodel.models.swagger.dart';
import 'falcomanager/swaggermodel.swagger.dart';

class DataBundleNotifier extends ChangeNotifier {

  List<RoomTypeModel> roomTypes = [];
  List<BookingModel> bookings = [];
  List<BookingModel> searchBookList = [];

  List<RoomModel> rooms = [];
  Map<int, int> mapRoomsIdRoomNumber = {};

  List<RoomModel> roomsDuplicated = [];

  Map<int, List<String>> busyDates = {};


  Swaggermodel _client = Swaggermodel.create(
      baseUrl: kUrl
  );

  int roomNumbersForGeneration = 0 ;

  void decrementRoomNumbersOnGeneration() {
    if(roomNumbersForGeneration > 0){
      roomNumbersForGeneration --;
    }
    notifyListeners();
  }
  void incrementRoomNumbersOnGeneration() {
    roomNumbersForGeneration ++;
    notifyListeners();
  }
  void restoreRoomNumberForGeneration() {
    roomNumbersForGeneration = 0;
    notifyListeners();
  }

  Swaggermodel getSwaggerClient(){
    if(_client != null){
      return _client;
    }else{
      return Swaggermodel.create(
          baseUrl: kUrl
      );
    }
  }

  setCurrentRoomTypesList(List<RoomTypeModel> roomTypesIncoming){
    roomTypes.clear();
    roomTypes.addAll(roomTypesIncoming);
    print('OCOCO_: ' + roomTypesIncoming.toString());
    notifyListeners();
  }

  setCurrentRoomList(List<RoomModel> roomsIncoming){
    mapRoomsIdRoomNumber.clear();
    rooms.clear();
    roomsDuplicated.clear();
    rooms.addAll(roomsIncoming);
    roomsDuplicated.addAll(roomsIncoming);

    rooms.forEach((element) {
      mapRoomsIdRoomNumber[int.parse(element.roomId.toString())] = int.parse(element.roomNumber.toString());
    });
    notifyListeners();
  }

  List<BookingModel> onGoingBooking = [];

  void calculateOnGoingBookings(List<BookingModel> bookingsIncoming, int daysToAdd){
    onGoingBooking.clear();
    searchBookList.clear();
    String currentDate = dateFormat.format(DateTime.now().subtract(Duration(days: daysToAdd)));
    bookingsIncoming.forEach((book) {
      if(dateFormat.parse(book.bookingDate!).isBefore(dateFormat.parse(currentDate))
          && dateFormat.parse(currentDate).isBefore(dateFormat.parse(book.bookingDate!).add(Duration(days: book.nightNumbers!)))){
        onGoingBooking.add(book);
      }
    });
    notifyListeners();
  }

  setCurrentBookingList(List<BookingModel> bookingsIncoming){
    searchBookList.clear();
    bookings.clear();
    calculateOnGoingBookings(bookingsIncoming, 0);
    calculateBusyDates(bookingsIncoming);
    bookings.addAll(bookingsIncoming);
    notifyListeners();
  }

  String getRoomNumbersByRoomTypeName(String bedType) {
    int counter = 0;
    for (var roomItem in rooms) {
      if(roomItem.roomTypeModel?.typeName == bedType){
        counter ++;
      }
    }
    return counter.toString();
  }


  int guestReservationNumber = 0;
  void decrementGuestReservationNumber() {
    if(guestReservationNumber > 0){
      guestReservationNumber --;
    }
    notifyListeners();
  }
  void incrementGuestReservationNumber() {
    guestReservationNumber ++;
    notifyListeners();
  }

  List<RoomModel> availableRoomsForReservation = [];

  calculateListAvailableRooms(DataBundleNotifier databundle,
      String guests) {

    availableRoomsForReservation.clear();

    databundle.rooms.forEach((element) {
      if(element.roomNumber != 0){
        if(element.roomTypeModel?.guests == int.parse(guests)){
          availableRoomsForReservation.add(element);
        }
      }
    });
    notifyListeners();
  }

  void resetavailableRoomsForReservation(){
    availableRoomsForReservation.clear();
    notifyListeners();
  }

  getRoomNumberById(int? roomId) {
    int roomNumber = 0;
    rooms.forEach((element) {
      if(element.roomId == roomId){
        roomNumber = element.roomNumber!;
      }
    });
    return roomNumber;
  }

  void updateBookingList(List<BookingModel> newBook) {
    bookings.addAll(newBook);
    searchBookList.clear();
    notifyListeners();
  }

  List<BookingModel> retrieveBookingByNumberRoom(num? roomIdIncoming) {
    List<BookingModel> list = [];
    bookings.forEach((element) {
      if(element.roomId == roomIdIncoming){
        list.add(element);
      }
    });

    return list;
  }

  List<BookingModel> appoggiamelList = [];
  late BookingModel movingBooking;

  void appoggialeNellaList(BookingModel bookingModel) {
    movingBooking = bookingModel;
    appoggiamelList.clear();
    bookings.forEach((element) {
      if(element.code == bookingModel.code){
        appoggiamelList.add(element);
      }
    });
    bookings.removeWhere((element) => element.code == bookingModel.code);
    notifyListeners();
  }

  void rimettilenellalist() {
    bookings.addAll(appoggiamelList);
    appoggiamelList.clear();
    notifyListeners();
  }

  void filterByRoomNumber(String roomNumber) {

    List<RoomModel> roomsI = [];

    if(roomNumber != ''){
      roomsDuplicated.forEach((element) {
        if(element.roomNumber.toString().contains(roomNumber)){
          roomsI.add(element);
        }
      });
      rooms.clear();
      rooms.addAll(roomsI);
    }else{
      rooms.clear();
      rooms.addAll(roomsDuplicated);
    }

    notifyListeners();

  }

  List<BookingModel> getBookingByRoomId(num? roomId) {
    List<BookingModel> bookingModelList = [];
    bookings.forEach((element) {
      if(element.roomId == int.parse(roomId.toString())){
        bookingModelList.add(element);
      }
    });
    return bookingModelList;
  }

  /* Moving widget */
  List<BookingModel> bookingToMoveList = [];
  List<RoomModel> modelRoomToMoveList = [];

  void clearBookingToMoveList() {
    bookingToMoveList.clear();
    modelRoomToMoveList.clear();
    searchBookList.clear();
    notifyListeners();
  }

  void addToBookingToMove(BookingModel bookingModelToMove, RoomModel roomModel){
    bookingToMoveList.clear();
    modelRoomToMoveList.clear();
    bookingToMoveList.add(bookingModelToMove);
    modelRoomToMoveList.add(roomModel);
    notifyListeners();
  }

  void moveBooking(BookingModel bookingModel) {
    bookings.removeWhere((element) => element.bookingId == bookingModel.bookingId);
    bookings.add(bookingModel);
    notifyListeners();
  }

  bool isBookingReservation = false;
  void changeValue() {
    if (isBookingReservation) {
      isBookingReservation = false;
    } else {
      isBookingReservation = true;
    }
  }

  List<BookingModel> getOngoingBookingByRoomId(num? roomId) {
    List<BookingModel> bookingModelList = [];
    onGoingBooking.forEach((element) {
      if(element.roomId == int.parse(roomId.toString())){
        bookingModelList.add(element);
      }
    });
    return bookingModelList;
  }

  void removeBookingFromList(num bookingId) {
    bookings.removeWhere((element) => element.bookingId == bookingId);
    searchBookList.removeWhere((element) => element.bookingId == bookingId);
    notifyListeners();
  }

  void calculateBusyDates(List<BookingModel> bookingsIncoming) {
    busyDates.clear();
    bookingsIncoming.forEach((booking) {
      if(busyDates.containsKey(booking.roomId)){
        busyDates[booking.roomId]?.addAll(
          retrieveDatesByStartDateAndNightsNumbers(booking.bookingDate!, booking.nightNumbers!)
        );
      }else{
        busyDates[booking.roomId!] = retrieveDatesByStartDateAndNightsNumbers(booking.bookingDate!, booking.nightNumbers!);
      }
    });
    print('Busy Dates: ');
    print(busyDates.toString());
    notifyListeners();
  }

  List<String> retrieveDatesByStartDateAndNightsNumbers(String bookingDate, int nightNumbers) {
    List<String> dates = [];
    for(int i = 0; i < nightNumbers; i++){
      dates.add(dateFormat.format(dateFormat.parse(bookingDate).add(Duration(days: i))));
    }

    return dates;
  }


  void updateBookingSearchListByStringIncoming(String text) {
    searchBookList.clear();
    bookings.forEach((bookToSearch) {
      if(bookToSearch.customerName!.toLowerCase().contains(text.toLowerCase())){
        searchBookList.add(bookToSearch);
      }
    });
    print(searchBookList.toString());
    notifyListeners();
  }

  RoomModel getRoomById(int roomId) {

    RoomModel room = RoomModel(
      roomId: 0,
      roomNumber: 0,
      roomTypeModel: RoomTypeModel(
        guests: 2,
        bedType: RoomTypeModelBedType.doppioX2,
        roomTypeId: 2,
        typeName: 'Default'
      )
    );
    rooms.forEach((element) {
      if(element.roomId ==  roomId){
        room = element;
      }
    });
    return room;
  }
}