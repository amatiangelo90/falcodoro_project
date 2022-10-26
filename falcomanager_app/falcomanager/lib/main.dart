import 'package:FalcoManager/screens/booking/add_booking.dart';
import 'package:FalcoManager/screens/falco_home_screen.dart';
import 'package:FalcoManager/screens/room/room_manager.dart';
import 'package:FalcoManager/screens/room_type/add_room_type.dart';
import 'package:FalcoManager/screens/room_type/room_type_manager.dart';
import 'package:FalcoManager/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'databundleprovider.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    tools: const [
      ...DevicePreview.defaultTools,
    ],
    builder: (context) => MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataBundleNotifier(),
      child: MaterialApp(
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        title: 'Falco D\'Oro',
        initialRoute: SplashScreen.route,
        routes: {
          SplashScreen.route: (context) => SplashScreen(),
          FalcoDOroManagerHome.route: (context) => FalcoDOroManagerHome(),
          AddRoomTypeScreen.route: (context) => AddRoomTypeScreen(),
          AddBookingScreen.route: (context) => AddBookingScreen(),
          RoomTypeManagerScreen.route: (context) => RoomTypeManagerScreen(),
          RoomManagerScreen.route: (context) => RoomManagerScreen(),
        },
        //builder: EasyLoading.init(),
      ),
    );
  }
}

