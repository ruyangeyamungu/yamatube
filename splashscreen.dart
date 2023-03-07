import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:yamatube/navigationBars.dart';
import "package:video_player/video_player.dart";
import 'package:carousel_slider/carousel_slider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  final descriptText = [
    "WATCH MOVIES ON YAMATUBE",
    "YAMATUBE FOR KIDS",
    "YAMATUBE LIBRARY",
  ];
  final descriptTextdata = [
    "rjajabu",
    "summaiya",
    "hawa",

  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset("videos/Guddan_Tumse_Na_Ho_Payega.mp4")
    ..initialize().then((value) {
      _controller.setVolume(0.0);
      _controller.play();
      _controller.setLooping(true);
      setState(() {});
    });
    navigator();
  }

  navigator() async {
      await Future.delayed(const Duration(seconds: 10), () {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavigationTabBars()));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    //  backgroundColor: const Color.fromARGB(100, 80, 2, 94),
       body: Stack(
            children: [
              Expanded(
                child: Container(
                    padding: EdgeInsets.all(40.0),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    color: Colors.purple,
               // child: VideoPlayer(_controller)
                ),
              ),

              Container(
                padding: EdgeInsets.all(20),
                  width: 400,
                  height: 300,
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Container(height: 200, width: 200, color: Colors.blue),
                      SizedBox(height: 30),
                      Center(child: SpinKitFadingCube(color: Colors.red  //Color.fromARGB(100, 80, 2, 94),
     ),
     ),
                      SizedBox(height: 20),
                      Container(height: 200, width: 200, color: Colors.yellow)
                    ],
                  ),
              ),
              // Container(
              //   margin: EdgeInsets.fromLTRB(20, 690, 20, 20),
              //   width: 400,
              // decoration: BoxDecoration(
              //   color: Colors.black54,
              //   border: Border.all(width: 1, style: BorderStyle.solid),
              //   borderRadius: BorderRadius.circular(60),
              // ),
              // child: Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Center(child:
              //             Text(
              //               'YAMATUBE',
              //               style: TextStyle(
              //                 letterSpacing: 20,
              //                 fontFamily: "PlayfairDisplay",
              //                 color: Color.fromARGB(255, 255, 255, 255)
              //               ),
              //             ),
              //     ),
              //     Text(
              //         "version: 0.0.1",
              //       style: TextStyle(
              //         color: Colors.purpleAccent
              //       ),
              //     ),
              //     SizedBox(height: 30,),
              //     RichText(
              //       text: TextSpan(
              //        text: "Poweredby: ",
              //        style: TextStyle(
              //        color: Colors.white,)
              //     ),
              //
              //     )
              //   ],
              // ),
              // ),
              // Container(width: MediaQuery.of(context).size.width,
              //     height: 200,
              //     //color: Colors.pink,
              //   margin: EdgeInsets.fromLTRB(20, 60, 20, 20),
              //   padding: EdgeInsets.all(1),
              //    child: CarouselSlider.builder(
              //      options: CarouselOptions(
              //          height: 400,
              //          autoPlay: true,
              //          reverse: true,
              //          autoPlayInterval: Duration(seconds: 1),
              //          viewportFraction: 1,
              //
              //      ),
              //      itemCount: descriptText.length,
              //      itemBuilder: (context, index, realIndex) {
              //        final text = descriptText[index];
              //        final textData = descriptTextdata[index];
              //
              //        return buildDescriptText(textData, text, index);
              //      },
              //    )
              //   // Column(
              //   //   crossAxisAlignment: CrossAxisAlignment.center,
              //   //   children: [
              //   //     Text(
              //   //         "WATCH MOVIES ON YAMATUBE",
              //   //         style:TextStyle(
              //   //           fontSize: 20,
              //   //           fontWeight: FontWeight.w300,
              //   //           color: Colors.white,
              //   //         )
              //   //     ),
              //   //     SizedBox(height: 10),
              //   //
              //   //     Column(
              //   //       children: [
              //   //         Text("*********************************************"),
              //   //         Text("*********************************************"),
              //   //         Text("*********************************************"),
              //   //         Text("*********************************************"),
              //   //       ],
              //   //     )
              //   //   ],
              //   // ),
              //
              // )
            ]
          )
     //   ],
    //  ),
    );
  }

  Widget buildDescriptText(String textData, String text, int index) {
    return Container(
      width: 400,
      height: 200,
      color: Colors.black,
    //  margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 10),
        child: Column(
          children: [
             Text(
                text,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.purple,
            ),),
            SizedBox(height: 5,),
            Text(textData)
          ],
        ),
      ),
    );
  }
}
