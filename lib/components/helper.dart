import 'package:flutter/material.dart';
import 'package:bluez/bluez.dart';
import 'dart:developer';
import 'package:nkl_rp_app/main.dart';

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

      //Affected by Shift or CapsLock key or AltGr or AltGr and Shift key
      case 2:
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
                      : altGrBeingPressed &&
                              (shiftBeingPressedL | shiftBeingPressedR)
                          ? Colors.purple
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
                        child: capsLockBeingPressed
                            //CapsLock being pressed
                            ? altGrBeingPressed &&
                                    (shiftBeingPressedL | shiftBeingPressedR)
                                //altGr and shift being pressed
                                ? Text(widget.keyboardKey[2],
                                    style: TextStyle(
                                        fontSize: widget.textSize,
                                        fontWeight: FontWeight.bold))
                                //altGr and shift not being pressed
                                : altGrBeingPressed
                                    //altGr being pressed
                                    ? Text(widget.keyboardKey[3],
                                        style: TextStyle(
                                            fontSize: widget.textSize,
                                            fontWeight: FontWeight.bold))
                                    //altGr not being pressed
                                    : shiftBeingPressedL | shiftBeingPressedR
                                        //Shift being pressed
                                        ? Text(widget.keyboardKey[0],
                                            style: TextStyle(
                                                fontSize: widget.textSize,
                                                fontWeight: FontWeight.bold))
                                        //Shift not being pressed
                                        : Text(widget.keyboardKey[1],
                                            style: TextStyle(
                                                fontSize: widget.textSize,
                                                fontWeight: FontWeight.bold))

                            //CapsLock not being pressed
                            : altGrBeingPressed &&
                                    (shiftBeingPressedL | shiftBeingPressedR)
                                //altGr and shift being pressed
                                ? Text(widget.keyboardKey[3],
                                    style: TextStyle(
                                        fontSize: widget.textSize,
                                        fontWeight: FontWeight.bold))
                                //altGr and shift not being pressed
                                : altGrBeingPressed
                                    //altGr being pressed
                                    ? Text(widget.keyboardKey[2],
                                        style: TextStyle(
                                            fontSize: widget.textSize,
                                            fontWeight: FontWeight.bold))
                                    //altGr not being pressed
                                    : shiftBeingPressedL | shiftBeingPressedR
                                        //Shift being pressed
                                        ? Text(widget.keyboardKey[1],
                                            style: TextStyle(
                                                fontSize: widget.textSize,
                                                fontWeight: FontWeight.bold))
                                        //Shift not being pressed
                                        : Text(widget.keyboardKey[0],
                                            style: TextStyle(
                                                fontSize: widget.textSize,
                                                fontWeight:
                                                    FontWeight.bold))))));

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

      //Affected by Shift or AltGr key or Shift and AltGr key
      case 8:
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
                    : altGrBeingPressed &&
                            (shiftBeingPressedL | shiftBeingPressedR)
                        ? Colors.purple
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
                      child: altGrBeingPressed &&
                              (shiftBeingPressedL | shiftBeingPressedR)
                          //altGr and shift being pressed
                          ? Text(widget.keyboardKey[3],
                              style: TextStyle(
                                  fontSize: widget.textSize,
                                  fontWeight: FontWeight.bold))
                          //altGr and shift not being pressed
                          : altGrBeingPressed
                              //altGr being pressed
                              ? Text(widget.keyboardKey[2],
                                  style: TextStyle(
                                      fontSize: widget.textSize,
                                      fontWeight: FontWeight.bold))
                              //altGr not being pressed
                              : shiftBeingPressedL | shiftBeingPressedR
                                  //Shift being pressed
                                  ? Text(widget.keyboardKey[1],
                                      style: TextStyle(
                                          fontSize: widget.textSize,
                                          fontWeight: FontWeight.bold))
                                  //Shift not being pressed
                                  : Text(widget.keyboardKey[0],
                                      style: TextStyle(
                                          fontSize: widget.textSize,
                                          fontWeight: FontWeight.bold))))),
        );

      //Affected bz shift or Capslock (on the first two)
      //and on altGr or AltGr and Shift
      case 9:
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
                      : altGrBeingPressed &&
                              (shiftBeingPressedL | shiftBeingPressedR)
                          ? Colors.purple
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
                        child: altGrBeingPressed &&
                                (shiftBeingPressedL | shiftBeingPressedR)
                            //altGr and shift being pressed
                            ? Text(widget.keyboardKey[3],
                                style: TextStyle(
                                    fontSize: widget.textSize,
                                    fontWeight: FontWeight.bold))
                            //altGr and shift not being pressed
                            : altGrBeingPressed
                                //altGr being pressed
                                ? Text(widget.keyboardKey[2],
                                    style: TextStyle(
                                        fontSize: widget.textSize,
                                        fontWeight: FontWeight.bold))
                                //altGr not being pressed
                                : capsLockBeingPressed
                                    //CapsLock being pressed
                                    ? shiftBeingPressedL | shiftBeingPressedR
                                        //Shift being pressed
                                        ? Text(widget.keyboardKey[0],
                                            style: TextStyle(
                                                fontSize: widget.textSize,
                                                fontWeight: FontWeight.bold))
                                        //Shift not being pressed
                                        : Text(widget.keyboardKey[1],
                                            style: TextStyle(
                                                fontSize: widget.textSize,
                                                fontWeight: FontWeight.bold))
                                    //CapsLock not being pressed
                                    : shiftBeingPressedL | shiftBeingPressedR
                                        //Shift being pressed
                                        ? Text(widget.keyboardKey[1],
                                            style: TextStyle(
                                                fontSize: widget.textSize,
                                                fontWeight: FontWeight.bold))
                                        //Shift not being pressed
                                        : Text(widget.keyboardKey[0],
                                            style: TextStyle(
                                                fontSize: widget.textSize,
                                                fontWeight:
                                                    FontWeight.bold))))));

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
