import 'package:FalcoManager/utils/constants.dart';
import 'package:FalcoManager/databundleprovider.dart';
import 'package:FalcoManager/falcomanager/swaggermodel.models.swagger.dart';
import 'package:FalcoManager/utils/size_config.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'add_room_type.dart';

class RoomTypeManagerScreen extends StatefulWidget {
  const RoomTypeManagerScreen({Key? key}) : super(key: key);

  static final String route = 'room_type_manager_screen';

  @override
  State<RoomTypeManagerScreen> createState() => _RoomTypeManagerScreenState();
}

class _RoomTypeManagerScreenState extends State<RoomTypeManagerScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<DataBundleNotifier>(
      builder: (child, databundlenotifier, _){
        return Scaffold(

          appBar: AppBar(
            backgroundColor: kFalcoBlack,
            title: Text('Aggiungi tipologia'),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: kFalcoBlack,
            onPressed: (){
              Navigator.pushNamed(context, AddRoomTypeScreen.route);
            },
            tooltip: 'Aggiungi Tipologia',
            child: Icon(Icons.add, color: Colors.white),
          ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              color: Colors.white,
              child: buildRoomTypeList(
                  databundlenotifier
              ),
            ),
          ),
        );
      },

    );
  }

  buildRoomTypeList(DataBundleNotifier databundlenotifier) {
    List<Widget> item = [];

    databundlenotifier.roomTypes.forEach((roomType) {
      item.add(SizedBox(
        width: MediaQuery.of(context).size.width - 10,
        height: MediaQuery.of(context).size.height * 0.15,
        child: Card(
          color: Colors.white,
          elevation: 0.5,
          shadowColor: kRoomTypeColor,
          child: Row(
            children: [
              RawMaterialButton(
                onPressed: () {
                  databundlenotifier.restoreRoomNumberForGeneration();
                  showDialog(context: context, builder: (BuildContext context){
                    return AlertDialog(
                      title: Text("Genera alloggi per tipologia stanza " + roomType.typeName.toString(), textAlign: TextAlign.center, style: GoogleFonts.openSans(
                        color: kRoomTypeColor,
                        fontWeight: FontWeight.w400,
                        fontSize: getProportionateScreenHeight(20),
                      )),
                      content: SizedBox(
                        height: getProportionateScreenHeight(400),
                        child: Consumer<DataBundleNotifier>(
                          builder: (c, databundle, _){
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(8,getProportionateScreenHeight(100),8,8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      RawMaterialButton(
                                        onPressed: () {
                                          databundle.decrementRoomNumbersOnGeneration();
                                        },
                                        elevation: 2.0,
                                        fillColor: kFalcoRed,
                                        padding: EdgeInsets.all(15.0),
                                        shape: CircleBorder(),
                                        child: Text(
                                          '-', style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: getProportionateScreenHeight(40),
                                        ),),
                                      ),
                                      Text(databundle.roomNumbersForGeneration.toString(), style: GoogleFonts.openSans(
                                        color: kRoomTypeColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: getProportionateScreenHeight(25),
                                      )),
                                      RawMaterialButton(
                                        onPressed: () {
                                          databundle.incrementRoomNumbersOnGeneration();
                                        },
                                        elevation: 2.0,
                                        fillColor: kFalcoColor,
                                        padding: EdgeInsets.all(15.0),
                                        shape: CircleBorder(),
                                        child: Text(
                                          '+', style: GoogleFonts.openSans(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: getProportionateScreenHeight(40),
                                        ),),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(60),
                                  width: getProportionateScreenWidth(100),

                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if(databundle.roomNumbersForGeneration > 0){
                                        for(int i = 0; i < databundle.roomNumbersForGeneration; i++){
                                          await databundle.getSwaggerClient().apiV1RoomSavePost(
                                            roomNumber: 0,
                                            roomTypeModelRoomTypeId: roomType.roomTypeId?.toInt(),
                                          );
                                        }
                                      }

                                      Response<List<RoomModel>> rooms = await databundle.getSwaggerClient().apiV1RoomFindallGet();
                                      databundle.setCurrentRoomList(rooms.body!);

                                      Navigator.of(context).pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                        primary: kFalcoBlack

                                    ),
                                    child: Text('Genera Alloggi', style: GoogleFonts.openSans(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: getProportionateScreenHeight(30),
                                    ),),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  });
                },
                elevation: 2.0,
                fillColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
                child: Text(
                  databundlenotifier.getRoomNumbersByRoomTypeName(
                    roomType.typeName!
                  ), style: GoogleFonts.openSans(
                  color: kFalcoBlack,
                  fontWeight: FontWeight.w600,
                  fontSize: getProportionateScreenHeight(30),
                ),),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(roomType.typeName.toString(), overflow: TextOverflow.visible, style: GoogleFonts.openSans(
                      color: kFalcoBlack,
                      fontWeight: FontWeight.w600,
                      fontSize: getProportionateScreenHeight(22),
                    )),
                    SizedBox(height: 10,),
                    Text(roomTypeModelBedTypeToJson(
                        roomType.bedType).toString(), overflow: TextOverflow.visible, style: GoogleFonts.openSans(
                      color: kRoomTypeColor,
                      fontWeight: FontWeight.w800,
                      fontSize: getProportionateScreenHeight(13),
                    )),
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Text(roomType.guests.toString(), style: GoogleFonts.openSans(
                    color: kRoomTypeColor,
                    fontWeight: FontWeight.w600,
                    fontSize: getProportionateScreenHeight(25),
                  ))),

              RawMaterialButton(
                onPressed: () async {
                  try{
                    await databundlenotifier.getSwaggerClient().apiV1RoomtypeDeletebyidIdGet(
                        id: roomType.roomTypeId!.toInt()
                    );
                    Response<List<RoomTypeModel>> response = await databundlenotifier.getSwaggerClient().apiV1RoomtypeFindallGet();
                    databundlenotifier.setCurrentRoomTypesList(response.body!);

                  }catch(e){
                    print('Error: ' + e.toString());
                  }
                },
                elevation: 1.0,
                fillColor: Colors.white,
                padding: EdgeInsets.all(15.0),
                shape: CircleBorder(),
                child: Icon(Icons.delete_forever, color: kFalcoRed, size: getProportionateScreenHeight(40),),
              ),
            ],
          ),
        ),
      ));
    });

    item.add(SizedBox(height: 100,));
    return Column(
      children: item,
    );
  }
}
