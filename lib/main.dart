//TODO: Make at least 2 versions of the Keyboard
//TODO: Make keys update upon shift, alt etc
//TODO: Make bluetooth connection and transmission of HID keyboard commands
//TODO: Retrieve password information  and etc.

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'components/keyboard_layouts/be_fr.dart';
import 'components/keyboard_layouts/de.dart';
import 'components/keyboard_layouts/en_gb.dart';
import 'components/keyboard_layouts/en_us.dart';
import 'components/keyboard_layouts/pt_pt.dart';

bool shiftBeingPressedL = false;
bool shiftBeingPressedR = false;
bool altGrBeingPressed = false;
bool capsLockBeingPressed = false;
bool numLockBeingPressed = false;

ValueNotifier<int> test = ValueNotifier(0);

bool discoverable = false;
int language = 4;

void main() {
  GoogleFonts.config.allowRuntimeFetching = false;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.firaCodeTextTheme(
            Theme.of(context).textTheme.apply(bodyColor: Colors.white),
          ),
          scaffoldBackgroundColor: Colors.black),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    double defaultH = height / 13.26;
    double defaultSpace = defaultH * 0.03;

    switch (language) {

      //English - Uk - 809
      case 1:
        return EnGbLayout(
            width: width,
            height: height,
            defaultH: defaultH,
            defaultSpace: defaultSpace);

      //English - US - 409
      case 2:
        return EnUsLayout(
            width: width,
            height: height,
            defaultH: defaultH,
            defaultSpace: defaultSpace);

      //German - 407
      case 3:
        return DeLayout(
            width: width,
            height: height,
            defaultH: defaultH,
            defaultSpace: defaultSpace);

      //Belgian French - 80c
      case 4:
        return BeFrLayout(
            width: width,
            height: height,
            defaultH: defaultH,
            defaultSpace: defaultSpace);

      default:
        return PtPtLayout(
            width: width,
            height: height,
            defaultH: defaultH,
            defaultSpace: defaultSpace);
    }
  }
}
