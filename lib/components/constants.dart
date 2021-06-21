import 'package:flutter/material.dart';
import 'package:rane_dms/components/QPCRDataStructure.dart';
import 'package:rane_dms/components/sharedPref.dart';

const kprimaryColor = Color(0xFF0A0E21);
const ktoolbarColor = Color(0xFF0A0E21);
const kinactiveColor = Color(0xFF2E7ABD);
const kactiveColor = Colors.white;
const klabelColor = Color(0x0f000000);
const ktextColor = Colors.black;
const kbuttonColor = Color(0xFF212747);
const ksliderThumbColor = Color(0xFFFE0167);
const kresultTextColor = Color(0xFF55C893);
const kNumberTextStyle = TextStyle(
  fontWeight: FontWeight.w900,
  color: Colors.white,
  fontSize: 50,
);
const kLabelTextStyle = TextStyle(
  color: Colors.white,
);
const String ipAddress = 'http://192.168.0.200:3000/';
const String version = '1.0.1';
const String desktopVersion = '1.0.1';
QPCR globalQpcr;
const departments = [
  'MED',
  'PLE',
  'MFG',
  'Store',
  'Dispatch',
  'HR',
  'Safety',
  'SQA',
  'QAD'
];
