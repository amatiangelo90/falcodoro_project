import 'package:FalcoManager/utils/constants.dart';
import 'package:FalcoManager/databundleprovider.dart';
import 'package:FalcoManager/falcomanager/swaggermodel.models.swagger.dart';
import 'package:chopper/chopper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';

import '../../utils/size_config.dart';

class AddBookingScreen extends StatefulWidget {
  const AddBookingScreen({Key? key}) : super(key: key);

  static const String route = 'addbooking';

  @override
  State<AddBookingScreen> createState() => _AddBookingScreenState();
}

class _AddBookingScreenState extends State<AddBookingScreen> {
  String _currenGuest = '';
  String _guests = '1';

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");

  RoomModel roomSelected = RoomModel(
      roomNumber: 0,
      roomId: 0
  );


  @override
  void initState() {
    roomSelected = RoomModel(
        roomNumber: 0,
        roomId: 0
    );
    _currentDateRange = DateRangePickerSelectionChangedArgs(DateRangePickerSelectionChangedArgs);
    _guests = '1';
    _currenGuest = '';
    super.initState();
  }

  GlobalKey _globalKey = GlobalKey();
  DateRangePickerSelectionChangedArgs _currentDateRange = DateRangePickerSelectionChangedArgs(DateRangePickerSelectionChangedArgs);

  @override
  Widget build(BuildContext context) {

    return Consumer<DataBundleNotifier>(
      builder: (child, databundle, _){

        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () async {

                    String currentCode = Uuid().v1().toString();
                    Response apiV1BookingSavePost = await databundle.getSwaggerClient().apiV1BookingSavePost(
                      customerName: _currenGuest,
                      nightNumbers: 3,

                      code: currentCode,
                      roomId: int.parse(roomSelected.roomId.toString())
                    );
                    if(apiV1BookingSavePost.statusCode == 200){

                      Response response = await databundle.getSwaggerClient().apiV1BookingFindByCodeCodeGet(code: currentCode);

                      if(response.statusCode == 200){
                        databundle.updateBookingList(response.body);
                      }

                      final snackBar = SnackBar(
                        duration: Duration(seconds: 1),
                        backgroundColor: kFalcoColor,
                        content: const Text('Prenotazione salvata correttamente'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      databundle.resetavailableRoomsForReservation();
                      refreshData();
                    }else{
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 3),
                        backgroundColor: kFalcoRed,
                        content: Text('Errore.' + apiV1BookingSavePost.error.toString()),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  },
                  icon: Icon(Icons.check, color: Colors.white, size: getProportionateScreenHeight(30)),
                ),
              ),
            ],
            title: Text("Effettua Prenotazioni", style: GoogleFonts.openSans(
              color: Colors.white,
            ),),
            backgroundColor: kFalcoColor,
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                  child: TextFormField(
                    key: _globalKey,
                    style: GoogleFonts.openSans(
                      color: kFalcoBlack,
                      fontWeight: FontWeight.w500,
                      fontSize: getProportionateScreenHeight(27),
                    ),
                    maxLength: 25,
                    textCapitalization: TextCapitalization.words,

                    onChanged: (guest){
                      changeUserState(guest);
                    },
                    cursorColor: kRoomTypeColor,
                    decoration: InputDecoration(
                      fillColor: kRoomTypeColor,
                      focusColor: kRoomTypeColor,
                      iconColor: kRoomTypeColor,
                      hoverColor: kRoomTypeColor,
                      border: const UnderlineInputBorder(
                      ),
                      labelText: 'Nome ospite',
                      labelStyle: GoogleFonts.openSans(
                          color: Colors.black,
                          fontSize: getProportionateScreenHeight(20),
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 10,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Ospiti        ',style: GoogleFonts.openSans(
                                  color: Colors.black,
                                  fontSize: getProportionateScreenHeight(20),
                                  fontWeight: FontWeight.w600
                              ),),
                            ),
                          ],
                        ),

