import 'package:flutter/material.dart';
import 'package:bluez/bluez.dart';
import 'dart:developer';
import 'package:nkl_rp_app/main.dart';
import 'package:process_run/shell.dart';

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
                    : altGrBeingPressed &&
                            (shiftBeingPressedL || shiftBeingPressedR)
                        ? Colors.blueAccent
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
                              style: TextStyle(
                                  fontSize: widget.textSize! + 3,
                                  fontWeight: FontWeight.bold))
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: widget.textSize))))),
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
                    : altGrBeingPressed &&
                            (shiftBeingPressedL || shiftBeingPressedR)
                        ? Colors.blueAccent
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
                    : altGrBeingPressed &&
                            (shiftBeingPressedL || shiftBeingPressedR)
                        ? Colors.blueAccent
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
                    : altGrBeingPressed &&
                            (shiftBeingPressedL || shiftBeingPressedR)
                        ? Colors.blueAccent
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

      //Affected by shift or Capslock (on the first two)
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
              colorShouldChange.value++;
            }
            if (widget.keyboardKey[0] == "ALT GR") {
              altGrBeingPressed = true;
              colorShouldChange.value++;
            }
            if (widget.keyboardKey[0] == "CAPS LOCK") {
              if (capsLockBeingPressed == true) {
                colorShouldChange.value--;
                capsLockBeingPressed = false;
              } else {
                colorShouldChange.value++;
                capsLockBeingPressed = true;
              }
            }
            if (widget.keyboardKey[0] == "NUM LOCK") {
              numLockBeingPressed = !numLockBeingPressed;
              colorShouldChange.value++;
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
              colorShouldChange.value--;
            }
            if (widget.keyboardKey[0] == "ALT GR") {
              altGrBeingPressed = false;
              colorShouldChange.value--;
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
        color: discoverable ? Colors.blue : Colors.grey,
        onPressed: () async {
          if (discoverable) {
          } else {
            BlueZClient client = BlueZClient();
            await client.connect();

            BlueZAdapter adapter = client.adapters[0];
            adapter.setAlias("NKL Keyboard");

            //Automatically accepts any requests. vv
            //
            //bt-agent --capability=NoInputNoOutput &

            var shell = Shell();
            shell.run('''
                ./autoAcceptPair.sh
            ''');
            log(shell.path);

            //for (var device in client.devices) {
            //  var services = device.gattServices;
            //  if (services.isEmpty) {
            //    continue;
            //  }
            //  log('Device ${device.alias}');

            //  for (var service in services) {
            //    log('Service ${service.uuid}');
            //    var characteristics = service.characteristics;
            //    if (characteristics.isEmpty) {
            //      continue;
            //    }

            //    for (var characteristic in characteristics) {
            //      try {
            //        String characteristicValue =
            //            String.fromCharCodes(await characteristic.readValue());
            //        log("Data: $characteristicValue");
            //      } catch (e) {
            //        log(e.toString());
            //      }
            //    }
            //  }
            //}

            log("im discoverable for 30sec");
            await adapter.setDiscoverable(true);
            discoverable = true;
            setState(() {});

            await Future.delayed(const Duration(seconds: 30));

            await adapter.setDiscoverable(false);
            log("im no longer discoverable");
            discoverable = false;
            shell.kill();

            setState(() {});

            //await client.close();
          }
        },
        icon: Icon(discoverable
            ? Icons.bluetooth_searching
            : Icons.bluetooth_disabled));
  }
}

class ComputerConnected extends StatelessWidget {
  final double iconSize;
  const ComputerConnected({Key? key, required this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: computerIsConnected,
        builder: (context, _, __) {
          return Icon(Icons.computer,
              color: computerConnected ? Colors.blueAccent : Colors.grey,
              size: iconSize);
        });
  }
}

class PhoneConnected extends StatelessWidget {
  final double iconSize;
  const PhoneConnected({Key? key, required this.iconSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: phoneIsConnected,
        builder: (context, _, __) {
          return Icon(
              phoneConnected ? Icons.phonelink_lock : Icons.phonelink_erase,
              color: phoneConnected ? Colors.blueAccent : Colors.grey,
              size: iconSize);
        });
  }
}
