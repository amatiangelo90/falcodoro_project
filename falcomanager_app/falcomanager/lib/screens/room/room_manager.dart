import 'package:FalcoManager/utils/constants.dart';
import 'package:FalcoManager/databundleprovider.dart';
import 'package:FalcoManager/falcomanager/swaggermodel.models.swagger.dart';
import 'package:FalcoManager/utils/size_config.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RoomManagerScreen extends StatefulWidget {
  const RoomManagerScreen({Key? key}) : super(key: key);

  static final String route = 'room_manager_screen';
  @override
  State<RoomManagerScreen> createState() => _RoomManagerScreenState();
}

class _RoomManagerScreenState extends State<RoomManagerScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<DataBundleNotifier>(
      builder: (child, databundlenotifier, _){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: kFalcoBlack,
            title: Text('Gestione Stanze', style: TextStyle(fontSize: getProportionateScreenHeight(30)),),
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

    Set<String?> roomTypes = Set();

    databundlenotifier.rooms.forEach((element) {
      roomTypes.add(element.roomTypeModel?.typeName);
      print('Type Name: ' + element.roomTypeModel!.typeName.toString());
    });


    roomTypes.forEach((element) {
      item.add(Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: SizedBox(
              width: 200,
              child: Text(element.toString(), overflow: TextOverflow.visible,style: GoogleFonts.openSans(
                color: kRoomColor,

                fontWeight: FontWeight.w600,
                fontSize: getProportionateScreenHeight(20),
              )),
            ),
          ),
        ],
      ));

      databundlenotifier.rooms.forEach((room) {
        if(room.roomTypeModel?.typeName == element){
          TextEditingController controller;
          if(room.roomNumber != 0){
            controller = TextEditingController(text: room.roomNumber.toString());
          }else{
            controller = TextEditingController();
          }
          item.add(SizedBox(
            width: MediaQuery.of(context).size.width - 10,
            height: MediaQuery.of(context).size.height * 0.10,
            child: Card(
              color: Colors.white,
              elevation: 0.5,
              shadowColor: kRoomTypeColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.2,
                          child: TextField(
                            textAlign: TextAlign.center,
                            style: GoogleFonts.openSans(
                              color: kRoomTypeColor,
                              fontWeight: FontWeight.w700,
                              fontSize: getProportionateScreenHeight(30),
                            ),
                            maxLength: 4,
                            controller: controller,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Inserire Numero stanza',
                              hintStyle: GoogleFonts.openSans(
                                color: kFalcoBlack,
                                fontWeight: FontWeight.w100,
                                fontSize: getProportionateScreenHeight(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      RawMaterialButton(
                        onPressed: () async {
                          try{
                            if(int.tryParse(controller.text) != null){
                              Response response = await databundlenotifier.getSwaggerClient().apiV1RoomUpdatePut(
                                  roomId: room.roomId?.toInt(),
                                  roomNumber: int.parse(controller.text)
                              );

                              if(response.statusCode != 200){
                                const snackBar = SnackBar(
                                  duration: Duration(seconds: 2),
                                  backgroundColor: kFalcoRed,
                                  content: Text('Errore. Esiste già una stanza con questo numero'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  duration: Duration(seconds: 1),
                                  backgroundColor: kFalcoColor,
                                  content: Text('Stanza aggiornata'),
                                ));
                              }
                            }else{
                              Response response = await databundlenotifier.getSwaggerClient().apiV1RoomUpdatePut(
                                  roomId: room.roomId?.toInt(),
                                  roomNumber: 0
                              );
                            }

                            Response<List<RoomModel>> response = await databundlenotifier.getSwaggerClient().apiV1RoomFindallGet();
                            databundlenotifier.setCurrentRoomList(response.body!);

                          }catch(e){
                            print('Error: ' + e.toString());
                            const snackBar = SnackBar(
                              duration: Duration(seconds: 2),
                              backgroundColor: kFalcoRed,
                              content: Text('Errore. Esiste già una stanza con questo numero'),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          }
                        },
                        elevation: 1.0,
                        fillColor: Colors.white,
                        padding: EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                        child: Icon(Icons.save, color: kFalcoColor, size: getProportionateScreenHeight(40),),
                      ),
                      room.roomNumber == 0 ? RawMaterialButton(
                        onPressed: () async {
                          Widget okButton = TextButton(
                            child: Text("Ho Capito"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          );

                          // set up the AlertDialog
                          AlertDialog alert = AlertDialog(
                            title: Text("Awwand Giovane"),
                            content: Text("Devi configurare il numero della stanza per poterla visualizzare nel calendario"),
                            actions: [
                              okButton,
                            ],
                          );

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return alert;
                            },
                          );
                        },
                        elevation: 1.0,
                        fillColor: Colors.white,
                        padding: const EdgeInsets.all(5.0),
                        shape: const CircleBorder(),
                        child: Icon(Icons.warning_rounded, color: kSettingsColor, size: getProportionateScreenHeight(30),),
                      ) : const SizedBox(height: 0),
                    ],
                  ),
                  RawMaterialButton(
                    onPressed: () async {
                      try{

                        List retrieveBookingByNumberRoom = databundlenotifier.retrieveBookingByNumberRoom(room.roomId);
                        if(retrieveBookingByNumberRoom.isEmpty){
                          await databundlenotifier.getSwaggerClient().apiV1RoomDeletebyidIdGet(
                              id: room.roomId!.toInt()
                          );
                          Response<List<RoomModel>> response = await databundlenotifier.getSwaggerClient().apiV1RoomFindallGet();
                          databundlenotifier.setCurrentRoomList(response.body!);
                        }else{
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Elimina stanza'),
                                  content: Text('Sei sicuro di voler eliminare la stanza? Risultano ancora esserci ${retrieveBookingByNumberRoom.length.toString()} (giorni totali) di prenotazioni in corso.',style: GoogleFonts.openSans(
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
                                        await databundlenotifier.getSwaggerClient().apiV1RoomDeletebyidIdGet(
                                            id: room.roomId!.toInt()
                                        );
                                        Response<List<RoomModel>> response = await databundlenotifier.getSwaggerClient().apiV1RoomFindallGet();
                                        databundlenotifier.setCurrentRoomList(response.body!);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Elimina Stanza', style: GoogleFonts.openSans(
                                          color: kFalcoRed,
                                          fontSize: getProportionateScreenHeight(18),
                                          fontWeight: FontWeight.w500
                                      ),),
                                    )
                                  ],
                                );
                              });

                        }

                      }catch(e){
                        print('Error: ' + e.toString());
                      }
                    },
                    elevation: 1.0,
                    fillColor: Colors.white,
                    padding: EdgeInsets.all(9.0),
                    shape: CircleBorder(),
                    child: Icon(Icons.delete_forever, color: kFalcoRed, size: getProportionateScreenHeight(40),),
                  ),
                ],
              ),
            ),
          ));
        }
      });
    });



    item.add(SizedBox(height: 100,));
    return Column(
      children: item,
    );
  }
}
