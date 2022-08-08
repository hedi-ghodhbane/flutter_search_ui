import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:search/ui/binary.dart';
import 'package:search/ui/linear.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PageController controller = PageController(initialPage: 0);
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _index,
            onTap: (index) {
              controller.animateToPage(index,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeIn);
              setState(() {
                _index = index;
              });
            },
            backgroundColor: const Color(0xff2f243a),
            unselectedItemColor: Colors.white,
            selectedItemColor: const Color(0xfffac9b8),
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Linear"),
              BottomNavigationBarItem(icon: Icon(Icons.search), label: "Binary")
            ]),
        body: PageView(
          controller: controller,
          children: [
            LinearSearch(),
            BinarySearch(),
          ],
        ));
  }
}
