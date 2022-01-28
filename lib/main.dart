//TODO: Make at least 2 versions of the Keyboard
//TODO: Make keys update upon shift, alt etc
//TODO: Make bluetooth connection and transmission of HID keyboard commands
//TODO: Retrieve password information  and etc.

import 'package:flutter/material.dart';
import 'package:bluez/bluez.dart';
import 'dart:developer';

bool shiftBeingPressed = false;
bool altGrBeingPressed = false;
bool capsLockBeingPressed = false;
bool numLockBeingPressed = false;

void main() {
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
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
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

    log(width.toString());
    log(height.toString());

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              KeyboardKey(
                defaultH: defaultH,
                multiplier: 1.25,
                keyboardKey: "SHIFT",
                affectedBy: 1,
              ),
              Padding(padding: EdgeInsets.only(right: defaultSpace)),
            ],
          ),
          Padding(padding: EdgeInsets.only(bottom: defaultSpace)),
          Row(children: [
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 1.5,
              keyboardKey: "CTRL",
              affectedBy: 0,
            ),
            Padding(padding: EdgeInsets.only(right: defaultSpace)),
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 1.15,
              keyboardKey: "WIN",
              affectedBy: 0,
            ),
            Padding(padding: EdgeInsets.only(right: defaultSpace)),
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 1.15,
              keyboardKey: "ALT",
              affectedBy: 0,
            ),
            Padding(padding: EdgeInsets.only(right: defaultSpace)),
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 6.25,
              keyboardKey: "___________",
              affectedBy: 0,
            ),
            Padding(padding: EdgeInsets.only(right: defaultSpace)),
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 1.15,
              keyboardKey: "ALT GR",
              affectedBy: 2,
            ),
            Padding(padding: EdgeInsets.only(right: defaultSpace)),
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 1.15,
              keyboardKey: "WIN",
              affectedBy: 0,
            ),
            Padding(padding: EdgeInsets.only(right: defaultSpace)),
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 1.15,
              keyboardKey: "MENU",
              affectedBy: 0,
            ),
            Padding(padding: EdgeInsets.only(right: defaultSpace)),
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 1.5,
              keyboardKey: "CTRL",
              affectedBy: 0,
            ),
            Padding(padding: EdgeInsets.only(right: defaultH * 0.25)),
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 1,
              keyboardKey: "←",
              affectedBy: 0,
            ),
            Padding(padding: EdgeInsets.only(right: defaultSpace)),
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 1,
              keyboardKey: "↓",
              affectedBy: 0,
            ),
            Padding(padding: EdgeInsets.only(right: defaultSpace)),
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 1,
              keyboardKey: "→",
              affectedBy: 3,
            ),
            Padding(padding: EdgeInsets.only(right: defaultH * 0.25)),
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 2,
              keyboardKey: "0 INS",
              affectedBy: 3,
            ),
            Padding(padding: EdgeInsets.only(right: defaultSpace)),
            KeyboardKey(
              defaultH: defaultH,
              multiplier: 1,
              keyboardKey: "DEL",
              affectedBy: 0,
            ),
          ]),
        ],
      ),
    ));
  }
}

class KeyboardKey extends StatefulWidget {
  final String keyboardKey;
  final double multiplier;
  final double defaultH;
  final int affectedBy;

  const KeyboardKey({
    Key? key,
    required this.defaultH,
    required this.multiplier,
    required this.keyboardKey,
    required this.affectedBy,
  }) : super(key: key);

  @override
  State<KeyboardKey> createState() => _KeyboardKeyState();
}

class _KeyboardKeyState extends State<KeyboardKey> {
  bool beingPressed = false;

  @override
  Widget build(BuildContext context) {
    switch (widget.affectedBy) {

      //Affected by Shift key
      case 1:
        return Listener(
          onPointerDown: (down) => setState(() {
            if (widget.keyboardKey == "SHIFT") {
              shiftBeingPressed = true;
            }
            log("down");
            beingPressed = true;
          }),
          onPointerUp: (up) => setState(() {
            log("up");
            if (widget.keyboardKey == "SHIFT") {
              shiftBeingPressed = false;
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
                  child: Center(child: Text(widget.keyboardKey)))),
        );

      //Affected by Alt Gr Key
      case 2:
        return Listener(
          onPointerDown: (down) => setState(() {
            log("down");
            if (widget.keyboardKey == "ALT GR") {
              shiftBeingPressed = true;
            }
            beingPressed = true;
          }),
          onPointerUp: (up) => setState(() {
            log("up");
            if (widget.keyboardKey == "ALT GR") {
              shiftBeingPressed = false;
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
                  child: Center(child: Text(widget.keyboardKey)))),
        );

      //Affected by CapsLock key
      case 3:
        return Listener(
          onPointerDown: (down) => setState(() {
            log("down");
            if (widget.keyboardKey == "SHIFT") {
              shiftBeingPressed = true;
            }
            beingPressed = true;
          }),
          onPointerUp: (up) => setState(() {
            log("up");
            if (widget.keyboardKey == "SHIFT") {
              shiftBeingPressed = false;
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
                  child: Center(child: Text(widget.keyboardKey)))),
        );

      // Affected by NumLock key
      case 4:
        return Listener(
          onPointerDown: (down) => setState(() {
            log("down");
            if (widget.keyboardKey == "SHIFT") {
              shiftBeingPressed = true;
            }
            beingPressed = true;
          }),
          onPointerUp: (up) => setState(() {
            log("up");
            if (widget.keyboardKey == "SHIFT") {
              shiftBeingPressed = false;
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
                  child: Center(child: Text(widget.keyboardKey)))),
        );

      // Affected by Nothing
      default:
        return Listener(
          onPointerDown: (down) => setState(() {
            log("down");
            beingPressed = true;
          }),
          onPointerUp: (up) => setState(() {
            log("up");
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
                  child: Center(child: Text(widget.keyboardKey)))),
        );
    }
  }
}

class TurnDiscoverable extends StatelessWidget {
  const TurnDiscoverable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () async {
          BlueZClient client = BlueZClient();
          await client.connect();
          BlueZAdapter adapter = client.adapters[0];

          log("im discoverable for 30sec");
          await adapter.setDiscoverable(true);

          await Future.delayed(const Duration(seconds: 60));

          await adapter.setDiscoverable(false);
          log("im no longer discoverable");

          await client.close();
        },
        icon: const Icon(Icons.bluetooth_searching));
  }
}
