import 'dart:convert';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:yamatube/library.dart';
import 'package:yamatube/movies_page.dart';
import 'package:yamatube/shorts_page.dart';
import 'package:yamatube/video_properties.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'kids.dart';

class HomePage extends StatefulWidget {
  static List <VideoProperties> videolist = [
    VideoProperties(videoUrl: "videos/TheHerro.mp4", thumbnailUrl: "assets/images/the_herro.jfif", title: 'THE HERRO', time: '1:40:28' , category: 'offline', group:"movies", subgroup: 'INTmv'),
    VideoProperties(videoUrl: "https://www.youtube.com/watch?v=ZWz2orbtcVo", thumbnailUrl: "assets/images/AVART_2_THE_WAY_OF_WATER.jfif", title: 'AVARTA 2: THE WAY OF WATER', time: '1:13' , category: 'online', group: 'movies', subgroup: 'INTmv'),
    VideoProperties(videoUrl: "https://www.youtube.com/watch?v=FVAib8FCDrs", thumbnailUrl: "assets/images/SUPER_BODY_GUARD.jfif", title: 'SUPER BODYGUARD', time: '1:18:38' , category: 'online', group: 'movies', subgroup: 'INTmv'),
    VideoProperties(videoUrl: "https://www.youtube.com/watch?v=Pu2Iy0P9WeU", thumbnailUrl: "assets/images/THE_MERMAID.jfif", title: 'THE MERMAID[LOVE STORY]', time: '1:13:24' , category: 'online', group: 'movies', subgroup: 'INTmv'),
    VideoProperties(videoUrl: "https://www.youtube.com/watch?v=UTAvGzCK6ok", thumbnailUrl: "assets/images/VALLEY_OF_THE_LANTENTS.jpg", title: 'VALLEY OF THE LANTENTS', time: '1:37:22' , category: 'online', group: 'kids', subgroup: 'kids'),
    //
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=npp2daWTc-c", thumbnailUrl: "assets/images/MALAIKA.jfif", title: 'MALAIKA', time: '1:33:20' , category: 'online', group: 'movies', subgroup: 'LOCmv'),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=y6-pCdAgvBU", thumbnailUrl: "assets/images/DRAGON_QUEEN.jfif", title: 'DRAGON QUEEN', time: '1:44:41' , category: 'online', group: "movies", subgroup: 'INTmv'),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=eXEvnce5Mvw", thumbnailUrl: "assets/images/FIRST_DAY_OF_RULE.jfif", title: 'FIRST DAY OF RULE', time: '24:39' , category: 'online', group: 'kids', subgroup: 'kids'),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=3FJCk8OsBtg", thumbnailUrl: "assets/images/VIGILANTE_DIARIES.jfif", title: ' VAGILANTE DIARIES [In swahili ]', time: '1:42:16' , category: 'online', group: 'movies', subgroup: 'INTmv'),
    // VideoProperties(videoUrl:"https://www.youtube.com/watch?v=5UKVP0439kw", thumbnailUrl: "assets/images/NAVERLAND_PROPHECY.jfif", title: "NAVERLAND PROPHECY", time: "1:05:05", category: "online", group: "kids", subgroup: "kids"),
    //
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=_7FgakKVP6c ", thumbnailUrl: "assets/images/LOVE _AND_BETRAY.jfif", title: "LOVE AND BETRAY", time: "1:13:20", category: "online", group: "movies", subgroup: "LOCmv"),
    // VideoProperties(videoUrl:"https://www.youtube.com/watch?v=wGXUyM0UoVY", thumbnailUrl: "assets/images/TOMY_ AND_ JERRY.jfif", title: "TOMY AND JERRY ", time: "29:18", category: "online", group: "kids", subgroup: "kids"),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=qoYWlIP2hfk", thumbnailUrl: "assets/images/MY_GUARDIAN_ANGLE.jfif", title: "1:44:31", time: "MY GUARDIAN ANGLE", category: "online", group: "movies", subgroup: "INTmv"),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=pBs2LkH_rwg ", thumbnailUrl: "assets/images/MASHA_ AND_ BEAR _MASHA _THE _GREATE.jfif", title: "MASHA AND BEAR MASHA THE GREATE", time: "35:02", category: "online", group: "kids", subgroup: "kids"),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=lyjPpvFHHqc", thumbnailUrl: "assets/images/MBUZI_WA_BIRTHDAY.jfif" , title: "MBUZI WA BIRTHDAY", time: "1:11:33", category: "online", group: "movies", subgroup: "LOCmv"),
    //
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=NL9fsjO7bPg", thumbnailUrl: "assets/images/MAGADHEERA.jfif", title: "MAGADHEERA[In swahili]", time: "2:14:28", category: "online", group: "movies", subgroup: "INTmv"),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=m4Zevk9Fqhc", thumbnailUrl: "assets/images/SUPER_DETENTION.jfif", title: "SUPER DETENTION", time: "1:24:46", category: "online", group: "movies", subgroup: "INTmv"),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=9pAVkwDOZyA", thumbnailUrl: "assets/images/MIRACULOUS_ALL _TRANSFORMATION_SEASON _4.jfif", title: "MIRACULOUS|ALL TRANSFORMATION|SEASON 4 ", time: "11:36", category: "online", group: "kids", subgroup: "kids"),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=TKMVuvviFM8", thumbnailUrl: "assets/images/MIRACULOUS _FINAL _SEASON 4.jfif", title: "MIRACULOUS FINAL SEASON 4", time: "15:37", category: "online", group: "kids", subgroup: "kids"),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=GGtTeG_OKjc", thumbnailUrl: "assets/images/URITHI_WA_MKOJAN.jfif", title: "URITHI WA MKOJAN", time: "1:02:49", category: "online", group: "movies", subgroup: "LOCmv"),
    //
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=TJVGHRKdGq4", thumbnailUrl: "assets/images/REVENGE_SQUAD.jfif", title: "REVENGE SQAUD ", time: "1:27:20", category: "online", group: "movies", subgroup: "INTmv"),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=AgLvIutFay4", thumbnailUrl: "assets/images/SHIMA_ AND_ SHINE.jfif", title: "SHIMA AND SHINE", time: "04:06", category: "online", group: "kids", subgroup: "kids"),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=NH1VQgw5gaU", thumbnailUrl:"assets/images/HEART_ATTACK.jfif" , title: "HEART ATTACK", time: "1:08:10", category: "online", group: "movies", subgroup: "LOCmv"),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=oiKFeVwoAPI", thumbnailUrl: "assets/images/RAPUNZEL_ VS _KASANDRA.jfif", title: "RAPUNZEL VS KASANDRA.jfif", time: "4:19", category: "online", group: "kids", subgroup: "kids"),
    // VideoProperties(videoUrl: "https://www.youtube.com/watch?v=xCSFrgesH6Q", thumbnailUrl: "assets/images/THE_PROMISE.jfif", title: "THE PROMISE", time: "", category: "online", group: "movies", subgroup: "LOCmv"),
    //
    //
    // VideoProperties(videoUrl: "videos/HUNTER KILLER.mp4", thumbnailUrl: "assets/images/HUNTER_KILLER.jfif", title: "HUNTER KILLER", time: "2:00:54", category: "offline", group: "movies", subgroup: "INTmv"),
    // VideoProperties(videoUrl: "videos/IP_MAN _THE_ AWAKENING.mkv", thumbnailUrl: "assets/images/I_P_MAN_THE_AWAKENING.jfif", title: "IP MAN THE AWAKENING", time: "1:19:39", category: "offline", group: "movies", subgroup: "INTmv"),
    // VideoProperties(videoUrl: "videos/MONSTER_PETS.mp4", thumbnailUrl: "assets/images/MONSTER_PETS.jpg", title: "MONSTER PETS", time: "05:51", category: "offline", group: "kids", subgroup: 'kids')
    
  ];

  //--------LIBRARY VIDEOS LIST------------

  static List<VideoProperties> library_video_list = [];
   late SharedPreferences preferences;
  bool issaved = false;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomePage homepage = HomePage();
  late VideoPlayerController controller;
  late YoutubePlayerController _tubeController;
  late ChewieController chewieController;
  bool playArea = false;
  bool youtubeVideo = false;
  String playing_area_video_title = "video-title";
  String playing_area_video_time = 'time';
  String playing_area_video_category = 'category';
  var playing_video;
   bool issaved = false;
   bool search = false;

  List<VideoProperties>display_video = List.from(HomePage.videolist);

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
     init();
    Movies.init();
    Shorts.ShortInit();
    Kids.kidsInit();
  }

  Future init() async {
    homepage.preferences = await SharedPreferences.getInstance();
    String? Library_video_list_store = homepage.preferences.getString('Library_videos_list_json_string_key');

    //--decoding the stored library_video_list_json_string to be and instance of Videoproperties for usage
    List <VideoProperties> Library_video_list_object = (jsonDecode(Library_video_list_store!) as List).map((i) => VideoProperties.fromJson(i)).toList();
    HomePage.library_video_list = Library_video_list_object;
    // HomePage.library_video_list.clear();
    setState(() {
    });
   // print(HomePage.library_video_list.length);
  }
  void update_video(String value) {
    setState(() {
      display_video = HomePage.videolist.where((element) => element.title!.toLowerCase().contains(value.toLowerCase())).toList();
    });
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        title: SingleChildScrollView(
       //   scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             playArea ==false?const Text(''):IconButton(onPressed: () {
               setState(() {
               playArea = false;
               });
               if(controller.value.isInitialized) {
                 controller.dispose();
               }
               if(youtubeVideo == true) {
                 _tubeController.dispose();
               }
               _tubeController.dispose();
             }, icon: Icon(Icons.arrow_back_outlined, color: Colors.black,)),
              Expanded(
                child:(search == false)?GestureDetector(
                  onTap: () {
                    yamatubeDesc();
                  },
                  child:Center(
                    child: Text(
                        'YAMATUBE',
                        style: TextStyle(
                          letterSpacing: 20,
                          fontFamily: 'PlayfairDisplay',
                          color: Color.fromARGB(255, 20, 1, 51)
                        ),
                      ),
                  ),
                  ):
                    searchField(),
              ),
             //TextField(
               // decoration: InputDecoration(
               //   hintText: "holle",
               //   hintStyle: TextStyle(
               //     color: Colors.red,
               //   )
               // ),
           //  )
              (search == false)?TextButton(onPressed: () {
                  setState(() {
                    search = true;
                  });
              }, child: Text("SEARCH", style: TextStyle(color:Colors.red),)):
                  TextButton(onPressed: () {
                    setState(() {
                      search = false;
                      display_video = List.from(HomePage.videolist);
                    });
                  }, child: Text(
                        'REFRESH',
                    style: TextStyle(color: Colors.purple,),

                  )
                  )

                 ,
            ],
          ),
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    (youtubeVideo == false)?AspectRatio(aspectRatio: 16/9, child:Chewie(controller: chewieController,)):
                       YoutubePlayer(
                           controller: _tubeController,
                           showVideoProgressIndicator: true,
                           onReady: () => debugPrint("ready"),
                            bottomActions: [
                              CurrentPosition(),
                              ProgressBar(
                                isExpanded: true,
                                colors: ProgressBarColors(
                                  playedColor: Colors.deepPurple,
                                  handleColor: Colors.white,
                                  backgroundColor: Colors.blueAccent,
                                  bufferedColor: Colors.grey,
                                ),
                              ),
                              RemainingDuration(),
                              FullScreenButton(),
                              // PlaybackSpeedButton(),
                            ],
                       ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                      child: Row(
                        children: [
                           Expanded( flex: 5, child: Text(playing_area_video_title, style: TextStyle(fontWeight: FontWeight.bold))),
                          Expanded(flex: 2, child: Text(playing_area_video_time, style: TextStyle(color: Colors.green,fontStyle: FontStyle.italic),)),
                          Expanded(flex: 2, child: Text(playing_area_video_category, style: TextStyle(color:Colors.red),)),
                          Expanded(flex: 1, child: IconButton(onPressed: () {
                          }, icon: Icon(Icons.save_alt_outlined))),
                          Expanded(flex: 1, child: IconButton(
                              onPressed: () {
                                HomePage.videolist.forEach((element) {
                                  if (element.videoUrl == controller.dataSource) {
                                    HomePage.library_video_list.add(element);
                                    // encoding the video list to json string for storage
                                    String Library_video_list_json_string = jsonEncode(HomePage.library_video_list);

                                    //storing the encoded added library_video_list
                                    homepage.preferences.setString("Library_videos_list_json_string_key", Library_video_list_json_string);
                                    setState(() {
                                    });
                                  }
                                });
                              },
                              icon: (issaved == false)?Icon(Icons.library_add_outlined):Icon(Icons.library_add_check_outlined)))
                        ],
                      ),
                    )
                  ],
                ),
              )),
        // playArea == false? Container():
        // //VideoPlayerSection(context),
          const SizedBox(height: 7,),
          /*----------------------LIST OF VIDEOS--------------------------------------------*/
          Expanded(
            child: Container(
              width: screenWidth,
              child: SingleChildScrollView(
                child: Column(
                  children: display_video.map((video) => GestureDetector(
                         onTap: () {
                           if (video.category == 'offline') {
                             controller = VideoPlayerController.asset(video.videoUrl)
                               ..initialize().then((_) {
                                 chewieController = ChewieController(videoPlayerController: controller);
                                 if(playArea == false) {
                                   playArea = true;
                                 }
                                 youtubeVideo = false;
                                 controller.play();
                                 playing_area_video_title =  video.title;
                                 playing_area_video_time = video.time;
                                 playing_area_video_category = video.category;
                                 setState(() {
                                 });
                               });
                           }
                             if(video.category == 'online') {
                               final videoID = YoutubePlayer.convertUrlToId(video.videoUrl);
                               _tubeController = YoutubePlayerController(
                                 initialVideoId: videoID!,
                                 flags: const YoutubePlayerFlags(
                                   autoPlay: true,
                                 ),
                               );
                                   setState(() {
                                     playArea = true;
                                     youtubeVideo = true;
                                     playing_area_video_title =  video.title;
                                     playing_area_video_time = video.time;
                                     playing_area_video_category = video.category;
                                   });
                                   if(controller.value.isInitialized) {
                                     controller.dispose();
                                   }
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
                            Container(width: screenWidth, height: 200, color: Colors.black, child: Image(fit: BoxFit.cover,image: AssetImage(video.thumbnailUrl)),),
                            const SizedBox(height: 4,),
                            Padding(
                              padding: const EdgeInsets.only(left:10.0, right: 10.0),
                              child: Row(
                                children:  [
                                  Expanded(flex: 5, child: Text(video.title, style: const TextStyle(fontWeight: FontWeight.bold),)),
                                  Expanded(flex: 3, child: Text(video.time, style: const TextStyle(color: Color.fromARGB(100, 6, 122, 12,), fontStyle:FontStyle.italic),)),
                                  Expanded(flex: 2, child: Text(video.category, style: const TextStyle(color: Colors.red))),
                                  IconButton(onPressed:() {
                                      bottomsheet(video);
                                  }, icon: const Icon(Icons.menu_outlined)),
                                ],
                              ),
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
          leading: (issaved == false)?Icon(Icons.library_add_outlined, color: Colors.purpleAccent):Icon(Icons.library_add_outlined, color: Colors.purpleAccent),
          title: Text("Add to Library"),
          onTap: () async {
            HomePage.library_video_list.add(video);
            // encoding the video list to json string for storage
            String Library_video_list_json_string = jsonEncode(HomePage.library_video_list);

            //storing the encoded added library_video_list
            homepage.preferences.setString("Library_videos_list_json_string_key", Library_video_list_json_string);
            setState(() {

            });
            init();
          },
        )
      ],
  )
  );
  void yamatubeDesc()  => showModalBottomSheet(
      context: context,
      builder: (context) => ListTile(
        leading: Icon(Icons.notes_outlined),
        title: Text(
            'About YAMATUBE',
          style: TextStyle(
            fontFamily: 'PlayfairDisplay',
            color: Color.fromARGB(255, 20, 1, 51)
        ),
        ),
        onTap: () {},
      ));
  Widget searchField() {
    return TextField(
      onChanged: (value) => update_video(value),
      decoration: InputDecoration(
        hintText: "search....",
        filled: true,
        fillColor: Colors.black12,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none
        ),
        suffixIcon: Icon(Icons.search),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
    _tubeController.dispose();
  }
  }

