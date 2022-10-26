import 'dart:io';
import 'dart:math';
import 'package:FalcoManager/databundleprovider.dart';
import 'package:FalcoManager/screens/falco_home_screen.dart';
import 'package:FalcoManager/utils/constants.dart';
import 'package:FalcoManager/utils/size_config.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'falcomanager/swaggermodel.swagger.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const String route = 'splash';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _random = Random();
  bool buttonPressed = false;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Consumer<DataBundleNotifier>(
      builder: (child, databundle, _){
        return Scaffold(
          backgroundColor: kFalcoBlack,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(height: 0,),
              buttonPressed ? Center(
                child: Text('Attendi, sto caricando i dati..', style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: getProportionateScreenHeight(22),
                ),),
              ) : Center(
                child: SizedBox(
                  width: getProportionateScreenWidth(250),
                  height: 100,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                        primary: kFalcoBlack,
                    ),
                    onPressed: () async {
                      try{
                        setState((){
                          buttonPressed = true;
                        });
                        Response<List<RoomTypeModel>> roomModelTypeList = await databundle.getSwaggerClient().apiV1RoomtypeFindallGet();
                        if(roomModelTypeList.statusCode == 200){
                          databundle.setCurrentRoomTypesList(roomModelTypeList.body!);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: kFalcoRed,
                            content: Text('Errore. Sembra che il servizio web non sia raggiungibile. Riprova fra 2 minuti oppure contatta l\'amministratore del sistema'),
                          ));
                        }


                        Response<List<RoomModel>> roomModelList = await databundle.getSwaggerClient().apiV1RoomFindallGet();
                        if(roomModelList.statusCode == 200){
                          databundle.setCurrentRoomList(roomModelList.body!);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: kFalcoRed,
                            content: Text('Errore. Sembra che il servizio web non sia raggiungibile. Riprova fra 2 minuti oppure contatta l\'amministratore del sistema'),
                          ));
                        }


                        Response<List<BookingModel>> bookingModelList = await databundle.getSwaggerClient().apiV1BookingFindallGet();

                        if(bookingModelList.statusCode == 200){
                          databundle.setCurrentBookingList(bookingModelList.body!);

                          sleep(Duration(seconds: 1));
                          Navigator.pushNamed(context, FalcoDOroManagerHome.route);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: Duration(seconds: 2),
                            backgroundColor: kFalcoRed,
                            content: Text('Errore. Sembra che il servizio web non sia raggiungibile. Riprova fra 2 minuti oppure contatta l\'amministratore del sistema'),
                          ));
                        }
                        setState((){
                          buttonPressed = false;
                        });
                      }catch(e){
                        setState((){
                          buttonPressed = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 5),
                          backgroundColor: kFalcoRed,
                          content: Text('Errore. Sembra che il servizio web non sia raggiungibile. Riprova fra 2 minuti oppure contatta l\'amministratore del sistema. ' + e.toString()),
                        ));

                      }


                    },
                    child: Text('Accedi a Falco D\'Oro Manager', style: GoogleFonts.openSans(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: getProportionateScreenHeight(27),
                    ),),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Powered by AmatiCorporation', style: GoogleFonts.openSans(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: getProportionateScreenHeight(12),
                ),),
              ),
            ],
          ),
        );
      },
    );
  }
}
