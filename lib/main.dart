import 'package:flutter/material.dart';
import 'package:just_test/src/utils/locator.dart';
import 'package:just_test/src/views/root.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async{
  await dotenv.load(fileName: ".env");
  configure();//get_it
  runApp(MovieApp());
}


