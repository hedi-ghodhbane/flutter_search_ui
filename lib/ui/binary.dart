import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BinarySearch extends StatefulWidget {
  const BinarySearch({Key? key}) : super(key: key);

  @override
  State<BinarySearch> createState() => _BinarySearchState();
}

class _BinarySearchState extends State<BinarySearch> {
  int middle = -1;
  int a = -1;
  int b = -1;
  bool _found = false;
  bool _notFound = false;
  int _value = -1;
  final initialList = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18
  ];
  List<int> list = [];
  bool _started = false;
  void start() async {
    _controllerCenter.stop();
    setState(() {
      _found = false;
      _started = true;
      _notFound = false;
    });
    a = 0;
    b = initialList.length - 1;
    middle = (a + b) ~/ 2;

    setState(() {});
    while (initialList[middle] != _value && a != b) {
      await Future.delayed(const Duration(seconds: 4), () {
        if (mounted) {
          setState(() {
            //list = initialList.sublist(a, b);
          });
        }
      });
      if (_value > initialList[middle]) {
        a = middle + 1;
      } else if (_value < initialList[middle]) {
        b = middle - 1;
      }
      middle = (a + b) ~/ 2;
    }
    if (initialList[middle] != _value) {
      setState(() {
        _notFound = true;
        _started = false;
      });
    } else {
      setState(() {
        _found = true;
        _started = false;
        _controllerCenter.play();
      });
    }
  }

  late ConfettiController _controllerCenter;

  @override
  void initState() {
    super.initState();
    list = [...initialList];
    _controllerCenter =
        ConfettiController(duration: const Duration(seconds: 10));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xff2f243a),
        title: const Text('Binary search'),
      ),
      body: Center(
        child: Padding(
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
                  if (_value != -1 && !_notFound && !_found && _started)
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
                    children: list.asMap().entries.map((entry) {
                      final e = entry.value;
                      final index = entry.key;
                      return Stack(
                        children: [
                          Card(
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                border: isValue(e, middle)
                                    ? Border.all(color: Colors.black, width: 4)
                                    : isValue(e, a) || isValue(e, b)
                                        ? Border.all(
                                            color: Colors.red, width: 4)
                                        : null,
                                color: _found && e == _value
                                    ? Colors.green
                                    : isValue(e, middle)
                                        ? Colors.blue
                                        : Colors.white,
                              ),
                              child: Center(
                                  child: Text(e.toString(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: middle > -1 &&
                                                  initialList[middle] == e
                                              ? Colors.white
                                              : Colors.black,
                                          fontWeight: FontWeight.bold))),
                            ),
                          ),
                          if (isValue(e, a) || isValue(e, b))
                            Positioned(
                                top: 6,
                                left: 6,
                                child: Container(
                                  color: Colors.black.withOpacity(0.5),
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                      isValue(e, a)
                                          ? "A"
                                          : isValue(e, b)
                                              ? "B"
                                              : "",
                                      style: const TextStyle(
                                          fontSize: 10, color: Colors.white)),
                                )),
                          if (index < a || index > b && _started)
                            Positioned(
                                child: Icon(
                              Icons.close,
                              color: Colors.red,
                              size: 60,
                            )),
                        ],
                      );
                    }).toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: SizedBox(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        child: TextField(
                          readOnly: _started,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            setState(() {
                              _found = false;
                              _notFound = false;
                              middle = -1;
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
                            onPressed: _value == -1 || _started ? null : start,
                            child: const Text("Start"))),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isFound() => _found;
  bool isValue(int value, int toCompare) {
    if (toCompare == -1) return false;
    return initialList[toCompare] == value;
  }
}
