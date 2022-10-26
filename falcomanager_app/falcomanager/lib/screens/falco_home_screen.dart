import 'dart:io';

import 'package:FalcoManager/utils/size_config.dart';
import 'package:adaptive_scrollbar/adaptive_scrollbar.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:side_sheet/side_sheet.dart';
import 'package:uuid/uuid.dart';
import 'package:FalcoManager/utils/constants.dart';
import '../databundleprovider.dart';
import '../falcomanager/swaggermodel.enums.swagger.dart';
import '../falcomanager/swaggermodel.models.swagger.dart';
import 'room/room_manager.dart';
import 'room_type/room_type_manager.dart';

class FalcoDOroManagerHome extends StatefulWidget {

  static const String route = 'falco_manager_home';
  @override
  _FalcoDOroManagerHomeState createState() => _FalcoDOroManagerHomeState();
}

class _FalcoDOroManagerHomeState extends State<FalcoDOroManagerHome> {
  final ScrollController horizontalScroll = ScrollController();
  final ScrollController verticalScroll = ScrollController(keepScrollOffset: true);
  final double width = 20;
  int daysToAdd = 0;

  late DateTime dataFromWhereToStartDrawing;

  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
    dataFromWhereToStartDrawing = DateTime.now();
  }

  void addOne() {
    setState((){
      daysToAdd++;
      dataFromWhereToStartDrawing = DateTime.now().subtract(Duration(days: daysToAdd));
    });
  }

  void subractOne() {
    if(daysToAdd > 0){
      setState((){
        daysToAdd--;
        dataFromWhereToStartDrawing = DateTime.now().subtract(Duration(days: daysToAdd));
      });
    }else{
      daysToAdd--;
      dataFromWhereToStartDrawing = DateTime.now().add(Duration(days: daysToAdd*-1));
    }
  }

  double widthGeneral = 165;
  double heightGeneral = 60;

  double multiplier = 1;


  @override
  Widget build(BuildContext context) {
    return Consumer<DataBundleNotifier>(
      builder: (child, databundle, _) {
        return  AdaptiveScrollbar(
            underSpacing: EdgeInsets.only(bottom: width),
            controller: horizontalScroll,
            width: width,
            position: ScrollbarPosition.bottom,
            sliderDecoration: const BoxDecoration(
                color: kFalcoBlack,
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            sliderActiveDecoration: const BoxDecoration(
                color: Color.fromRGBO(206, 206, 206, 100),
                borderRadius: BorderRadius.all(Radius.circular(12.0))),
            underColor: Colors.transparent,
            child: SingleChildScrollView(
                controller: horizontalScroll,
                scrollDirection: Axis.horizontal,
                child: GestureDetector(
                  onTap: (){
                    databundle.clearBookingToMoveList();
                  },
                  child: SizedBox(
                      width: 10500*multiplier,
                      child: Scaffold(
                        drawer: Drawer(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text('Tipologia Stanze', style: GoogleFonts.openSans(
                                  color: kFalcoBlack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: getProportionateScreenHeight(27),
                                ),),
                                onTap: (){
                                  Navigator.pushNamed(context, RoomTypeManagerScreen.route);
                                },
                              ),
                              ListTile(
                                title: Text('Stanze', style: GoogleFonts.openSans(
                                  color: kFalcoBlack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: getProportionateScreenHeight(27),
                                )),
                                onTap: (){
                                  Navigator.pushNamed(context, RoomManagerScreen.route);
                                },
                              ),
                            ],
                          ),
                        ),
                        appBar: AppBar(
                            title: Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    Response<List<BookingModel>> bookingModelList = await databundle.getSwaggerClient().apiV1BookingFindallGet();

                                    sleep(Duration(seconds: 1));
                                    databundle.setCurrentBookingList(bookingModelList.body!);
                                    databundle.calculateOnGoingBookings(databundle.bookings, daysToAdd);
                                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      backgroundColor: Colors.green,
                                      content: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Refresh pagina effettuato', style: GoogleFonts.openSans(
                                            color: Colors.white,
                                            fontSize: getProportionateScreenHeight(20),
                                            fontWeight: FontWeight.w500
                                        ),
                                        ),
                                      ),
                                    ),);
                                  },
                                  child: const Text("Falco D\'Oro Manager",
                                      style: TextStyle(color: Colors.white)),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 1),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.2,
                                    height: 40,
                                    child: Container(
                                      color: Colors.white,
                                      child: TextField(
                                        textAlign: TextAlign.center,
                                        style: GoogleFonts.openSans(
                                          color: kFalcoBlack,
                                          fontWeight: FontWeight.w700,
                                          fontSize: getProportionateScreenHeight(20),
                                        ),
                                        onChanged: (text){
                                          databundle.updateBookingSearchListByStringIncoming(text);
                                        },
                                        decoration: InputDecoration(
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          hintText: 'Ricerca per nome cliente',
                                          hintStyle: GoogleFonts.openSans(
                                            color: kFalcoBlack,
                                            fontWeight: FontWeight.w100,
                                            fontSize: getProportionateScreenHeight(10),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(width: 40),
                                    SizedBox(
                                      width: 300,
                                      child: Slider(
                                        inactiveColor: Colors.white,
                                        min: 1.0,
                                        max: 4,
                                        divisions: 4,
                                        onChanged: (dd){
                                          setState((){
                                            multiplier = dd;
                                          });
                                        },
                                        value: multiplier,
                                      ),
                                    ),
                                    SizedBox(width: 30),
                                    IconButton(
                                      icon: Icon(Icons.arrow_back, color: Colors.orange, size: 30),
                                      onPressed: (){
                                        addOne();
                                        databundle.calculateOnGoingBookings(databundle.bookings, daysToAdd);
                                      },
                                    ),
                                    IconButton(icon: Icon(Icons.calendar_month, size: 30,), onPressed: () {
                                      SideSheet.right(body: buildMonthCalendarWidget(), context: context);
                                    },),
                                    IconButton(
                                      icon: Icon(Icons.arrow_forward_outlined, color: Colors.greenAccent, size: 30),
                                      onPressed: (){
                                        subractOne();
                                        databundle.calculateOnGoingBookings(databundle.bookings, daysToAdd);
                                      },
                                    ),
                                    SizedBox(width: 20),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        primary: Colors.blueAccent,
                                      ),
                                      onPressed: () {
                                        setState((){
                                          dataFromWhereToStartDrawing = DateTime.now();
                                          daysToAdd = 0;
                                        });

                                      }, child: Text('Today',style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w400,
                                      fontSize: getProportionateScreenHeight(24),
                                    ),),

                                    ),
                                    SizedBox(width: 20),
                                  ],
                                ),
                              ],
                            ),
                            flexibleSpace: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          kFalcoBlack,
                                          kFalcoBlack,
                                          kFalcoBlack,
                                          kFalcoColor,
                                        ])))),
                        body: buildTableWithSize(55, databundle),
                      )),
                )));
      },
    );
  }

  buildTableWithSize(int daysCount, DataBundleNotifier databundlenotifier) {

    List<Row> rows = [];

    List<Widget> headersList = [SizedBox(
      width: widthGeneral,
      height: 80,
      child: TextField(
        textAlign: TextAlign.center,
        style: GoogleFonts.openSans(
          color: kRoomTypeColor,
          fontWeight: FontWeight.w700,
          fontSize: getProportionateScreenHeight(30),
        ),
        onChanged: (roomNumber){
          databundlenotifier.filterByRoomNumber(roomNumber);
        },
        decoration: InputDecoration(
          border: OutlineInputBorder(
          ),
          hintText: 'n° stanza',
          hintStyle: GoogleFonts.openSans(
            color: kFalcoBlack,
            fontWeight: FontWeight.w100,
            fontSize: getProportionateScreenHeight(11),
          ),
        ),
      ),
    )];

    for(int dayCounter = 0; dayCounter < daysCount; dayCounter++){
      headersList.add(
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withOpacity(0.2))
            ),
            width: widthGeneral*multiplier,
            height: 70,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Center(child: Column(
                children: [
                  Text(getMonthByMonthNumber(dataFromWhereToStartDrawing.add(Duration(days: dayCounter)).month), style: GoogleFonts.openSans(
                      color: dataFromWhereToStartDrawing.add(Duration(days: dayCounter)).weekday == 7 ? kFalcoRed : Colors.grey.shade600,
                      fontSize: getProportionateScreenHeight(10),
                      fontWeight: FontWeight.w800
                  ),),
                  Text('${dataFromWhereToStartDrawing.add(Duration(days: dayCounter)).day}', style: GoogleFonts.openSans(
                      color: dataFromWhereToStartDrawing.add(Duration(days: dayCounter)).weekday == 7 ? kFalcoRed : kFalcoBlack,
                      fontSize: getProportionateScreenHeight(18),
                      fontWeight: FontWeight.w800
                  ),),
                  Text(getWeekDayNameByNumber(dataFromWhereToStartDrawing.add(Duration(days: dayCounter)).weekday), style: GoogleFonts.openSans(
                      color: Colors.grey.shade600,
                      fontSize: getProportionateScreenHeight(10),
                      fontWeight: FontWeight.w800
                  ),),

                ],
              )),
            ),
          )
      );
    }
    databundlenotifier.rooms.forEach((roomItem) {

      if(roomItem.roomNumber != 0){

        List<Widget> roomListWidget = [Container( decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.withOpacity(0.2))
        ),width: widthGeneral, height: heightGeneral*multiplier, child: Tooltip(
          message: roomItem.roomTypeModel!.typeName,
          child: Center(child: Text(roomItem.roomNumber.toString(), style: GoogleFonts.openSans(
              color: Colors.grey.shade600,
              fontSize: getProportionateScreenHeight(30),
              fontWeight: FontWeight.w600
          ))),
        ),)];

        List<BookingModel> bookListForCurrentRoom = databundlenotifier.getBookingByRoomId(roomItem.roomId);
        List<BookingModel> bookListForCurrentRoomOngoing = databundlenotifier.getOngoingBookingByRoomId(roomItem.roomId);

        List<String> dateExclusionToFill = getExclusionDatesFromBookList(bookListForCurrentRoom);
        List<String> dateStartBooking = getFromBookListDateStart(bookListForCurrentRoom);

        List<String> alreadyPresent = [];
        for(int i = 0; i < daysCount; i++){

          String currentDate = dateFormat.format(dataFromWhereToStartDrawing.add(Duration(days: i)));

          if(!dateExclusionToFill.contains(currentDate)){
            roomListWidget.add(
              Container(
                width: widthGeneral*multiplier,
                height: heightGeneral*multiplier,
                color: i % 2 == 0 ? Colors.grey.withOpacity(0.01) : Colors.grey.withOpacity(0.11),
                child: Center(
                    child: databundlenotifier.bookingToMoveList.isEmpty ? IconButton(
                      onPressed: (){

                        SideSheet.right(
                            body: AddReservationDialog(
                              days: i,
                              now: dataFromWhereToStartDrawing,
                              roomItem: roomItem,
                              daysToAdd: daysToAdd,
                            ), context: context);
                      },
                      icon: Icon(Icons.add, color: Colors.grey),
                    ) : SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          IconButton(
                            onPressed: () async {

                              Response apiV1BookingMovereservationPost = await databundlenotifier.getSwaggerClient().apiV1BookingMovereservationPost(
                                  nightNumbers: databundlenotifier.bookingToMoveList.first.nightNumbers,
                                  bookingDate: currentDate,
                                  roomId: int.parse(roomItem.roomId.toString()),
                                  bookingId: int.parse(databundlenotifier.bookingToMoveList.first.bookingId.toString()),
                                  code: databundlenotifier.bookingToMoveList.first.code,
                                  deposit: databundlenotifier.bookingToMoveList.first.deposit,
                                  customerName: databundlenotifier.bookingToMoveList.first.customerName,
                                  details: databundlenotifier.bookingToMoveList.first.details,
                                  paid: bookingModelPaidToJson(databundlenotifier.bookingToMoveList.first.paid),
                                  sourceBooking: bookingModelSourceBookingToJson(databundlenotifier.bookingToMoveList.first.sourceBooking)
                              );

                              if(apiV1BookingMovereservationPost.statusCode == 200){
                                databundlenotifier.moveBooking(BookingModel(
                                    nightNumbers: databundlenotifier.bookingToMoveList.first.nightNumbers,
                                    bookingDate: currentDate,
                                    roomId: int.parse(roomItem.roomId.toString()),
                                    bookingId: int.parse(databundlenotifier.bookingToMoveList.first.bookingId.toString()),
                                    code: databundlenotifier.bookingToMoveList.first.code,
                                    deposit: databundlenotifier.bookingToMoveList.first.deposit,
                                    customerName: databundlenotifier.bookingToMoveList.first.customerName,
                                    details: databundlenotifier.bookingToMoveList.first.details,
                                    sourceBooking: databundlenotifier.bookingToMoveList.first.sourceBooking,
                                    paid: databundlenotifier.bookingToMoveList.first.paid,
                                    guests: databundlenotifier.bookingToMoveList.first.guests
                                ));
                                databundlenotifier.clearBookingToMoveList();
                                databundlenotifier.calculateBusyDates(databundlenotifier.bookings);
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  duration: Duration(seconds: 3),
                                  backgroundColor: kFalcoRed,
                                  content: Text('Errore. Stato code dal server: ${apiV1BookingMovereservationPost.statusCode}. ${apiV1BookingMovereservationPost.error}'),
                                ));
                              }
                            },
                            icon: Icon(Icons.download, color: Colors.green.shade700),
                          ),

                        ],
                      ),
                    )
                ),
              ),
            );
          }else{
            if(dateStartBooking.contains(currentDate)){
              Iterable<BookingModel> retrieveBookByDate = bookListForCurrentRoom.where((element) => element.bookingDate == currentDate);
              roomListWidget.add(
                GestureDetector(
                  onTap: (){
                    databundlenotifier.clearBookingToMoveList();
                    SideSheet.right(
                        body: EditReservationDialog(
                          bookingModel: retrieveBookByDate.first,
                          roomItem: roomItem,
                          daysToAdd: daysToAdd,
                        ), context: context);
                  },
                  onDoubleTap: (){
                    databundlenotifier.addToBookingToMove(retrieveBookByDate.first, roomItem);
                  },
                  child: Container(
                    width: widthGeneral*multiplier * double.parse(retrieveBookByDate.first.nightNumbers.toString()),
                    height: heightGeneral*multiplier,
                    color: Colors.grey.withOpacity(0.003),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11),
                        ),
                        elevation: 9,
                        shadowColor: retrieveBookByDate.first.sourceBooking == BookingModelSourceBooking.booking ? Colors.blueAccent : Colors.orange,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(icon: Icon(Icons.plus_one_rounded), onPressed: () async {

                                          if(databundlenotifier
                                              .busyDates[retrieveBookByDate.first.roomId]!
                                              .contains(dateFormat.format(dateFormat.parse(retrieveBookByDate.first.bookingDate!).add(Duration(days: retrieveBookByDate.first.nightNumbers! + 1))))){
                                            const snackBar = SnackBar(
                                              duration: Duration(seconds: 2),
                                              backgroundColor: kFalcoRed,
                                              content: Text('Errore. Hai una prenotazione diversa per il giorno successivo, non puoi estendere questa prenotazione'),
                                            );
                                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                          }else{
                                            Response apiV1BookingAdddaytobookingPost = await databundlenotifier.getSwaggerClient().apiV1BookingAdddaytobookingBookingidRoomidReservationdateNightsPost(
                                                bookingid: int.parse(retrieveBookByDate.first.bookingId.toString()),
                                                roomid: retrieveBookByDate.first.roomId,
                                                reservationdate: retrieveBookByDate.first.bookingDate,
                                                nights: retrieveBookByDate.first.nightNumbers
                                            );

                                            if(apiV1BookingAdddaytobookingPost.statusCode == 200){
                                              Response<List<BookingModel>> bookingModelList = await databundlenotifier.getSwaggerClient().apiV1BookingFindallGet();
                                              databundlenotifier.setCurrentBookingList(bookingModelList.body!);
                                            }else{

                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                duration: Duration(seconds: 2),
                                                backgroundColor: kFalcoRed,
                                                content: Text('Errore. ${apiV1BookingAdddaytobookingPost.error}'),
                                              ));
                                            }
                                          }
                                        },),
                                        retrieveBookByDate.first.paid == BookingModelPaid.pagato ? const Tooltip(message: 'Pagato',child: Icon(Icons.euro, size: 30,)) : const Text(''),
                                        retrieveBookByDate.first.sourceBooking == BookingModelSourceBooking.booking ? Tooltip(message: 'Prenotazione tramite Booking.com',child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVF3ZnMnnMEUTiQgqH-4UAXQQ0ET5EIA1VkaFio24agXRvehehS1VncLFa8YiLcEibaQQ&usqp=CAU', height: 30,)) : Text(''),
                                      ],
                                    ),

                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(retrieveBookByDate.first.customerName!, style: GoogleFonts.openSans(
                                      color: kRoomTypeColor,
                                      fontWeight: FontWeight.w700,
                                      fontSize: getProportionateScreenHeight(retrieveBookByDate.first.customerName!.length > 10 ? 15 : 17),
                                    ),),
                                    Wrap(
                                      children: [
                                        Icon(Icons.person, size: 20),
                                        Text('X' + retrieveBookByDate.first.guests.toString(), style: GoogleFonts.openSans(
                                          color: kFalcoBlack,
                                          fontWeight: FontWeight.w800,
                                          fontSize: getProportionateScreenHeight(retrieveBookByDate.first.customerName!.length > 10 ? 16 : 18),
                                        ),),
                                      ],
                                    ),
                                    Divider(
                                      color: Colors.grey.withOpacity(0.3),
                                    ),
                                    retrieveBookByDate.first.details == null || retrieveBookByDate.first.details == '' ? Text('') : Wrap(
                                      children: [
                                        Text('Note: ',style: GoogleFonts.openSans(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w500,
                                          fontSize: getProportionateScreenHeight(retrieveBookByDate.first.customerName!.length > 10 ? 15 : 17),
                                        ),),
                                        Text(retrieveBookByDate.first.details.toString(), style: GoogleFonts.openSans(
                                          color: kFalcoBlack,
                                          fontWeight: FontWeight.w800,
                                          fontSize: getProportionateScreenHeight(retrieveBookByDate.first.customerName!.length > 10 ? 15 : 17),
                                        ),),
                                      ],
                                    ),
                                    retrieveBookByDate.first.deposit == null || retrieveBookByDate.first.deposit == '' ? Text('') : Wrap(
                                      children: [
                                        Text('Acconto: ',style: GoogleFonts.openSans(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w500,
                                          fontSize: getProportionateScreenHeight(retrieveBookByDate.first.customerName!.length > 10 ? 15 : 17),
                                        ),),
                                        Text(retrieveBookByDate.first.deposit.toString() + '€', style: GoogleFonts.openSans(
                                          color: kFalcoBlack,
                                          fontWeight: FontWeight.w800,
                                          fontSize: getProportionateScreenHeight(retrieveBookByDate.first.customerName!.length > 10 ? 15 : 17),
                                        ),),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text('Stanza numnero: ',style: GoogleFonts.openSans(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w500,
                                          fontSize: getProportionateScreenHeight(retrieveBookByDate.first.customerName!.length > 10 ? 15 : 17),
                                        ),),
                                        Text(roomItem.roomNumber.toString(), style: GoogleFonts.openSans(
                                          color: kFalcoBlack,
                                          fontWeight: FontWeight.w800,
                                          fontSize: getProportionateScreenHeight(retrieveBookByDate.first.customerName!.length > 10 ? 15 : 17),
                                        ),),
                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text('Tipologia stanza : ',style: GoogleFonts.openSans(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w500,
                                          fontSize: getProportionateScreenHeight(retrieveBookByDate.first.customerName!.length > 10 ? 15 : 17),
                                        ),),
                                        Text(roomItem.roomTypeModel!.typeName.toString(), style: GoogleFonts.openSans(
                                          color: kFalcoBlack,
                                          fontWeight: FontWeight.w800,
                                          fontSize: getProportionateScreenHeight(retrieveBookByDate.first.customerName!.length > 10 ? 15 : 17),
                                        ),),

                                      ],
                                    ),
                                    Wrap(
                                      children: [
                                        Text('Letti : ',style: GoogleFonts.openSans(
                                          color: Colors.grey.shade600,
                                          fontWeight: FontWeight.w500,
                                          fontSize: getProportionateScreenHeight(retrieveBookByDate.first.customerName!.length > 10 ? 15 : 17),
                                        ),),
                                        Text(roomTypeModelBedTypeToJson(roomItem.roomTypeModel!.bedType).toString(), style: GoogleFonts.openSans(
                                          color: kFalcoBlack,
                                          fontWeight: FontWeight.w800,
                                          fontSize: getProportionateScreenHeight(retrieveBookByDate.first.customerName!.length > 10 ? 15 : 17),
                                        ),),

                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }else{

              if(bookListForCurrentRoomOngoing.isNotEmpty){
                BookingModel ongoingBooking = bookListForCurrentRoomOngoing.first;
                int remainingDays = ongoingBooking.nightNumbers! - (dateFormat.parse(currentDate)).difference(dateFormat.parse(ongoingBooking.bookingDate!)).inDays;

                if(remainingDays<0){
                  remainingDays = remainingDays*-1;
                }
                if(!alreadyPresent.contains(ongoingBooking.bookingId.toString())){
                  roomListWidget.add(
                    GestureDetector(
                      onTap: (){
                        databundlenotifier.clearBookingToMoveList();
                        SideSheet.right(
                            body: EditReservationDialog(
                              bookingModel: ongoingBooking,
                              roomItem: roomItem,
                              daysToAdd: daysToAdd,
                            ), context: context);
                      },
                      onDoubleTap: (){
                        databundlenotifier.addToBookingToMove(ongoingBooking, roomItem);
                      },
                      child: Container(
                        width: widthGeneral*multiplier * remainingDays,
                        height: heightGeneral*multiplier,
                        color: Colors.grey.withOpacity(0.003),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(11),
                                    topRight: Radius.circular(11))),
                            elevation: 6,
                            shadowColor: ongoingBooking.sourceBooking == BookingModelSourceBooking.booking ? Colors.blueAccent : Colors.orange,
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Wrap(
                                          children: [
                                            IconButton(icon: Icon(Icons.plus_one_rounded, color: Colors.blueGrey), onPressed: () async {
                                              Response apiV1BookingAdddaytobookingPost = await databundlenotifier.getSwaggerClient().apiV1BookingAdddaytobookingBookingidRoomidReservationdateNightsPost(
                                                  bookingid: int.parse(ongoingBooking.bookingId.toString()),
                                                  roomid: ongoingBooking.roomId,
                                                  reservationdate: ongoingBooking.bookingDate,
                                                  nights: ongoingBooking.nightNumbers
                                              );

                                              if(apiV1BookingAdddaytobookingPost.statusCode == 200){
                                                Response<List<BookingModel>> bookingModelList = await databundlenotifier.getSwaggerClient().apiV1BookingFindallGet();
                                                databundlenotifier.setCurrentBookingList(bookingModelList.body!);
                                              }else{
                                                const snackBar = SnackBar(
                                                  duration: Duration(seconds: 2),
                                                  backgroundColor: kFalcoRed,
                                                  content: Text('Errore. Hai una prenotazione diversa per il giorno successivo, non puoi estendere questa prenotazione'),
                                                );
                                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                              }
                                            },),
                                            ongoingBooking.paid == BookingModelPaid.pagato ? const Tooltip(message: 'Pagato',child: Icon(Icons.euro, size: 30,)) : const Text(''),
                                            ongoingBooking.sourceBooking == BookingModelSourceBooking.booking ? Tooltip(message: 'Prenotazione tramite Booking.com',child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVF3ZnMnnMEUTiQgqH-4UAXQQ0ET5EIA1VkaFio24agXRvehehS1VncLFa8YiLcEibaQQ&usqp=CAU', height: 30,)) : Text(''),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(ongoingBooking.customerName!, style: GoogleFonts.openSans(
                                          color: kRoomTypeColor,
                                          fontWeight: FontWeight.w700,
                                          fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 15 : 17),
                                        ),),
                                        Row(
                                          children: [
                                            Icon(Icons.person, size: 20),
                                            Text('X' + ongoingBooking.guests.toString(), style: GoogleFonts.openSans(
                                              color: kFalcoBlack,
                                              fontWeight: FontWeight.w800,
                                              fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 16 : 18),
                                            ),),
                                            Text(' - Notti: ${ongoingBooking.nightNumbers! - remainingDays}/${ongoingBooking.nightNumbers}', style: GoogleFonts.openSans(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.w600,
                                              fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 14 : 16),
                                            ),)
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.grey.withOpacity(0.3),
                                        ),
                                        ongoingBooking.details == null || ongoingBooking.details == '' ? Text('') : Row(
                                          children: [
                                            Text('Note: ',style: GoogleFonts.openSans(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 15 : 17),
                                            ),),
                                            Text(ongoingBooking.details.toString(), style: GoogleFonts.openSans(
                                              color: kFalcoBlack,
                                              fontWeight: FontWeight.w800,
                                              fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 15 : 17),
                                            ),),
                                          ],
                                        ),
                                        ongoingBooking.deposit == null || ongoingBooking.deposit == '' ? Text('') : Row(
                                          children: [
                                            Text('Acconto: ',style: GoogleFonts.openSans(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 15 : 17),
                                            ),),
                                            Text(ongoingBooking.deposit.toString() + '€', style: GoogleFonts.openSans(
                                              color: kFalcoBlack,
                                              fontWeight: FontWeight.w800,
                                              fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 15 : 17),
                                            ),),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Stanza numnero : ',style: GoogleFonts.openSans(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 15 : 17),
                                            ),),
                                            Text(roomItem.roomNumber.toString(), style: GoogleFonts.openSans(
                                              color: kFalcoBlack,
                                              fontWeight: FontWeight.w800,
                                              fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 15 : 17),
                                            ),),
                                          ],
                                        ),
                                        Wrap(
                                          children: [
                                            Text('Tipologia stanza : ',style: GoogleFonts.openSans(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 15 : 17),
                                            ),),
                                            Text(roomItem.roomTypeModel!.typeName.toString(), style: GoogleFonts.openSans(
                                              color: kFalcoBlack,
                                              fontWeight: FontWeight.w800,
                                              fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 15 : 17),
                                            ),),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text('Letti : ',style: GoogleFonts.openSans(
                                              color: Colors.grey.shade600,
                                              fontWeight: FontWeight.w500,
                                              fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 15 : 17),
                                            ),),
                                            Text(roomTypeModelBedTypeToJson(roomItem.roomTypeModel!.bedType).toString(), style: GoogleFonts.openSans(
                                              color: kFalcoBlack,
                                              fontWeight: FontWeight.w800,
                                              fontSize: getProportionateScreenHeight(ongoingBooking.customerName!.length > 10 ? 15 : 17),
                                            ),),

                                          ],
                                        )


                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );

                  alreadyPresent.add(ongoingBooking.bookingId.toString());
                }

              }
            }
          }
        }
        rows.add(Row(children: roomListWidget,));

      }
    });

    //if(databundlenotifier.rooms.length > 13){
    //  rows.add(Row(children: headersList));
    //}

    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 80,bottom: 200),
            child: Column(
              children: rows,
            ),
          ),
        ),
        Container(color: Colors.white,child: Row(children: headersList)),
        databundlenotifier.searchBookList.isNotEmpty ? Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Text('  Risultati ricerca prenotazioni: ', style: GoogleFonts.openSans(
                  color: kRoomTypeColor,
                  fontWeight: FontWeight.w700,
                  fontSize: getProportionateScreenHeight(12),
                ),),
              ],
            ),
            SizedBox(
              height: 200,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: kFalcoBlack)
                ),
                child: buildRowWithReservationRetrieved(databundlenotifier),
              ),
            ),
          ],
        ) : SizedBox(height: 0,)
      ],
    );
  }



  BookingModel? retrieveReservationForCurrentDate(List<BookingModel> bookings,
      num roomId,
      DateTime date) {

    BookingModel? toReturn;
    bookings.forEach((element) {
      if(element.roomId == roomId && element.bookingDate == dateFormat.format(date)){
        toReturn = element;
      }
    });

    return toReturn;
  }

  List<String> getExclusionDatesFromBookList(List<BookingModel> bookListForCurrentRoom) {
    List<String> list = [];

    bookListForCurrentRoom.forEach((element) {
      for(int i = 0; i < int.parse(element.nightNumbers.toString()); i ++){
        list.add(dateFormat.format(dateFormat.parse(element.bookingDate!).add(Duration(days: i))));

      }
    });

    return list;

  }

  List<String> getFromBookListDateStart(List<BookingModel> bookListForCurrentRoom) {
    List<String> list = [];

    bookListForCurrentRoom.forEach((element) {
      list.add(dateFormat.format(dateFormat.parse(element.bookingDate!)));
    });
    return list;
  }

  buildRowWithReservationRetrieved(DataBundleNotifier databundlenotifier) {
    List<Widget> listReservation = [];
    databundlenotifier.searchBookList.forEach((booking) {

      RoomModel roomItem = databundlenotifier.getRoomById(booking.roomId!);

      listReservation.add(GestureDetector(
        onTap: (){
          databundlenotifier.clearBookingToMoveList();
          SideSheet.right(
              body: EditReservationDialog(
                bookingModel: booking,
                roomItem: roomItem,
                daysToAdd: daysToAdd,
              ), context: context);
        },

        child: Container(
          width: widthGeneral*multiplier * 2.3,
          height: heightGeneral*multiplier*2.8,
          color: Colors.grey.withOpacity(0.003),
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(11),
              ),
              elevation: 9,
              shadowColor: booking.sourceBooking == BookingModelSourceBooking.booking ? Colors.blueAccent : Colors.orange,
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              booking.paid == BookingModelPaid.pagato ? const Tooltip(message: 'Pagato',child: Icon(Icons.euro, size: 30,)) : const Text(''),
                              booking.sourceBooking == BookingModelSourceBooking.booking ? Tooltip(message: 'Prenotazione tramite Booking.com',child: Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVF3ZnMnnMEUTiQgqH-4UAXQQ0ET5EIA1VkaFio24agXRvehehS1VncLFa8YiLcEibaQQ&usqp=CAU', height: 30,)) : Text(''),
                            ],
                          ),

                        ],
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(booking.customerName!, style: GoogleFonts.openSans(
                            color: kRoomTypeColor,
                            fontWeight: FontWeight.w700,
                            fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                          ),),
                          Wrap(
                            children: [
                              Text('CheckIn: ', style: GoogleFonts.openSans(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),
                              Text(booking.bookingDate!, style: GoogleFonts.openSans(
                                color: kFalcoBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),
                            ],
                          ),
                          Wrap(
                            children: [
                              Text('CheckOut: ', style: GoogleFonts.openSans(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),
                              Text(retrieveDatePlusNight(booking) + '(${booking.nightNumbers} notti)', style: GoogleFonts.openSans(
                                color: kFalcoBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),
                            ],
                          ),
                          SizedBox(height: 3),
                          Wrap(
                            children: [
                              Icon(Icons.person, size: 30),
                              Text('X' + booking.guests.toString(), style: GoogleFonts.openSans(
                                color: kFalcoBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 16 : 18),
                              ),),
                              Text( ' - Stanza N°: ', style: GoogleFonts.openSans(
                                color: Colors.grey,
                                fontWeight: FontWeight.w600,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 16 : 18),
                              )),
                              Text(databundlenotifier.mapRoomsIdRoomNumber[booking.roomId].toString(), style: GoogleFonts.openSans(
                                color: kFalcoBlack,
                                fontWeight: FontWeight.w700,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 16 : 18),
                              )),

                            ],
                          ),
                          Divider(
                            color: Colors.grey.withOpacity(0.3),
                          ),
                          booking.details == null || booking.details == '' ? Text('') : Wrap(
                            children: [
                              Text('Note: ',style: GoogleFonts.openSans(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),
                              Text(booking.details.toString(), style: GoogleFonts.openSans(
                                color: kFalcoBlack,
                                fontWeight: FontWeight.w800,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),
                            ],
                          ),
                          booking.deposit == null || booking.deposit == '' ? Text('') : Wrap(
                            children: [
                              Text('Acconto: ',style: GoogleFonts.openSans(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),
                              Text(booking.deposit.toString() + '€', style: GoogleFonts.openSans(
                                color: kFalcoBlack,
                                fontWeight: FontWeight.w800,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),
                            ],
                          ),
                          Wrap(
                            children: [
                              Text('Stanza numnero: ',style: GoogleFonts.openSans(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),
                              Text(databundlenotifier.mapRoomsIdRoomNumber[booking.roomId].toString(), style: GoogleFonts.openSans(
                                color: kFalcoBlack,
                                fontWeight: FontWeight.w800,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),
                            ],
                          ),
                          Wrap(
                            children: [
                              Text('Tipologia stanza : ',style: GoogleFonts.openSans(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),
                              Text(roomItem.roomTypeModel!.typeName.toString(), style: GoogleFonts.openSans(
                                color: kFalcoBlack,
                                fontWeight: FontWeight.w800,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),

                            ],
                          ),
                          Wrap(
                            children: [
                              Text('Letti : ',style: GoogleFonts.openSans(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w500,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),
                              Text(roomTypeModelBedTypeToJson(roomItem.roomTypeModel!.bedType).toString(), style: GoogleFonts.openSans(
                                color: kFalcoBlack,
                                fontWeight: FontWeight.w800,
                                fontSize: getProportionateScreenHeight(booking.customerName!.length > 10 ? 15 : 17),
                              ),),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ));
    });
    return Row(
      children: listReservation,
    );
  }

  String retrieveDatePlusNight(BookingModel booking) {
    return dateFormat.format(dateFormat.parse(booking.bookingDate!).add(Duration(days: booking.nightNumbers!)));
  }

  buildMonthCalendarWidget() {
    return Wrap(
      children: [
        buildMonthWidget('Gennaio', 1),
        buildMonthWidget('Febbraio', 2),
        buildMonthWidget('Marzo', 3),
        buildMonthWidget('Aprile', 4),
        buildMonthWidget('Maggio', 5),
        buildMonthWidget('Giugno', 6),
        buildMonthWidget('Luglio', 7),
        buildMonthWidget('Agosto', 8),
        buildMonthWidget('Settembre', 9),
        buildMonthWidget('Ottobre', 10),
        buildMonthWidget('Novembre', 11),
        buildMonthWidget('Dicembre', 12),
      ],
    );
  }

  buildMonthWidget(String month, int monthNumber) {
    return SizedBox(
      width: getProportionateScreenWidth(80),
      height: 120,
      child: Card(
        shadowColor: kFalcoColor,
        elevation: 6,
        child: Center(
          child: ListTile(
            title: Text(month, style: GoogleFonts.openSans(
                color: Colors.grey.shade600,
                fontSize: getProportionateScreenHeight(18),
                fontWeight: FontWeight.w400
            ),),
            onTap: (){
              setState((){
                daysToAdd = 0;
                dataFromWhereToStartDrawing = DateTime.utc(DateTime.now().year, monthNumber, 1, 0, 0, 0, 0, 0);
              });
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}

class EditReservationDialog extends StatefulWidget {
  const EditReservationDialog({Key? key, required this.bookingModel, required this.roomItem, required this.daysToAdd}) : super(key: key);

  final BookingModel bookingModel;
  final RoomModel roomItem;
  final int daysToAdd;

  @override
  State<EditReservationDialog> createState() => _EditReservationDialogState();
}

class _EditReservationDialogState extends State<EditReservationDialog> {

  bool isFromBooking = false;
  bool isPaid = false;
  late BookingModel bookingModel;

  @override
  void initState() {
    bookingModel = widget.bookingModel;
    _customerController = TextEditingController(text: bookingModel.customerName);
    _nightNumberController = TextEditingController(text: bookingModel.nightNumbers.toString());
    _guestController = TextEditingController(text: bookingModel.guests.toString());
    _detailsController = TextEditingController(text: bookingModel.details);
    _depositController = TextEditingController(text: bookingModel.deposit);
    _totalController = TextEditingController(text: bookingModel.total);
    isFromBooking = bookingModel.sourceBooking == BookingModelSourceBooking.booking ? true : false;
    isPaid = bookingModel.paid == BookingModelPaid.pagato ? true : false;
    super.initState();
  }

  late TextEditingController _customerController;
  late TextEditingController _nightNumberController;
  late TextEditingController _guestController;
  late TextEditingController _detailsController;
  late TextEditingController _depositController;
  late TextEditingController _totalController;
  late String _errorMessage = '';

  @override
  Widget build(BuildContext context) {

    return Consumer<DataBundleNotifier>(
      builder: (child, databundlenotifier, _){
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 0, top: 0, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 0, top: 0, right: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Data arrivo: ', style: GoogleFonts.openSans(
                                    color: Colors.grey,
                                    fontSize: getProportionateScreenHeight(20),
                                    fontWeight: FontWeight.w600
                                )),
                                Text(widget.bookingModel.bookingDate.toString(), style: GoogleFonts.openSans(
                                    color: kFalcoColor,
                                    fontSize: getProportionateScreenHeight(30),
                                    fontWeight: FontWeight.w600
                                )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Ospiti: ', style: GoogleFonts.openSans(
                                    color: Colors.grey,
                                    fontSize: getProportionateScreenHeight(17),
                                    fontWeight: FontWeight.w600
                                )),
                                Text(widget.bookingModel.guests.toString(), style: GoogleFonts.openSans(
                                    color: kFalcoColor,
                                    fontSize: getProportionateScreenHeight(20),
                                    fontWeight: FontWeight.w600
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.openSans(
                        color: kFalcoBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(30),
                      ),
                      maxLength: 25,
                      textCapitalization: TextCapitalization.words,
                      controller: _customerController,
                      cursorColor: kRoomTypeColor,
                      decoration: InputDecoration(
                        fillColor: kRoomTypeColor,
                        focusColor: kRoomTypeColor,
                        iconColor: kRoomTypeColor,
                        hoverColor: kRoomTypeColor,
                        border: const UnderlineInputBorder(
                        ),
                        labelText: 'Nome',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.openSans(
                        color: kFalcoBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(26),
                      ),
                      maxLength: 2,
                      textCapitalization: TextCapitalization.words,
                      controller: _guestController,
                      cursorColor: kRoomTypeColor,
                      decoration: InputDecoration(
                        fillColor: kRoomTypeColor,
                        focusColor: kRoomTypeColor,
                        iconColor: kRoomTypeColor,
                        hoverColor: kRoomTypeColor,
                        border: const UnderlineInputBorder(
                        ),
                        labelText: 'Ospiti',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.openSans(
                        color: kFalcoBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(26),
                      ),
                      maxLength: 2,
                      textCapitalization: TextCapitalization.words,
                      controller: _nightNumberController,
                      cursorColor: kRoomTypeColor,
                      decoration: InputDecoration(
                        fillColor: kRoomTypeColor,
                        focusColor: kRoomTypeColor,
                        iconColor: kRoomTypeColor,
                        hoverColor: kRoomTypeColor,
                        border: const UnderlineInputBorder(
                        ),
                        labelText: 'Notti',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.openSans(
                        color: kFalcoBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(30),
                      ),
                      maxLength: 250,
                      textCapitalization: TextCapitalization.words,
                      controller: _detailsController,
                      cursorColor: kRoomTypeColor,
                      decoration: InputDecoration(
                        fillColor: kRoomTypeColor,
                        focusColor: kRoomTypeColor,
                        iconColor: kRoomTypeColor,
                        hoverColor: kRoomTypeColor,
                        border: const UnderlineInputBorder(
                        ),
                        labelText: 'Note',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.openSans(
                        color: kFalcoBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(30),
                      ),
                      maxLength: 150,
                      textCapitalization: TextCapitalization.words,
                      controller: _depositController,
                      cursorColor: kRoomTypeColor,
                      decoration: InputDecoration(
                        fillColor: kRoomTypeColor,
                        focusColor: kRoomTypeColor,
                        iconColor: kRoomTypeColor,
                        hoverColor: kRoomTypeColor,
                        border: const UnderlineInputBorder(
                        ),
                        labelText: 'Acconto',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.openSans(
                        color: kFalcoBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(30),
                      ),
                      maxLength: 150,
                      textCapitalization: TextCapitalization.words,
                      controller: _totalController,
                      cursorColor: kRoomTypeColor,
                      decoration: InputDecoration(
                        fillColor: kRoomTypeColor,
                        focusColor: kRoomTypeColor,
                        iconColor: kRoomTypeColor,
                        hoverColor: kRoomTypeColor,
                        border: const UnderlineInputBorder(
                        ),
                        labelText: 'Saldo',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.blue.shade700,
                          value: isFromBooking,
                          onChanged: (bool? value) {
                            switchBookingSource();
                          },
                        ),
                        Text(
                          'Prenotazione con Booking.com  ',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVF3ZnMnnMEUTiQgqH-4UAXQQ0ET5EIA1VkaFio24agXRvehehS1VncLFa8YiLcEibaQQ&usqp=CAU', height: 20,)
                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.green,
                          value: isPaid,
                          onChanged: (bool? value) {
                            switchPaidCheckBox();
                          },
                        ),
                        Text(
                          'Pagato',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                    Text(_errorMessage,style: GoogleFonts.openSans(
                        color: Colors.red,
                        fontSize: getProportionateScreenHeight(15),
                        fontWeight: FontWeight.w600
                    ),)
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Elimina Prenotazione'),
                              content: Text('Eliminare la prenotazione di ${bookingModel.guests}?',style: GoogleFonts.openSans(
                                  color: kFalcoBlack,
                                  fontSize: getProportionateScreenHeight(16),
                                  fontWeight: FontWeight.w500
                              ),),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Chiudi',style: GoogleFonts.openSans(
                                        color: kFalcoBlack,
                                        fontSize: getProportionateScreenHeight(16),
                                        fontWeight: FontWeight.w500
                                    ),)),
                                TextButton(
                                  onPressed: () async {
                                    Response apiV1BookingDeletebyidIdGet = await databundlenotifier.getSwaggerClient().apiV1BookingDeletebyidIdGet(id: int.parse(bookingModel.bookingId!.toString()));

                                    sleep(Duration(milliseconds: 200));

                                    if(apiV1BookingDeletebyidIdGet.statusCode == 200){
                                      const snackBar = SnackBar(
                                        duration: Duration(seconds: 1),
                                        backgroundColor: Colors.deepOrange,
                                        content: Text('Prenotazione eliminata'),
                                      );
                                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      sleep(Duration(milliseconds: 200));
                                      databundlenotifier.removeBookingFromList(bookingModel.bookingId!);

                                      databundlenotifier.calculateOnGoingBookings(databundlenotifier.bookings, widget.daysToAdd);

                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text('Elimina Prenotazione', style: GoogleFonts.openSans(
                                      color: kFalcoRed,
                                      fontSize: getProportionateScreenHeight(18),
                                      fontWeight: FontWeight.w500
                                  ),),
                                )
                              ],
                            );
                          });
                    },
                    child: Text('Elimina', style: GoogleFonts.openSans(
                        color: kFalcoRed,
                        fontSize: getProportionateScreenHeight(25),
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                  TextButton(
                    onPressed: () async {

                      if(_customerController.text == '' || _nightNumberController.text == '0' || _guestController.text == '0'){
                        const snackBar = SnackBar(
                          duration: Duration(seconds: 3),
                          backgroundColor: kFalcoRed,
                          content: Text('Errore. Nominativo prenotazione, numero ostpiti e numero notti obbligatorio'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }else{
                        Response response = await databundlenotifier.getSwaggerClient().apiV1BookingUpdatePut(
                            guests: int.parse(_guestController.text),
                            paid: isPaid ? bookingModelPaidToJson(BookingModelPaid.pagato) : bookingModelPaidToJson(BookingModelPaid.nonPagato),
                            deposit: _depositController.text,
                            total: _totalController.text,
                            sourceBooking: isFromBooking ? bookingModelSourceBookingToJson(BookingModelSourceBooking.booking) :  bookingModelSourceBookingToJson(BookingModelSourceBooking.$external),
                            details: _detailsController.text,
                            customerName: _customerController.text,
                            code: bookingModel.code,
                            roomId: bookingModel.roomId,
                            bookingDate: bookingModel.bookingDate,
                            nightNumbers: int.parse(_nightNumberController.text));
                        if(response.statusCode == 200){
                          Response response = await databundlenotifier.getSwaggerClient().apiV1BookingFindByCodeCodeGet(code: bookingModel.code);
                          print('Updated Book :' + response.body.toString());
                          if(response.statusCode == 200){
                            Response<List<BookingModel>> bookingModelList = await databundlenotifier.getSwaggerClient().apiV1BookingFindallGet();
                            databundlenotifier.setCurrentBookingList(bookingModelList.body!);
                          }
                          Navigator.of(context).pop();
                          const snackBar = SnackBar(
                            duration: Duration(seconds: 1),
                            backgroundColor: Colors.green,
                            content: Text('Prenotazione aggiornata con successo'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        }else{
                          setState((){
                            _errorMessage = response.error.toString();
                          });
                        }
                      }
                    },
                    child: Text('Aggiorna Prenotazione', style: GoogleFonts.openSans(
                        color: kFalcoColor,
                        fontSize: getProportionateScreenHeight(25),
                        fontWeight: FontWeight.w600
                    ),),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void switchBookingSource() {
    setState((){
      if(isFromBooking){
        isFromBooking = false;
      }else{
        isFromBooking = true;
      }
    });
  }

  void switchPaidCheckBox() {
    setState((){
      if(isPaid){
        isPaid = false;
      }else{
        isPaid = true;
      }
    });
  }
}


class AddReservationDialog extends StatefulWidget {
  const AddReservationDialog({Key? key, required this.roomItem, required this.now, required this.days, required this.daysToAdd}) : super(key: key);

  final RoomModel roomItem;
  final DateTime now;
  final int days;
  final int daysToAdd;

  @override
  State<AddReservationDialog> createState() => _AddReservationDialogState();
}

class _AddReservationDialogState extends State<AddReservationDialog> {

  bool isFromBooking = false;
  bool isPaid = false;
  String _error = '';
  TextEditingController _customerController = TextEditingController();
  TextEditingController _nightNumberController = TextEditingController(text: '');
  TextEditingController _guestController = TextEditingController(text: '');
  TextEditingController _detailsController = TextEditingController(text: '');
  TextEditingController _depositController = TextEditingController(text: '');
  TextEditingController _totalController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {

    return Consumer<DataBundleNotifier>(
      builder: (child, databundlenotifier, _){
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 0, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, bottom: 0, right: 20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Data arrivo: ', style: GoogleFonts.openSans(
                                    color: Colors.grey,
                                    fontSize: getProportionateScreenHeight(20),
                                    fontWeight: FontWeight.w600
                                )),
                                Text(getWeekDayNameByNumber(widget.now.add(Duration(days: widget.days)).weekday) + '  ' + widget.now.add(Duration(days: widget.days)).day.toString() + ' ' + getMonthByMonthNumber(widget.now.add(Duration(days: widget.days)).month), style: GoogleFonts.openSans(
                                    color: kFalcoColor,
                                    fontSize: getProportionateScreenHeight(25),
                                    fontWeight: FontWeight.w600
                                )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Numero Stanza: ', style: GoogleFonts.openSans(
                                    color: Colors.grey,
                                    fontSize: getProportionateScreenHeight(15),
                                    fontWeight: FontWeight.w600
                                )),
                                Text(widget.roomItem.roomNumber.toString(), style: GoogleFonts.openSans(
                                    color: kFalcoColor,
                                    fontSize: getProportionateScreenHeight(18),
                                    fontWeight: FontWeight.w600
                                )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Tipo Stanza: ', style: GoogleFonts.openSans(
                                    color: Colors.grey,
                                    fontSize: getProportionateScreenHeight(15),
                                    fontWeight: FontWeight.w600
                                )),
                                Text(widget.roomItem.roomTypeModel!.typeName.toString(),style: GoogleFonts.openSans(
                                    color: kFalcoColor,
                                    fontSize: getProportionateScreenHeight(18),
                                    fontWeight: FontWeight.w600
                                )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Ospiti: ', style: GoogleFonts.openSans(
                                    color: Colors.grey,
                                    fontSize: getProportionateScreenHeight(15),
                                    fontWeight: FontWeight.w600
                                )),
                                Text(widget.roomItem.roomTypeModel!.guests.toString(), style: GoogleFonts.openSans(
                                    color: kFalcoColor,
                                    fontSize: getProportionateScreenHeight(18),
                                    fontWeight: FontWeight.w600
                                )),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Letto/i: ', style: GoogleFonts.openSans(
                                    color: Colors.grey,
                                    fontSize: getProportionateScreenHeight(15),
                                    fontWeight: FontWeight.w600
                                )),
                                Text(roomTypeModelBedTypeToJson(
                                    widget.roomItem.roomTypeModel!.bedType
                                ).toString(), style: GoogleFonts.openSans(
                                    color: kFalcoColor,
                                    fontSize: getProportionateScreenHeight(18),
                                    fontWeight: FontWeight.w600
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.openSans(
                        color: kFalcoBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(25),
                      ),
                      maxLength: 25,
                      textCapitalization: TextCapitalization.words,
                      controller: _customerController,
                      cursorColor: kRoomTypeColor,
                      decoration: InputDecoration(
                        fillColor: kRoomTypeColor,
                        focusColor: kRoomTypeColor,
                        iconColor: kRoomTypeColor,
                        hoverColor: kRoomTypeColor,
                        border: const UnderlineInputBorder(
                        ),
                        labelText: 'Nome',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.openSans(
                        color: kFalcoBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(25),
                      ),
                      maxLength: 2,
                      textCapitalization: TextCapitalization.words,
                      controller: _guestController,
                      cursorColor: kRoomTypeColor,
                      decoration: InputDecoration(
                        fillColor: kRoomTypeColor,
                        focusColor: kRoomTypeColor,
                        iconColor: kRoomTypeColor,
                        hoverColor: kRoomTypeColor,
                        border: const UnderlineInputBorder(
                        ),
                        labelText: 'Ospiti',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.openSans(
                        color: kFalcoBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(25),
                      ),
                      maxLength: 2,
                      textCapitalization: TextCapitalization.words,
                      controller: _nightNumberController,
                      cursorColor: kRoomTypeColor,
                      decoration: InputDecoration(
                        fillColor: kRoomTypeColor,
                        focusColor: kRoomTypeColor,
                        iconColor: kRoomTypeColor,
                        hoverColor: kRoomTypeColor,
                        border: const UnderlineInputBorder(
                        ),
                        labelText: 'Notti',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.openSans(
                        color: kFalcoBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(25),
                      ),
                      maxLength: 250,
                      textCapitalization: TextCapitalization.words,
                      controller: _detailsController,
                      cursorColor: kRoomTypeColor,
                      decoration: InputDecoration(
                        fillColor: kRoomTypeColor,
                        focusColor: kRoomTypeColor,
                        iconColor: kRoomTypeColor,
                        hoverColor: kRoomTypeColor,
                        border: const UnderlineInputBorder(
                        ),
                        labelText: 'Note',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.openSans(
                        color: kFalcoBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(25),
                      ),
                      maxLength: 150,
                      textCapitalization: TextCapitalization.words,
                      controller: _depositController,
                      cursorColor: kRoomTypeColor,
                      decoration: InputDecoration(
                        fillColor: kRoomTypeColor,
                        focusColor: kRoomTypeColor,
                        iconColor: kRoomTypeColor,
                        hoverColor: kRoomTypeColor,
                        border: const UnderlineInputBorder(
                        ),
                        labelText: 'Acconto',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    TextFormField(
                      style: GoogleFonts.openSans(
                        color: kFalcoBlack,
                        fontWeight: FontWeight.w500,
                        fontSize: getProportionateScreenHeight(30),
                      ),
                      maxLength: 150,
                      textCapitalization: TextCapitalization.words,
                      controller: _totalController,
                      cursorColor: kRoomTypeColor,
                      decoration: InputDecoration(
                        fillColor: kRoomTypeColor,
                        focusColor: kRoomTypeColor,
                        iconColor: kRoomTypeColor,
                        hoverColor: kRoomTypeColor,
                        border: const UnderlineInputBorder(
                        ),
                        labelText: 'Saldo',
                        labelStyle: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(15),
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.blue.shade700,
                          value: isFromBooking,
                          onChanged: (bool? value) {
                            switchBookingSource();
                          },
                        ),
                        Text(
                          'Da Booking.com  ',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVF3ZnMnnMEUTiQgqH-4UAXQQ0ET5EIA1VkaFio24agXRvehehS1VncLFa8YiLcEibaQQ&usqp=CAU', height: 20,)

                      ],
                    ),
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.green,
                          value: isPaid,
                          onChanged: (bool? value) {
                            switchPaidCheckBox();
                          },
                        ),
                        Text(
                          'Pagato',
                          style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontSize: getProportionateScreenHeight(18),
                              fontWeight: FontWeight.w600
                          ),
                        ),

                      ],
                    ),
                    Text(_error,style: GoogleFonts.openSans(
                        color: Colors.red,
                        fontSize: getProportionateScreenHeight(15),
                        fontWeight: FontWeight.w600
                    ),)
                  ],
                ),
              ),
              TextButton(
                onPressed: () async {

                  if(_customerController.text == '' || _nightNumberController.text == '0' || _guestController.text == '0'){
                    const snackBar = SnackBar(
                      duration: Duration(seconds: 3),
                      backgroundColor: kFalcoRed,
                      content: Text('Errore. Nominativo prenotazione, numero ostpiti e numero notti obbligatorio'),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }else{
                    String currentCode = Uuid().v1().toString();
                    Response apiV1BookingSavePost = await databundlenotifier.getSwaggerClient().apiV1BookingSavePost(
                        customerName: _customerController.text,
                        bookingDate: dateFormat.format(widget.now.add(Duration(days: widget.days))),
                        nightNumbers: int.parse(_nightNumberController.text),
                        guests: int.parse(_guestController.text),
                        details: _detailsController.text,
                        paid: isPaid ? bookingModelPaidToJson(BookingModelPaid.pagato) : bookingModelPaidToJson(BookingModelPaid.nonPagato),
                        deposit: _depositController.text,
                        total: _totalController.text,
                        sourceBooking: isFromBooking ? bookingModelSourceBookingToJson(BookingModelSourceBooking.booking) :  bookingModelSourceBookingToJson(BookingModelSourceBooking.$external),
                        code: currentCode,
                        roomId: int.parse(widget.roomItem.roomId.toString())
                    );
                    if(apiV1BookingSavePost.statusCode == 200){

                      Response response = await databundlenotifier.getSwaggerClient().apiV1BookingFindByCodeCodeGet(code: currentCode);

                      sleep(Duration(milliseconds: 200));
                      if(response.statusCode == 200){
                        databundlenotifier.updateBookingList(response.body);
                        sleep(Duration(milliseconds: 200));
                        databundlenotifier.calculateOnGoingBookings(databundlenotifier.bookings, widget.daysToAdd);
                      }

                      final snackBar = SnackBar(
                        duration: Duration(seconds: 1),
                        backgroundColor: kFalcoColor,
                        content: const Text('Prenotazione salvata correttamente'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      databundlenotifier.resetavailableRoomsForReservation();
                      Navigator.of(context).pop();
                    }else{
                      print(apiV1BookingSavePost.error.toString());
                      setState((){
                        _error = apiV1BookingSavePost.error.toString();
                      });


                    }
                  }

                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Text('Crea Prenotazione', style: GoogleFonts.openSans(
                      color: kFalcoColor,
                      fontSize: getProportionateScreenHeight(25),
                      fontWeight: FontWeight.w600
                  ),),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void switchBookingSource() {
    setState((){
      if(isFromBooking){
        isFromBooking = false;
      }else{
        isFromBooking = true;
      }
    });
  }

  void switchPaidCheckBox() {
    setState((){
      if(isPaid){
        isPaid = false;
      }else{
        isPaid = true;
      }
    });
  }
}