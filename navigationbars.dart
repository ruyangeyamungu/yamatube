import 'package:flutter/material.dart';
import 'package:yamatube/home_page.dart';
import 'package:yamatube/kids.dart';
import 'package:yamatube/library.dart';
import 'package:yamatube/shorts_page.dart';
import 'movies_page.dart';

class NavigationTabBars extends StatefulWidget {
  const NavigationTabBars({Key? key}) : super(key: key);

  @override
  State<NavigationTabBars> createState() => _NavigationTabBarsState();
}

class _NavigationTabBarsState extends State<NavigationTabBars> {
  int current = 0;
  List<Widget> pages = [
    HomePage(),
     Movies(),
    Shorts(),
    Kids(),
    Library()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[current] ,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor:  const Color.fromARGB(100, 63, 2, 73),
        unselectedItemColor: Colors.purpleAccent,
        currentIndex: current,
        onTap: (index) {
          setState(() {
            current = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "HOME"),
          BottomNavigationBarItem(icon: Icon(Icons.movie_outlined), label: "MOVIES"),
          BottomNavigationBarItem(icon: Icon(Icons.view_day_outlined), label: "SHORTS"),
          BottomNavigationBarItem(icon: Icon(Icons.ondemand_video), label: "KIDS"),
          BottomNavigationBarItem(icon: Icon(Icons.video_collection_outlined), label: "LIBRARY"),
        ],
      ),
    );
  }
}
