import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:yamatube/home_page.dart';
import 'package:yamatube/library.dart';
import 'package:yamatube/video_properties.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Movies extends StatefulWidget {
  static List<VideoProperties> movies_list = HomePage.videolist;
  static Set<VideoProperties> only_movies_set = {};
  static Set<VideoProperties> INT_movies_set = {};
  static Set<VideoProperties> LOC_movies_set = {};
  //------LIBRARY SAVED LIST-------------------------------------------------------
  static List<VideoProperties>library_movies_list = [];
  static late SharedPreferences preference;
   static int currentMovieIndex=0;

 static void init() async{
    preference = await SharedPreferences.getInstance();
    String? library_movies_list_store = preference.getString("library_movies_list_json_string_key");

    // decoding the stored json string list to objectlist

    List<VideoProperties>library_movies_video_list_object =(jsonDecode(library_movies_list_store! )as List).map((i) => VideoProperties.fromJson(i)).toList();
    Movies.library_movies_list = library_movies_video_list_object;
   // print(Movies.library_movies_list.length);
    // setState(() {
    // });
  }

 // const Movies({super.key});

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
   Movies movies = Movies();
  late VideoPlayerController controller;
  late ChewieController chewieController;
  bool playArea = false;
  String moviestype = 'ALL';

  Library x = Library();

  late SharedPreferences preference;
  
  void onlyMovies() {
    Movies.movies_list.forEach((videos) {
      if(videos.group == "movies") {
        Movies.only_movies_set.add(videos);
      }
    });
    //--F0R INTERNATINAL MOVIES--
    for(var i in Movies.only_movies_set) {
      if(i.subgroup == "INTmv") {
        Movies.INT_movies_set.add(i);
      }
    }
    //---FOR LOCAL MOVIES------------------------
    for(var i in Movies.only_movies_set) {
      if(i.subgroup == "LOCmv") {
        Movies.LOC_movies_set.add(i);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onlyMovies();
    Movies.init();
  }


  @override

  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    List moviesCategory = [AllMovies(context), InternationMovies(context), LocalMovies(context)];

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
            GestureDetector(
              onTap: (){
              },
              child: Text(
                'YAMATUBE',
                style: TextStyle(
                    letterSpacing: 20,
                    fontFamily: 'PlayfairDisplay',
                    color: Color.fromARGB(255, 20, 1, 51)
                ),
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
              decoration: const BoxDecoration(
                  color: Color.fromARGB(100, 255, 255, 255),
                border: Border(
                  bottom: BorderSide(
                    width: 1, style: BorderStyle.solid, color: Color.fromARGB(100, 171, 168, 168),
                  ),
                ),
              ),
              child: Column(
                children: [
                  AspectRatio(aspectRatio: 16/9, child: Chewie(controller: chewieController,),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                    child: Row(
                      children: [
                        const Expanded( flex: 7, child: Text('niffer',)),
                        const Expanded(flex: 2, child: Text('90 sec', style: TextStyle(color: Colors.green),)),
                        const Expanded(flex: 2, child: Text('offline', style: TextStyle(color:Colors.red),)),
                        Expanded(flex: 1, child: IconButton(onPressed: () {
                        }, icon: Icon(Icons.save_alt_outlined))),
                        Expanded(flex: 1, child: IconButton(
                            onPressed: () {
                                     Movies.movies_list.forEach((element) {
                                       if(element.videoUrl == controller.dataSource) {
                                         Movies.library_movies_list.add(element);

                                         //encoding the moviees list to json string
                                         String libray_movies_list_string = jsonEncode(Movies.library_movies_list);

                                         //storing the encoded list---
                                         Movies.preference.setString("library_movies_list_json_string_key", libray_movies_list_string);
                                         setState(() {
                                         });
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
          Padding(
            padding: const EdgeInsets.only(left: 7, right: 7),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                    child: (Movies.currentMovieIndex == 0)?ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.deepPurple,
                      ),
                        onPressed: () {}, child: Text('All')):
                    TextButton(
                        style: TextButton.styleFrom(
                          side: BorderSide(width: 1, color: Colors.pink),
                          primary: Colors.purpleAccent,
                        ),
                        onPressed: () {
                          setState(() {
                            Movies.currentMovieIndex = 0;
                          });
                        }, child: Text('All'))
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 6,
                  child: (Movies.currentMovieIndex != 1)? TextButton(
                      style: TextButton.styleFrom(
                        side: BorderSide(width: 1, color: Colors.pink),
                        primary: Colors.purpleAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          Movies.currentMovieIndex = 1;
                        });
                      },
                      child: const Text("INTERNATIONAL MOVIES")):
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurple,
                    ),
                      onPressed: () {
                      },
                      child: const Text("INTERNATIONAL MOVIES")),
                ),
                const SizedBox(width: 5,),
                Expanded(
                  flex: 3,
                   child: ( Movies.currentMovieIndex != 2)?OutlinedButton(
                     style: OutlinedButton.styleFrom(
                       side: BorderSide(width: 1, color: Colors.pink),
                       primary: Colors.purpleAccent,
                     ),
                      onPressed: () {
                        setState(() {
                          Movies.currentMovieIndex = 2;
                        });
                      },
                      child: const Text("LOCAL MOVIES")
                   ):
                   ElevatedButton(
                       style: ElevatedButton.styleFrom(
                           primary: Colors.deepPurple,
                       ),
                       onPressed: () {
                       },
                       child: const Text("LOCAL MOVIES")
                   ),
                )
              ],
            ),
          ),
          SizedBox(height: 8,),
          /*----------------------LIST OF VIDEOS--------------------------------------------*/
          Expanded(
            child: Container(
              width: screenWidth,
              child: SingleChildScrollView(
                 child: moviesCategory[Movies.currentMovieIndex],
              )
              ),
            ),
        ],
      ),
    );
  }

  void bottomsheet (movies)=> showModalBottomSheet(
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
            onTap: () {

              },
          ),
          ListTile(
            leading: Icon(Icons.library_add_outlined, color: Colors.purpleAccent,),
            title: Text("Add to Library"),
            onTap: () {
               Movies.library_movies_list.add(movies);

               //encoding the moviees list to json string
               String libray_movies_list_string = jsonEncode(Movies.library_movies_list);

               //storing the encoded list---
              Movies.preference.setString("library_movies_list_json_string_key", libray_movies_list_string);
              setState(() {
              });
            },
          )
        ],
      )
  );

  //-------------------MOVIES CATEGORY-----------------------------------------------------
     Widget AllMovies(context) {
       return Column(
         children: Movies.only_movies_set.map((movies) =>
                   GestureDetector(
                 onTap: () {
                  if (movies.category == 'offline') {
                     controller =
                     VideoPlayerController.asset(movies.videoUrl)
                       ..initialize().then((_) {
                         chewieController = ChewieController(videoPlayerController: controller);
                         if(playArea == false) {
                           playArea = true;
                         }
                         controller.play();
                       setState(() {
                         });
                       });
                   }
                   if(movies.category == 'online') {
                     controller =
                     VideoPlayerController.network(movies.videoUrl)
                       ..initialize().then((_) {
                           chewieController = ChewieController(videoPlayerController: controller);
                           if(playArea == false) {
                             playArea = true;
                           }
                           controller.play();
                           setState(() {
                           });
                       });
                  }
                 },
                 child: Container(
                   width: MediaQuery.of(context).size.width,
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
                  Container(width: MediaQuery.of(context).size.width, height: 200, color: Colors.black, child: Image(image: AssetImage(movies.thumbnailUrl), fit: BoxFit.cover,),),
                  SizedBox(height: 4,),
                  Row(
                    children:  [
                      Expanded(flex: 5, child: Text(movies.title)),
                      Expanded(flex: 3, child: Text(movies.time, style: TextStyle(color: Color.fromARGB(100, 6, 122, 12,), fontStyle:FontStyle.italic),)),
                      Expanded(flex: 2, child: Text(movies.category, style: TextStyle(color: Colors.red))),
                      IconButton(onPressed:() {
                        bottomsheet(movies);
                      }, icon: Icon(Icons.menu_outlined)),
                    ],
                  ),
                ],

              ),
            ),
          ),
          ).toList()
       );
     }


    Widget InternationMovies(context) {
    return  Column( children: Movies.INT_movies_set.map((movies) =>
         GestureDetector(
           onTap: () {
             if (movies.category == 'offline') {
               controller =
               VideoPlayerController.asset(movies.videoUrl)
                 ..initialize().then((_) {
                   chewieController =
                       ChewieController(videoPlayerController: controller);
                   if (playArea == false) {
                     playArea = true;
                   }
                   setState(() {});
                 });
             }
             if (movies.category == 'online') {
               controller =
               VideoPlayerController.network(movies.videoUrl)
                 ..initialize().then((_) {
                   setState(() {
                     chewieController =
                         ChewieController(videoPlayerController: controller);
                         controller.play();
                   });
                 });
             }
           },
           child: Container(
             width: MediaQuery.of(context).size.width,
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
                 Container(width:  MediaQuery.of(context).size.width,
                   height: 200,
                   color: Colors.black,
                   child: Image(image: AssetImage(movies.thumbnailUrl),
                     fit: BoxFit.cover,),),
                 SizedBox(height: 4,),
                 Row(
                   children: [
                     Expanded(flex: 5, child: Text(movies.title)),
                     Expanded(flex: 3,
                         child: Text(movies.time, style: TextStyle(
                             color: Color.fromARGB(100, 6, 122, 12,),
                             fontStyle: FontStyle.italic),)),
                     Expanded(flex: 2,
                         child: Text(movies.category,
                             style: TextStyle(color: Colors.red))),
                     IconButton(onPressed: () {
                       bottomsheet(movies);
                     }, icon: Icon(Icons.menu_outlined)),
                   ],
                 ),
               ],

             ),
           ),
         ),
     ).toList()
    );
   }


   Widget LocalMovies(context) {
     return  Column( children: Movies.LOC_movies_set.map((movies) =>
         GestureDetector(
           onTap: () {
             if (movies.category == 'offline') {
               controller =
               VideoPlayerController.asset(movies.videoUrl)
                 ..initialize().then((_) {
                   chewieController =
                       ChewieController(videoPlayerController: controller);
                   if (playArea == false) {
                     playArea = true;
                   }
                   setState(() {});
                 });
             }
             if (movies.category == 'online') {
               controller =
               VideoPlayerController.network(movies.videoUrl)
                 ..initialize().then((_) {
                   setState(() {
                     chewieController =
                         ChewieController(videoPlayerController: controller);
                          controller.play();
                   });
                 });
             }
           },
           child: Container(
             width: MediaQuery.of(context).size.width,
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
                 Container(width:  MediaQuery.of(context).size.width,
                   height: 200,
                   color: Colors.black,
                   child: Image(image: AssetImage(movies.thumbnailUrl),
                     fit: BoxFit.cover,),),
                 SizedBox(height: 4,),
                 Row(
                   children: [
                     Expanded(flex: 5, child: Text(movies.title)),
                     Expanded(flex: 3,
                         child: Text(movies.time, style: TextStyle(
                             color: Color.fromARGB(100, 6, 122, 12,),
                             fontStyle: FontStyle.italic),)),
                     Expanded(flex: 2,
                         child: Text(movies.category,
                             style: TextStyle(color: Colors.red))),
                     IconButton(onPressed: () {
                       bottomsheet(movies);
                     }, icon: Icon(Icons.menu_outlined)),
                   ],
                 ),
               ],

             ),
           ),
         ),
     ).toList()
     );
   }
}
