import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'package:yamatube/home_page.dart';
import 'package:yamatube/kids.dart';
import 'package:yamatube/movies_page.dart';
import 'package:yamatube/shorts_page.dart';
import 'package:yamatube/video_properties.dart';

class Library extends StatefulWidget {
  static  Set <VideoProperties>stored_video_set= {};
  static List<VideoProperties>  deleted_videos = [];
  static Set<VideoProperties> deleted_video_set = {};

@override
State<Library> createState() => _LibraryState();

 }

class _LibraryState extends State<Library>  {

  Library library = Library();
  late VideoPlayerController controller;
  late ChewieController chewieController;
  String playing_area_video_title = "video-title";
  String playing_area_video_time = 'time';
  String playing_area_video_category = 'category';
  var playing_video;
  bool issaved = false;
  bool playArea = false;
  bool cacheDisplay = false;

  late SharedPreferences preferences;


  void allSaves() {
    for(var movies in Movies.library_movies_list)  {
      Library.stored_video_set.add(movies);
    }
    for(var videos in HomePage.library_video_list)  {
      Library.stored_video_set.add(videos);
    }
    for(var shorts in Shorts.library_shorts_list)  {
      Library.stored_video_set.add(shorts);
    }
    for(var kids in Kids.library_kids_list)  {
      Library.stored_video_set.add(kids);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allSaves();
    init();

  }
  void init() async {
   preferences = await SharedPreferences.getInstance();
    String? delete_video_json_string = preferences.getString("deleted_video_key");
    List<VideoProperties> delete_video_object_list = (jsonDecode(delete_video_json_string!) as List).map((i) => VideoProperties.fromJson(i)).toList();
   Library.deleted_videos  = delete_video_object_list;
   Library.deleted_video_set = Set.from(Library.deleted_videos);
   allSaves();
   for(var deleted_videos in Library.deleted_video_set) {
     if(Library.stored_video_set.contains(deleted_videos.title)) {
       Library.stored_video_set.remove(deleted_videos);
     }
   }
    setState(() {
    });
    print(Library.deleted_videos);
   print("---------------------------the set of deleted videos------------------------------");
   print(Library.deleted_video_set);
   print("------------------------------------------------------------------------------------------");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () {
                  if(cacheDisplay == true) {
                     cacheDisplay = false;
                    }
                    setState(() {
                  });
               }, child:Text("LIBRARY")),
              playArea ==false?const Text(''):IconButton(onPressed: () {setState(() {
                playArea = false;
                controller.dispose();
              });}, icon: Icon(Icons.arrow_back_outlined, color: Colors.black,)),
              Expanded(child: Text("")),
              TextButton(onPressed: () {
                  cacheDisplay = true;
                setState(() {
                });
              }, child:Text("CACHE"))
            ],
          ),
        ),
        //   centerTitle: true,
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*---------------------------------------------PLAYING AREA---------------------------------------*/
          if (playArea == false) Container() else Container(
              width: MediaQuery.of(context).size.width,
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
                        Expanded( flex: 7, child: Text(playing_area_video_title, style: TextStyle(fontWeight: FontWeight.w300))),
                        Expanded(flex: 2, child: Text(playing_area_video_time, style: TextStyle(color: Colors.green),)),
                        Expanded(flex: 2, child: Text(playing_area_video_category, style: TextStyle(color:Colors.red),)),
                        Expanded(flex: 1, child: IconButton(onPressed: () {
                        }, icon: Icon(Icons.save_alt_outlined))),
                        Expanded(flex: 1, child: IconButton(
                            onPressed: () {
                              HomePage.library_video_list.add(HomePage.videolist[0]);
                            },
                            icon: (issaved == false)?Icon(Icons.library_add_outlined):Icon(Icons.library_add_check_outlined)))
                      ],
                    ),
                  )
                ],
              )),
          // playArea == false? Container():
          // //VideoPlayerSection(context),
          const SizedBox(height: 7,),
          /*----------------------LIST OF VIDEOS--------------------------------------------*/
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 10),
              decoration: BoxDecoration(border:Border(top: BorderSide(color: Colors.red, style: BorderStyle.solid, width: 2))),
              child: SingleChildScrollView(
                child: (cacheDisplay == false)?libraryStore():cache(),
              ),
            ),
          ),
        ],
      )
    );
  }

   Widget libraryStore() {
    return Column(
        children:  Library.stored_video_set.map((libraryVideos) => GestureDetector(
          onTap: () {
            if (libraryVideos.category == 'offline') {
              controller = VideoPlayerController.asset(libraryVideos.videoUrl)
                ..initialize().then((_) {
                  chewieController = ChewieController(videoPlayerController: controller);
                  if(playArea == false) {
                    playArea = true;
                  }
                  controller.play();
                  playing_area_video_title =  libraryVideos.title;
                  playing_area_video_time = libraryVideos.time;
                  playing_area_video_category = libraryVideos.category;
                  setState(() {
                  });
                });
            }
            if(libraryVideos.category == 'online') {
              controller =
              VideoPlayerController.network(libraryVideos.videoUrl)
                ..initialize().then((_) {
                  chewieController = ChewieController(videoPlayerController: controller);
                  if(playArea == false) {
                    playArea == true;
                  }
                  playing_area_video_title =  libraryVideos.title;
                  playing_area_video_time = libraryVideos.time;
                  playing_area_video_category = libraryVideos.category;
                  setState(() {
                  });
                });
            }
          },
          child: Card(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    Container(width: 130, height: 100, color: Colors.black, child: Image(image:AssetImage(libraryVideos.thumbnailUrl), fit: BoxFit.cover,),),
                    SizedBox(width: 4),
                    Expanded(
                        child:
                        Container(
                            width: 230, height: 100,
                            color: Colors.white,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(libraryVideos.title),
                                  SizedBox(height: 10,),
                                  Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.black,),
                                  const SizedBox(height:6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [

                                      Text(
                                          libraryVideos.time,
                                          style: TextStyle(
                                            color: Colors.green,
                                          )
                                      ),
                                      SizedBox(width:  15),
                                      Text(
                                          libraryVideos.category,
                                          style: TextStyle(
                                            color: Colors.red,
                                          )
                                      ),
                                      const SizedBox(width: 10),
                                      IconButton(
                                          onPressed: () {} ,
                                          icon: Icon(Icons.save_alt_outlined)),
                                      IconButton(onPressed: () async {
                                        setState(() {
                                          Library.stored_video_set.remove(libraryVideos);
                                        });
                                        Library.deleted_videos.add(libraryVideos);
                                        String stored_video_set =jsonEncode(Library.stored_video_set);
                                        String deleted_video_string = jsonEncode(Library.deleted_videos);
                                        preferences.setString("deleted_video_key", deleted_video_string );
                                        setState(() {
                                        });
                                      }, icon: const Icon(Icons.delete_forever_outlined)),
                                    ],
                                  ),
                                ]
                            )
                        )
                    ),

                  ],
                ),
              )
          ),
        ),
        ).toList()
    );
   }

  Widget cache() {
    return Column(
          children:  Library.deleted_videos.map((deletedVideos) => GestureDetector(
            onTap: () {
              if (deletedVideos.category == 'offline') {
                controller = VideoPlayerController.asset(deletedVideos.videoUrl)
                  ..initialize().then((_) {
                    chewieController = ChewieController(videoPlayerController: controller);
                    if(playArea == false) {
                      playArea = true;
                    }
                    controller.play();
                    playing_area_video_title =  deletedVideos.title;
                    playing_area_video_time = deletedVideos.time;
                    playing_area_video_category = deletedVideos.category;
                    setState(() {
                    });
                  });
              }
              if(deletedVideos.category == 'online') {
                controller =
                VideoPlayerController.network(deletedVideos.videoUrl)
                  ..initialize().then((_) {
                    chewieController = ChewieController(videoPlayerController: controller);
                    if(playArea == false) {
                      playArea == true;
                    }
                    playing_area_video_title =  deletedVideos.title;
                    playing_area_video_time = deletedVideos.time;
                    playing_area_video_category = deletedVideos.category;
                    setState(() {
                    });
                  });
              }
            },
            child: Card(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(width: 130, height: 100, color: Colors.black, child: Image(image:AssetImage(deletedVideos.thumbnailUrl), fit: BoxFit.cover,),),
                      SizedBox(width: 4),
                      Expanded(
                          child:
                          Container(
                              width: 230, height: 100,
                              color: Colors.white,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(deletedVideos.title),
                                    SizedBox(height: 10,),
                                    Container(width: MediaQuery.of(context).size.width, height: 1, color: Colors.black,),
                                    const SizedBox(height:6),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Text(
                                            deletedVideos.time,
                                            style: TextStyle(
                                              color: Colors.green,
                                            )
                                        ),
                                        SizedBox(width:  15),
                                        Text(
                                            deletedVideos.category,
                                            style: TextStyle(
                                              color: Colors.red,
                                            )
                                        ),
                                        const SizedBox(width: 10),
                                        IconButton(
                                            onPressed: () {} ,
                                            icon: Icon(Icons.save_alt_outlined)),
                                        IconButton(onPressed: () async {
                                          Library.deleted_videos.add(deletedVideos);
                                          String stored_video_set =jsonEncode(Library.stored_video_set);
                                          String deleted_video_string = jsonEncode(Library.deleted_videos);
                                          preferences.setString("deleted_video_key", deleted_video_string );
                                          setState(() {
                                          });
                                        }, icon: const Icon(Icons.delete_forever_outlined)),
                                      ],
                                    ),
                                  ]
                              )
                          )
                      ),
                    ],
                  ),
                )
            ),
          ),
          ).toList()
      );
  }
}

