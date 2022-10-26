import 'package:FalcoManager/utils/constants.dart';
import 'package:FalcoManager/databundleprovider.dart';
import 'package:FalcoManager/utils/size_config.dart';
import 'package:chopper/chopper.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../falcomanager/swaggermodel.enums.swagger.dart';
import '../../falcomanager/swaggermodel.models.swagger.dart';

class AddRoomTypeScreen extends StatefulWidget {
  const AddRoomTypeScreen({Key? key}) : super(key: key);

  static const String route = 'add_room_type';
  @override
  State<AddRoomTypeScreen> createState() => _AddRoomTypeScreenState();
}

class _AddRoomTypeScreenState extends State<AddRoomTypeScreen> {

  TextEditingController _typeRoomNameController = TextEditingController();
  String guests = '1';

  String dropdownvalue = 'SINGOLO_X_1';

  @override
  Widget build(BuildContext context) {
    return Consumer<DataBundleNotifier>(
      builder: (child, dataBundleNotifier, _){
        return Scaffold(
          appBar: AppBar(
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(onPressed: () async {
                  try{
                    Response response = await dataBundleNotifier.getSwaggerClient().apiV1RoomtypeSavePost(
                        roomTypeId: 0,
                        typeName: _typeRoomNameController.text,
                        guests: int.parse(guests),
                        bedType: dropdownvalue);

                    if(response.statusCode == 200){
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 1),
                        backgroundColor: kFalcoColor,
                        content: const Text('Bravo Cardoncello. Tipologia stanza creata!'),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      setState((){
                        _typeRoomNameController.clear();
                        guests = '1';
                        dropdownvalue = 'SINGOLO_X_1';
                      });
                    }else{
                      final snackBar = SnackBar(
                        duration: Duration(seconds: 4),
                        backgroundColor: kFalcoRed,
                        content: Text('Errore server. Status Code: ' + response.statusCode.toString() + ". Error message: " + response.error.toString()),
                        action: SnackBarAction(
                          label: '',
                          onPressed: () {
                            // Some code to undo the change.
                          },
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }catch(e){
                    print(e);
                  }
                  Response<List<RoomTypeModel>> listRoomType = await dataBundleNotifier.getSwaggerClient().apiV1RoomtypeFindallGet();
                  dataBundleNotifier.setCurrentRoomTypesList(listRoomType.body!);

                }, icon: const Icon(Icons.check, color: Colors.white,)),
              )
            ],
            backgroundColor: kFalcoBlack,
            title: Text("Crea tipologia stanza",
              style: GoogleFonts.openSans(
                color: Colors.white,
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
                child: TextFormField(
                  style: GoogleFonts.openSans(
                    color: kFalcoBlack,
                    fontWeight: FontWeight.w500,
                    fontSize: getProportionateScreenHeight(27),
                  ),
                  maxLength: 25,
                  textCapitalization: TextCapitalization.words,
                  controller: _typeRoomNameController,
                  cursorColor: kRoomTypeColor,
                  decoration: InputDecoration(
                    fillColor: kRoomTypeColor,
                    focusColor: kRoomTypeColor,
                    iconColor: kRoomTypeColor,
                    hoverColor: kRoomTypeColor,
                    border: const UnderlineInputBorder(
                    ),
                    labelText: 'Nome Tipologia Stanza',
                    labelStyle: GoogleFonts.openSans(
                        color: Colors.black,
                        fontSize: getProportionateScreenHeight(20),
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width - 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Tipologia Letti',style: GoogleFonts.openSans(
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
                              items: createList()
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
                              value: dropdownvalue,
                              onChanged: (value) {

                                setState(() {
                                  dropdownvalue = value.toString();
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_outlined,
                              ),
                              iconSize: 14,
                              iconEnabledColor: kRoomTypeColor,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: getProportionateScreenWidth(300),
                              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: kRoomTypeColor,
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
              Padding(
                padding: const EdgeInsets.all(18.0),
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
                              items: ['1','2','3','4','5','6','7','8']
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
                              value: guests,
                              onChanged: (value) {
                                setState(() {
                                  guests = value as String;
                                });
                              },
                              icon: const Icon(
                                Icons.arrow_forward_ios_outlined,
                              ),
                              iconSize: 14,
                              iconEnabledColor: kRoomTypeColor,
                              iconDisabledColor: Colors.grey,
                              buttonHeight: 50,
                              buttonWidth: getProportionateScreenWidth(300),
                              buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                              buttonDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(
                                  color: kRoomTypeColor,
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
            ],
          ),
        );
      },
    );
  }

  List<String> createList() {
    List<String> list = [];
    RoomTypeModelBedType.values.forEach((element) {
      if(element != 'swaggerGeneratedUnknown'){
      list.add(roomTypeModelBedTypeToJson(
          element
      ).toString());
      }
    });
    return list;
  }
}
