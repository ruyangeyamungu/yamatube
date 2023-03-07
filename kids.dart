import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:yamatube/home_page.dart';
import 'package:yamatube/video_properties.dart';
import 'package:shared_preferences/shared_preferences.dart';
class Kids extends StatefulWidget {
  static   List<VideoProperties> kids_movies_list = HomePage.videolist;
  static Set<VideoProperties> videos_kids_set = {};
  static List<VideoProperties> library_kids_list = [];
  static late SharedPreferences preferences;

  static void kidsInit() async {
    preferences = await SharedPreferences.getInstance();
    //getting the stored json string list
    String? library_kids_list_json_store = preferences.getString("library_kids_list_json_string_key");
    //decoding the stroed json string to list object
    List<VideoProperties> library_kids_list_json_object =(jsonDecode(library_kids_list_json_store!) as List).map((i) => VideoProperties.fromJson(i)).toList();
    Kids.library_kids_list = library_kids_list_json_object;
    // setState(() {
    // });
  }

  Kids({Key? key}) : super(key: key);

  @override
  State<Kids> createState() => _ShortsState();
}

class _ShortsState extends State<Kids> {
  late VideoPlayerController controller;
  late ChewieController chewieController;
  bool playArea = false;


   void kidsVideos() {
    Kids.kids_movies_list.forEach((videos) {
      if (videos.group == "kids") {
        Kids.videos_kids_set.add(videos);
        setState(() {});
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    kidsVideos();
    Kids.kidsInit();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return  Scaffold(
      //  backgroundColor: (Color.fromARGB(100, 188, 168, 192)),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            playArea ==false?const Text(''):IconButton(onPressed: () {setState(() {
              playArea = false;
              controller.dispose();
            });}, icon: Icon(Icons.arrow_back_outlined, color: Colors.black,)),
            Text(
              'YAMATUBE',
              style: TextStyle(
                letterSpacing: 20,
                color: Color.fromARGB(100, 80, 2, 94),
              ),
            ),
          ],
        ),
        //   centerTitle: true,
      ),
      body: Column(
        children: [
          /*---------------------------------------------PLAYING AREA---------------------------------------*/
          if (playArea == false) Container() else Container(
              width: screenWidth,
              decoration: BoxDecoration(
                  color: Color.fromARGB(100, 255, 255, 255),
                  border: Border(
                      bottom: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.blue)
                  )
              ),
              child: Column(
                children: [
                  AspectRatio(aspectRatio: 16/9, child: Chewie(controller: chewieController,),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                    child: Row(
                      children: [
                        Expanded( flex: 7, child: Text('niffer',)),
                        Expanded(flex: 2, child: Text('90 sec', style: TextStyle(color: Colors.green),)),
                        Expanded(flex: 2, child: Text('offline', style: TextStyle(color:Colors.red),)),
                        Expanded(flex: 1, child: IconButton(onPressed: () {
                        }, icon: Icon(Icons.save_alt_outlined))),
                        Expanded(flex: 1, child: IconButton(
                            onPressed: () {
                              Kids.kids_movies_list.forEach((element) {
                                if(element.videoUrl == controller.dataSource) {
                                  Kids.library_kids_list.add(element);

                                  //encode to json string
                                  String library_kids_json_list = jsonEncode(Kids.library_kids_list);

                                  //stroring the encoded list
                                  Kids.preferences.setString("library_kids_list_json_string_key", library_kids_json_list);
                                }
                              });
                            },
                            icon: Icon(Icons.library_add_outlined)))
                      ],
                    ),
                  )
                ],
              )),
          const SizedBox(height: 7,),
          /*----------------------LIST OF VIDEOS--------------------------------------------*/
          Expanded(
            child: Container(
              width: screenWidth,
              child: SingleChildScrollView(
                child: Column(
                    children: Kids.videos_kids_set.map((video) => GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   if(playArea == false) {
                        //     playArea = true;
                        //   }
                        // });
                        if (video.category == 'offline') {
                          controller =
                          VideoPlayerController.asset(video.videoUrl)
                            ..initialize().then((_) {
                              chewieController = ChewieController(videoPlayerController: controller);
                              if(playArea == false) {
                                playArea = true;
                              }
                              setState(() {
                              });
                            });
                        }
                        if(video.category == 'online') {
                          controller =
                          VideoPlayerController.network(video.videoUrl)
                            ..initialize().then((_) {
                              setState(() {
                                chewieController = ChewieController(videoPlayerController: controller);
                                print("whts video, online");
                              });
                            });
                        }
                      },
                      child: Container(
                        width: screenWidth,
                        padding: EdgeInsets.only(bottom: 6),
                        margin: EdgeInsets.only(bottom: 14),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  width: 1,
                                  color: Color.fromARGB(100, 4, 13, 61),
                                  style: BorderStyle.solid,
                                )
                            )
                        ),
                        child: Column(
                          children: [
                            Container(width: screenWidth, height: 200, color: Colors.black, child: Image(image: AssetImage(video.thumbnailUrl)),),
                            SizedBox(height: 4,),
                            Row(
                              children:  [
                                Expanded(flex: 5, child: Text(video.title)),
                                Expanded(flex: 3, child: Text(video.time, style: TextStyle(color: Color.fromARGB(100, 6, 122, 12,), fontStyle:FontStyle.italic),)),
                                Expanded(flex: 2, child: Text(video.category, style: TextStyle(color: Colors.red))),
                                IconButton(onPressed:() {
                                  bottomsheet(video);
                                }, icon: Icon(Icons.menu_outlined)),
                              ],
                            ),
                          ],

                        ),
                      ),
                    ),
                    ).toList()
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  void bottomsheet (video)=> showModalBottomSheet(
    //enableDrag: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20)

          )
      ),
      context: context,
      builder: (context) =>  Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.save_alt_outlined, color: Colors.deepPurple,),
            title: Text("Download"),
            onTap: () {print("downloading");},
          ),
          ListTile(
            leading: Icon(Icons.library_add_outlined, color: Colors.purpleAccent,),
            title: Text("Add to Library"),
            onTap: () {
              Kids.library_kids_list.add(video);

              //encode to json string
              String library_kids_json_list = jsonEncode(Kids.library_kids_list);

              //stroring the encoded list
              Kids.preferences.setString("library_kids_list_json_string_key", library_kids_json_list);

            },
          )
        ],
      )
  );
}