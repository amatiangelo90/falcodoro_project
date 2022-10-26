import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final Color kFalcoColor = Color(0xFF295f48);
const Color kRoomColor = Color(0xFF6b3200);
const Color kRoomTypeColor = Color(0xFF41006c);
const Color kSettingsColor = Color(0xFFd1a219);
const Color kFalcoRed = Color(0xFFb62020);
const Color kFalcoBlack = Color(0xFF232b2b);


DateFormat dateFormat = DateFormat("dd-MM-yyyy");

//remote service
const String kUrl = 'http://212.227.203.79:8080/falcoservice';
//const String kUrl = 'http://localhost:8090/falcoservice';

Color getColorByIndex(int index){
  switch(index){
    case 0:
      return kFalcoColor;
    case 1:
      return kRoomColor;
    case 2:
      return kRoomTypeColor;
    default:
      return Colors.transparent;
  }
}

String getWeekDayNameByNumber(int weekday) {
  switch(weekday){
    case 1:
      return 'Lunedi';
    case 2:
      return 'Martedi';
    case 3:
      return 'Mercoledi';
    case 4:
      return 'Giovedi';
    case 5:
      return 'Venerdi';
    case 6:
      return 'Sabato';
    case 7:
      return 'Domenica';
    default:
      return '';
  }
}

String getMonthByMonthNumber(int month) {
  switch(month){
    case 1:
      return 'Gennaio';
    case 2:
      return 'Febbraio';
    case 3:
      return 'Marzo';
    case 4:
      return 'Aprile';
    case 5:
      return 'Maggio';
    case 6:
      return 'Giugno';
    case 7:
      return 'Luglio';
    case 8:
      return 'Agosto';
    case 9:
      return 'Settembre';
    case 10:
      return 'Ottobre';
    case 11:
      return 'Novembre';
    case 12:
      return 'Dicembre';
    default:
      return '';
  }
}