                        Row(
                          children: [
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                focusColor: kRoomTypeColor,
                                isExpanded: true,
                                hint: Row(
                                  children: const [
                                    Icon(
                                      Icons.list,
                                      size: 20,
                                      color: kRoomTypeColor,
                                    ),
                                    SizedBox(
                                      width: 6,
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Select Item',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: kRoomTypeColor,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                items: ['1','2','3','4','5','6','7','8','9','10','11','12','13','14','15']
                                    .map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(
                                    item,
                                    style: GoogleFonts.openSans(
                                        color: Colors.black,
                                        fontSize: getProportionateScreenHeight(20),
                                        fontWeight: FontWeight.w600
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ))
                                    .toList(),
                                value: _guests,
                                onChanged: (value) {
                                  setState(() {
                                    _guests = value as String;
                                  });
                                  databundle.resetavailableRoomsForReservation();
                                },
                                icon: const Icon(
                                  Icons.arrow_forward_ios_outlined,
                                ),
                                iconSize: 14,
                                iconEnabledColor: kFalcoColor,
                                iconDisabledColor: Colors.grey,
                                buttonHeight: 50,
                                buttonWidth: getProportionateScreenWidth(300),
                                buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                                buttonDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: kFalcoColor,
                                  ),
                                  color: Colors.white,
                                ),
                                buttonElevation: 5,
                                itemHeight: 40,
                                itemPadding: const EdgeInsets.only(left: 14, right: 14),
                                dropdownPadding: null,
                                dropdownDecoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),
                                dropdownElevation: 10,
                                scrollbarRadius: const Radius.circular(40),
                                scrollbarThickness: 10,
                                scrollbarAlwaysShow: true,
                                offset: const Offset(-20, 0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(300),
                  width: getProportionateScreenWidth(300),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SfDateRangePicker(
                      selectionTextStyle: GoogleFonts.openSans(
                          color: Colors.white,
                          fontSize: getProportionateScreenHeight(17),
                          fontWeight: FontWeight.w400
                      ),
                      rangeSelectionColor: Colors.green.withOpacity(0.3),
                      endRangeSelectionColor: kFalcoColor,
                      startRangeSelectionColor: kFalcoColor,

                      onSelectionChanged: (s){
                        setState((){
                          _currentDateRange = s;
                        });
                      },
                      selectionMode: DateRangePickerSelectionMode.range,
                    ),
                  ),
                ),
                Divider(
                  color: kFalcoColor,
                  endIndent: 10,
                  indent: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(flex: 2,child: Row(
                      children: [
                        Text('   Sign/Sign.ra: ', style: GoogleFonts.openSans(
                            color: Colors.grey.shade600,
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.w400
                        )),
                        Text(_currenGuest, style: GoogleFonts.openSans(
                            color: kFalcoBlack,
                            fontSize: getProportionateScreenHeight(20),
                            fontWeight: FontWeight.w600
                        )),
                      ],
                    ),),
                    Expanded(flex: 2,child: Row(
                      children: [
                        Text('Data: ', style: GoogleFonts.openSans(
                            color: Colors.grey.shade600,
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.w400
                        )),
                        Text(printRange(_currentDateRange), style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(20),
                            fontWeight: FontWeight.w600
                        )),
                      ],
                    ),),
                    Expanded(flex: 2,child: Row(
                      children: [
                        Text('Ospiti: ', style: GoogleFonts.openSans(
                            color: Colors.grey.shade600,
                            fontSize: getProportionateScreenHeight(18),
                            fontWeight: FontWeight.w400
                        )),
                        Text(_guests, style: GoogleFonts.openSans(
                            color: Colors.black,
                            fontSize: getProportionateScreenHeight(20),
                            fontWeight: FontWeight.w600
                        )),
                      ],
                    ),),
                    Expanded(flex: 2, child: isEveryThingReadyToGo(_currenGuest, _currentDateRange, _guests) ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: kFalcoColor
                          ),
                          onPressed: (){
                            databundle.calculateListAvailableRooms(databundle, _guests);
                          }, child: const Text('Cerca soluzioni')),
                    ) : const Text(''),)
                  ],
                ),

                databundle.availableRoomsForReservation.isNotEmpty ? buildRoomsList(databundle.availableRoomsForReservation) : Text('Nessuna soluzione trovata'),
              ],
            ),
          ),
        );
      },
    );
  }

  String printRange(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      return '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
          ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
    } else if (args.value is DateTime) {
      return args.value.toString();
    } else if (args.value is List<DateTime>) {
      return args.value.length.toString();
    } else {
      return '';
    }
  }

  DateTime? getEndDateFromRangePicker(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      return args.value.endDate;
    }else{
      return null;
    }
  }

  DateTime? getStartDateFromRangePicker(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      return args.value.startDate;
    }else{
      return null;
    }
  }

  isEveryThingReadyToGo(String currenGuest, DateRangePickerSelectionChangedArgs args, String guestsNumber) {
    bool result = false;
    if(currenGuest != ''){
      result = true;
    }else{
      result = false;
    }

    if(guestsNumber != ''){
      result = true;
    }else{
      result = false;
    }

    if (args.value is PickerDateRange) {
      result = true;
    } else if (args.value is DateTime) {
      result = true;
    } else if (args.value is List<DateTime>) {
      result = false;
    } else {
      result = false;
    }
    return result;
  }

  Widget buildRoomsList(List<RoomModel> roomModels){

    List<Widget> roomWidget = [];

    roomModels.forEach((room) {
      roomWidget.add(SizedBox(
        width: getProportionateScreenWidth(100),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(

            shadowColor: roomSelected.roomNumber == room.roomNumber ? kFalcoColor : Colors.grey,
            elevation: roomSelected.roomNumber == room.roomNumber ? 10 : 2,
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('Stanza n°  ', style: GoogleFonts.openSans(
                          color: Colors.grey.shade600,
                          fontSize: getProportionateScreenHeight(18),
                          fontWeight: FontWeight.w400
                      ),),
                      Text(room.roomNumber.toString(), style: GoogleFonts.openSans(
                          color: kFalcoColor,
                          fontSize: getProportionateScreenHeight(roomSelected.roomNumber == room.roomNumber ? 30 : 25),
                          fontWeight: FontWeight.w800
                      ),),
                    ],
                  ),
                  roomSelected.roomNumber == room.roomNumber ? Icon(Icons.check, color: kFalcoColor, size: getProportionateScreenHeight(50),) : Text(''),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment:CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Ospiti: ', style: GoogleFonts.openSans(
                          color: Colors.grey.shade600,
                          fontSize: getProportionateScreenHeight(15),
                          fontWeight: FontWeight.w400
                      ),),
                      Text(room.roomTypeModel!.guests.toString(), style: GoogleFonts.openSans(
                          color: kFalcoBlack,
                          fontSize: getProportionateScreenHeight(roomSelected.roomNumber == room.roomNumber ? 20 : 17),
                          fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Tipo letto/i: ', style: GoogleFonts.openSans(
                          color: Colors.grey.shade600,
                          fontSize: getProportionateScreenHeight(15),
                          fontWeight: FontWeight.w400
                      ),),
                      Text(roomTypeModelBedTypeToJson(
                          room.roomTypeModel!.bedType
                      ).toString(), style: GoogleFonts.openSans(
                          color: kFalcoBlack,
                          fontSize: getProportionateScreenHeight(roomSelected.roomNumber == room.roomNumber ? 16 : 11),
                          fontWeight: FontWeight.w600
                      ),),
                    ],
                  ),

                ],
              ),
              onTap: (){
                setState((){
                  roomSelected = room;
                });
              },
            ),
          ),
        ),
      ));
    });

    return Padding(
      padding: const EdgeInsets.all(38.0),
      child: Wrap(
        children: roomWidget,
      ),
    );
  }

  void refreshData() {
    setState((){
      _currentDateRange = DateRangePickerSelectionChangedArgs(DateRangePickerSelectionChangedArgs);
      _guests = '1';

    });
    changeUserState('');
    _globalKey.currentState?.initState();
  }

  List<String> buildListDateBetweenStartAndEndInStringFormat(DateRangePickerSelectionChangedArgs args) {
    List<String> dateResultList = [];

    if (args.value is PickerDateRange) {
      PickerDateRange pickerDateRange = args.value;
      for(DateTime? date = pickerDateRange.startDate; date!.isBefore(pickerDateRange.endDate!.add(Duration(days: 1))); date.add(Duration(days: 1))){
        dateResultList.add(
          dateFormat.format(date)
        );
      }
      return dateResultList;
    } else if (args.value is DateTime) {
      return [];
    } else if (args.value is List<DateTime>) {
      return [];
    } else {
      return [];
    }
  }

  void changeUserState(String guest) {
    setState((){
      _currenGuest = guest;
    });
  }
}
