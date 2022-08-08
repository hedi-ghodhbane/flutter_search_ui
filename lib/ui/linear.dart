import 'dart:math';
import 'dart:ui';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LinearSearch extends StatefulWidget {
  const LinearSearch({Key? key}) : super(key: key);

  @override
  State<LinearSearch> createState() => _LinearSearchState();
}

class _LinearSearchState extends State<LinearSearch> {
  int _current = -1;
  bool _found = false;
  bool _notFound = false;
  int _value = -1;
  final list = [1, 3, 5, 12, 2, 156, 23, 45, 22, 56, 33, 21, 99, 122, 134, 4];
  void start() async {
    _controllerCenter.stop();
    setState(() {
      _found = false;
      _notFound = false;
    });
    for (var i = 0; i < list.length; i++) {
      if (_found) return;
      await Future.delayed(const Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _current = list[i];
            if (list[i] == _value) {
              _controllerCenter.play();
              _found = true;
              return;
            }
            if (i == list.length - 1) {
              setState(() {
                _notFound = true;
              });
            }
          });
        }
      });
    }
  }

  late ConfettiController _controllerCenter;
  late ConfettiController _controllerCenterRight;
  late ConfettiController _controllerCenterLeft;
  late ConfettiController _controllerTopCenter;
  late ConfettiController _controllerBottomCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerCenterRight.dispose();
    _controllerCenterLeft.dispose();
    _controllerTopCenter.dispose();
    _controllerBottomCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Linear search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: ConfettiWidget(
                confettiController: _controllerCenter,
                blastDirectionality: BlastDirectionality
                    .explosive, // don't specify a direction, blast randomly
                shouldLoop:
                    true, // start again as soon as the animation is finished
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ], // manually specify the colors to be used
              ),
            ),
            Column(
              children: [
                if (_notFound)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      "$_value Not found :(",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 30),
                    ),
                  ),
                if (_value != -1 && !_notFound && !_found)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox.square(
                            dimension: 50,
                            child: Image.asset('assets/giphy.gif')),
                        const Text(
                          "Loooooking for ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20),
                        ),
                        Text(
                          _value.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 30),
                        ),
                      ],
                    )),
                  ),
                Wrap(
                  children: list
                      .map((e) => Card(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                    Radius.circular(_current == e ? 5 : 0)),
                                color: _found && e == _value
                                    ? Colors.green
                                    : _current == e
                                        ? Colors.blue
                                        : Colors.white,
                              ),
                              child: Center(
                                  child: Text(e.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: _current == e
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ))
                      .toList(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: SizedBox(
                      height: 70,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            _found = false;
                            _current = -1;
                            _value = int.parse(value);
                          });
                        },
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'Enter value to look for',
                        ),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10),
                  child: SizedBox(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: _value == -1 ? null : start,
                          child: Text("Start"))),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
