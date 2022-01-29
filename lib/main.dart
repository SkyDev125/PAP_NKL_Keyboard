//TODO: Make at least 2 versions of the Keyboard
//TODO: Make keys update upon shift, alt etc
//TODO: Make bluetooth connection and transmission of HID keyboard commands
//TODO: Retrieve password information  and etc.

import 'package:flutter/material.dart';
import 'package:bluez/bluez.dart';
import 'dart:developer';

import 'package:google_fonts/google_fonts.dart';

bool shiftBeingPressedL = false;
bool shiftBeingPressedR = false;
bool altGrBeingPressed = false;
bool capsLockBeingPressed = false;
bool numLockBeingPressed = false;

ValueNotifier<int> test = ValueNotifier(0);

bool discoverable = false;

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

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ValueListenableBuilder(
              valueListenable: test,
              builder: (context, _, __) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [TurnDiscoverable(size: defaultH)]),

                    Padding(padding: EdgeInsets.only(bottom: defaultH * 1)),

                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: defaultH * 0.9,
                          ),
                          child: SizedBox(
                            height: defaultH * 2,
                            width: width - defaultH * 2.7,
                            child: const Center(
                              child: Text("PT-PT LAYOUT ACTIVE",
                                  style: TextStyle(
                                      fontSize: 50,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        )
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(bottom: defaultH * 1.5)),

                    //Sixth Row
                    Row(children: [
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["ESC"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultH * 0.65)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["F1"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["F2"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["F3"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["F4"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultH * 0.65)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["F5"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["F6"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["F7"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["F8"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultH * 0.65)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["F9"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["F10"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["F11"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["F12"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultH * 0.23)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["PRINT SCR"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["SCRL LOCK"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["PAUSE BREAK"],
                        affectedBy: 0,
                      ),
                    ]),

                    Padding(padding: EdgeInsets.only(bottom: defaultH * 0.5)),

                    //Fifth Row
                    Row(children: [
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const [r'\', "|"],
                        affectedBy: 5,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["1", "!"],
                        affectedBy: 5,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["2", '"', "@"],
                        affectedBy: 7,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["3", '#', "£"],
                        affectedBy: 7,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["4", r'$', "§"],
                        affectedBy: 7,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["5", '%', "€"],
                        affectedBy: 7,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["6", '&'],
                        affectedBy: 5,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["7", "/", "{"],
                        affectedBy: 7,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["8", "(", "["],
                        affectedBy: 7,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["9", ")", "]"],
                        affectedBy: 7,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["0", "=", "}"],
                        affectedBy: 7,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["'", "?"],
                        affectedBy: 5,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["«", "»"],
                        affectedBy: 5,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1.95,
                        keyboardKey: const ["BACKSPACE"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultH * 0.23)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["INSERT"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["HOME"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["PAGE UP"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultH * 0.23)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["NUM LOCK"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["/"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["*"],
                        affectedBy: 0,
                        textSize: 17,
                      ),
                    ]),

                    Padding(padding: EdgeInsets.only(bottom: defaultSpace)),

                    //Fourth Row
                    Row(children: [
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1.5,
                        keyboardKey: const ["TAB"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["q", "Q"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["w", "W"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["e", "E", "€"],
                        affectedBy: 6,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["r", "R"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["t", "T"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["y", "Y"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["u", "U"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["i", "I"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["o", "O"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["p", "P"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["+", "*", "¨"],
                        affectedBy: 7,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["´", "`", "]"],
                        affectedBy: 7,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1.45,
                        keyboardKey: const ["ENTER"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultH * 0.23)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["DELETE"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["END"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["PAGE DOWN"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultH * 0.23)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["HOME", "7"],
                        affectedBy: 3,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["↑", "8"],
                        affectedBy: 3,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["PG UP", "9"],
                        affectedBy: 3,
                      ),
                    ]),

                    Padding(padding: EdgeInsets.only(bottom: defaultSpace)),

                    //Third Row
                    Row(children: [
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1.75,
                        keyboardKey: const ["CAPS LOCK"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["a", "A"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["s", "S"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["d", "D"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["f", "F"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["g", "G"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["h", "H"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["j", "J"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["k", "K"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["l", "L"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["ç", "Ç"],
                        affectedBy: 1,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["º", "ª"],
                        affectedBy: 5,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 0.99,
                        keyboardKey: const ["~", "^"],
                        affectedBy: 5,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1.19,
                        keyboardKey: const ["ENTER"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultH * 3.53)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["←", "4"],
                        affectedBy: 3,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["", "5"],
                        affectedBy: 3,
                        textSize: 17,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["→", "6"],
                        affectedBy: 3,
                        textSize: 17,
                      ),
                    ]),

                    Padding(padding: EdgeInsets.only(bottom: defaultSpace)),

                    //Second Row
                    Row(
                      children: [
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 1.25,
                          keyboardKey: const ["SHIFT"],
                          affectedBy: 0,
                          side: 0,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 0.99,
                          keyboardKey: const ["<", ">"],
                          affectedBy: 5,
                          textSize: 17,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 0.99,
                          keyboardKey: const ["z", "Z"],
                          affectedBy: 1,
                          textSize: 17,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 0.99,
                          keyboardKey: const ["x", "X"],
                          affectedBy: 1,
                          textSize: 17,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 0.99,
                          keyboardKey: const ["c", "C"],
                          affectedBy: 1,
                          textSize: 17,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 0.99,
                          keyboardKey: const ["v", "V"],
                          affectedBy: 1,
                          textSize: 17,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 0.99,
                          keyboardKey: const ["b", "B"],
                          affectedBy: 1,
                          textSize: 17,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 0.99,
                          keyboardKey: const ["n", "N"],
                          affectedBy: 1,
                          textSize: 17,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 0.99,
                          keyboardKey: const ["m", "M"],
                          affectedBy: 1,
                          textSize: 17,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 0.99,
                          keyboardKey: const [",", ";"],
                          affectedBy: 5,
                          textSize: 17,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 0.99,
                          keyboardKey: const [".", ":"],
                          affectedBy: 5,
                          textSize: 17,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 0.99,
                          keyboardKey: const ["-", "_"],
                          affectedBy: 5,
                          textSize: 17,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 2.71,
                          keyboardKey: const ["SHIFT"],
                          affectedBy: 0,
                          side: 1,
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: defaultH * 1.26)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 1,
                          keyboardKey: const ["↑"],
                          affectedBy: 0,
                          textSize: 17,
                        ),
                        Padding(
                            padding: EdgeInsets.only(right: defaultH * 1.27)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 1,
                          keyboardKey: const ["END", "1"],
                          affectedBy: 3,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 1,
                          keyboardKey: const ["↓", "2"],
                          affectedBy: 3,
                          textSize: 17,
                        ),
                        Padding(padding: EdgeInsets.only(right: defaultSpace)),
                        KeyboardKey(
                          defaultH: defaultH,
                          multiplier: 1,
                          keyboardKey: const ["PG DW", "2"],
                          affectedBy: 3,
                        ),
                      ],
                    ),

                    Padding(padding: EdgeInsets.only(bottom: defaultSpace)),

                    //First Row (bottom)
                    Row(children: [
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1.5,
                        keyboardKey: const ["CTRL"],
                        affectedBy: 0,
                        side: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1.15,
                        keyboardKey: const ["WIN"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1.15,
                        keyboardKey: const ["ALT"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 6.25,
                        keyboardKey: const ["___________"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1.15,
                        keyboardKey: const ["ALT GR"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1.15,
                        keyboardKey: const ["WIN"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1.15,
                        keyboardKey: const ["MENU"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1.5,
                        keyboardKey: const ["CTRL"],
                        affectedBy: 0,
                        side: 1,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultH * 0.24)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["←"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["↓"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["→"],
                        affectedBy: 0,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultH * 0.24)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 2.02,
                        keyboardKey: const ["INSERT", "0"],
                        affectedBy: 3,
                      ),
                      Padding(padding: EdgeInsets.only(right: defaultSpace)),
                      KeyboardKey(
                        defaultH: defaultH,
                        multiplier: 1,
                        keyboardKey: const ["DEL", "."],
                        affectedBy: 3,
                      ),
                    ]),
                  ],
                );
              }),
          Padding(padding: EdgeInsets.only(right: defaultSpace)),
          Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KeyboardKey(
                  defaultH: defaultH,
                  multiplier: 1,
                  keyboardKey: const ["-"],
                  affectedBy: 0,
                  textSize: 17,
                ),
                Padding(padding: EdgeInsets.only(bottom: defaultSpace)),
                KeyboardKey(
                  defaultH: defaultH,
                  multiplier: 1,
                  keyboardKey: const ["+"],
                  affectedBy: 4,
                  textSize: 17,
                ),
                Padding(padding: EdgeInsets.only(bottom: defaultSpace)),
                KeyboardKey(
                  defaultH: defaultH,
                  multiplier: 1,
                  keyboardKey: const ["ENTER"],
                  affectedBy: 4,
                ),
              ])
        ],
      ),
    ));
  }
}

class KeyboardKey extends StatefulWidget {
  final List<String> keyboardKey;
  final double multiplier;
  final double defaultH;
  final int affectedBy;
  final int? side;
  final double? textSize;

  const KeyboardKey(
      {Key? key,
      required this.defaultH,
      required this.multiplier,
      required this.keyboardKey,
      required this.affectedBy,
      this.side,
      this.textSize})
      : super(key: key);

  @override
  State<KeyboardKey> createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
  bool beingPressed = false;

  @override
  Widget build(BuildContext context) {
    switch (widget.affectedBy) {

      //Affected by Shift or CapsLock key
      case 1:
        return Listener(
          onPointerDown: (down) => setState(() {
            beingPressed = true;
          }),
          onPointerUp: (up) => setState(() {
            beingPressed = false;
          }),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: beingPressed
                    ? Colors.grey
                    : shiftBeingPressedL | shiftBeingPressedR
                        ? Colors.purple
                        : Colors.blueAccent,
              ),
              child: SizedBox(
                  height: widget.defaultH,
                  width: widget.defaultH * widget.multiplier,
                  child: Center(
                      child: capsLockBeingPressed
                          //Capslock active
                          ? shiftBeingPressedL | shiftBeingPressedR
                              ? Text(widget.keyboardKey[0],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: widget.textSize,
                                      fontWeight: FontWeight.bold))
                              : Text(widget.keyboardKey[1],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: widget.textSize,
                                      fontWeight: FontWeight.bold))
                          //Capslock innactive
                          : shiftBeingPressedL | shiftBeingPressedR
                              ? Text(widget.keyboardKey[1],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: widget.textSize,
                                      fontWeight: FontWeight.bold))
                              : Text(widget.keyboardKey[0],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: widget.textSize,
                                      fontWeight: FontWeight.bold))))),
        );

      // Affected by NumLock key
      case 3:
        return Listener(
          onPointerDown: (down) => setState(() {
            beingPressed = true;
          }),
          onPointerUp: (up) => setState(() {
            beingPressed = false;
          }),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: beingPressed
                    ? Colors.grey
                    : numLockBeingPressed
                        ? Colors.purple
                        : Colors.blueAccent,
              ),
              child: SizedBox(
                  height: widget.defaultH,
                  width: widget.defaultH * widget.multiplier,
                  child: Center(
                      child: numLockBeingPressed
                          ? Text(widget.keyboardKey[1],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold))
                          : Text(widget.keyboardKey[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: widget.textSize,
                                  fontWeight: FontWeight.bold))))),
        );

      //Tall Keys
      case 4:
        return Listener(
          onPointerDown: (down) => setState(() {
            beingPressed = true;
          }),
          onPointerUp: (up) => setState(() {
            beingPressed = false;
          }),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: beingPressed ? Colors.grey : Colors.blueAccent,
              ),
              child: SizedBox(
                  height: widget.defaultH * 2.03,
                  width: widget.defaultH * widget.multiplier,
                  child: Center(
                      child: Text(widget.keyboardKey[0],
                          textAlign: TextAlign.center,
                          style:
                              const TextStyle(fontWeight: FontWeight.bold))))),
        );

      //Affected by Shift key
      case 5:
        return Listener(
          onPointerDown: (down) => setState(() {
            beingPressed = true;
          }),
          onPointerUp: (up) => setState(() {
            beingPressed = false;
          }),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: beingPressed
                    ? Colors.grey
                    : shiftBeingPressedL | shiftBeingPressedR
                        ? Colors.purple
                        : Colors.blueAccent,
              ),
              child: SizedBox(
                  height: widget.defaultH,
                  width: widget.defaultH * widget.multiplier,
                  child: Center(
                      child: shiftBeingPressedL | shiftBeingPressedR
                          ? Text(widget.keyboardKey[1],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: widget.textSize,
                                  fontWeight: FontWeight.bold))
                          : Text(widget.keyboardKey[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: widget.textSize,
                                  fontWeight: FontWeight.bold))))),
        );

      //Affected by Shift or CapsLock or AltGr key
      case 6:
        return Listener(
          onPointerDown: (down) => setState(() {
            beingPressed = true;
          }),
          onPointerUp: (up) => setState(() {
            beingPressed = false;
          }),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: beingPressed
                    ? Colors.grey
                    : altGrBeingPressed
                        ? Colors.purple
                        : shiftBeingPressedL | shiftBeingPressedR
                            ? Colors.purple
                            : Colors.blueAccent,
              ),
              child: SizedBox(
                  height: widget.defaultH,
                  width: widget.defaultH * widget.multiplier,
                  child: Center(
                      child: altGrBeingPressed
                          ? Text(widget.keyboardKey[2],
                              style: TextStyle(
                                  fontSize: widget.textSize,
                                  fontWeight: FontWeight.bold))
                          : capsLockBeingPressed
                              //Capslock active
                              ? shiftBeingPressedL | shiftBeingPressedR
                                  ? Text(widget.keyboardKey[0],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: widget.textSize,
                                          fontWeight: FontWeight.bold))
                                  : Text(widget.keyboardKey[1],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: widget.textSize,
                                          fontWeight: FontWeight.bold))
                              //Capslock innactive
                              : shiftBeingPressedL | shiftBeingPressedR
                                  ? Text(widget.keyboardKey[1],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: widget.textSize,
                                          fontWeight: FontWeight.bold))
                                  : Text(widget.keyboardKey[0],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: widget.textSize,
                                          fontWeight: FontWeight.bold))))),
        );

      //Affected by Shift or AltGr key
      case 7:
        return Listener(
          onPointerDown: (down) => setState(() {
            beingPressed = true;
          }),
          onPointerUp: (up) => setState(() {
            beingPressed = false;
          }),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: beingPressed
                    ? Colors.grey
                    : altGrBeingPressed
                        ? Colors.purple
                        : shiftBeingPressedL | shiftBeingPressedR
                            ? Colors.purple
                            : Colors.blueAccent,
              ),
              child: SizedBox(
                  height: widget.defaultH,
                  width: widget.defaultH * widget.multiplier,
                  child: Center(
                      child: altGrBeingPressed
                          ? Text(widget.keyboardKey[2],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: widget.textSize))
                          : shiftBeingPressedL | shiftBeingPressedR
                              ? Text(widget.keyboardKey[1],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: widget.textSize,
                                      fontWeight: FontWeight.bold))
                              : Text(widget.keyboardKey[0],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: widget.textSize,
                                      fontWeight: FontWeight.bold))))),
        );

      // Affected by Nothing
      default:
        return Listener(
          onPointerDown: (down) => setState(() {
            if (widget.keyboardKey[0] == "SHIFT") {
              if (widget.side == 0) {
                shiftBeingPressedL = true;
              } else {
                shiftBeingPressedR = true;
              }
              test.value++;
            }
            if (widget.keyboardKey[0] == "ALT GR") {
              altGrBeingPressed = true;
              test.value++;
            }
            if (widget.keyboardKey[0] == "CAPS LOCK") {
              if (capsLockBeingPressed == true) {
                test.value--;
                capsLockBeingPressed = false;
              } else {
                test.value++;
                capsLockBeingPressed = true;
              }
            }
            if (widget.keyboardKey[0] == "NUM LOCK") {
              numLockBeingPressed = !numLockBeingPressed;
              test.value++;
            }
            beingPressed = true;
          }),
          onPointerUp: (up) => setState(() {
            if (widget.keyboardKey[0] == "SHIFT") {
              if (widget.side == 0) {
                shiftBeingPressedL = false;
              } else {
                shiftBeingPressedR = false;
              }
              test.value--;
            }
            if (widget.keyboardKey[0] == "ALT GR") {
              altGrBeingPressed = false;
              test.value--;
            }
            beingPressed = false;
          }),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: beingPressed ? Colors.grey : Colors.blueAccent,
              ),
              child: SizedBox(
                  height: widget.defaultH,
                  width: widget.defaultH * widget.multiplier,
                  child: Center(
                      child: Text(widget.keyboardKey[0],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: widget.textSize,
                              fontWeight: FontWeight.bold))))),
        );
    }
  }
}

class TurnDiscoverable extends StatefulWidget {
  final double size;
  const TurnDiscoverable({Key? key, required this.size}) : super(key: key);

  @override
  State<TurnDiscoverable> createState() => _TurnDiscoverableState();
}

class _TurnDiscoverableState extends State<TurnDiscoverable> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
        iconSize: widget.size,
        color: discoverable ? Colors.blue : Colors.white,
        onPressed: () async {
          if (discoverable) {
          } else {
            BlueZClient client = BlueZClient();
            await client.connect();
            BlueZAdapter adapter = client.adapters[0];

            log("im discoverable for 30sec");
            await adapter.setDiscoverable(true);
            discoverable = true;
            setState(() {});

            await Future.delayed(const Duration(seconds: 60));

            await adapter.setDiscoverable(false);
            log("im no longer discoverable");
            discoverable = false;
            setState(() {});

            await client.close();
          }
        },
        icon: const Icon(Icons.bluetooth_searching));
  }
}
