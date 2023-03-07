// class VideoProperties {
//    String videoUrl;
//   String thumbnailUrl;
//   String title;
//   String time;
//   String category;
//   String group;
//   String subgroup;
//
//  VideoProperties({required this.videoUrl, required this.thumbnailUrl, required this.title, required this.time, required this.category, required this.group, required this.subgroup});
//
//  //-----------------convertion to json---------------------------------
//  // Map<String, dynamic> toJson() => {
//  //  'videoUrl': videoUrl,
//  //  'thumbnailUrl': thumbnailUrl,
//  //  'title': title,
//  //  'time': time,
//  //  'category': category,
//  //  'group': group,
//  //  'subgroup': subgroup
//  // };
//  //
//  //   VideoProperties.fromJson(Map<String, dynamic>json)
//  // : videoUrl = json['videoUrl'],
//  //   thumbnailUrl = json['thumbnailUrl'],
//  //   title = json['title'],
//  //   time = json['time'],
//  //   category = json['category'],
//  //   group = json['group'],
//  //   subgroup = json['subgroup'];
//
// /*/HAS CODING-------------------------------------------------------------------------------------- */
//  @override
// bool operator == (Object, other) =>
//     identical(this, other)  ||
//     other is VideoProperties &&
//     runtimeType == other.runtimeType &&
//     videoUrl == other.videoUrl &&
//     thumbnailUrl == other.thumbnailUrl &&
//     title == other.title &&
//     time == other.time &&
//     category == other.category &&
//     group == other.group &&
//     subgroup == other.subgroup;
//
// @override
//  int get hashCode =>  videoUrl.hashCode ^ thumbnailUrl.hashCode ^ title.hashCode ^ time.hashCode ^ category.hashCode ^ group.hashCode ^ subgroup.hashCode;
//
// }

class VideoProperties {
    String videoUrl;
  String thumbnailUrl;
   String title;
   String time;
   String category;
   String group;
   String subgroup;
   VideoProperties( {
       required this.videoUrl,
        required this.thumbnailUrl,
        required this.title, required this.time,
        required this.category,
        required this.group,
        required this.subgroup
   });


    @override
    bool operator  == (Object other) =>
     identical(this, other)  ||
         other is  VideoProperties &&
             runtimeType == other.runtimeType &&
              videoUrl == other.videoUrl &&
             thumbnailUrl == other.thumbnailUrl &&
             title == other.title &&
             time == other.time &&
             category == other.category &&
             group == other.group &&
             subgroup == other.subgroup;


 @override
  int get hashCode =>  videoUrl.hashCode ^ thumbnailUrl.hashCode ^ title.hashCode ^ time.hashCode ^ category.hashCode ^ group.hashCode ^ subgroup.hashCode;


//-----------------convertion to json---------------------------------
 Map<String, dynamic> toJson() => {
  'videoUrl': videoUrl,
  'thumbnailUrl': thumbnailUrl,
  'title': title,
  'time': time,
  'category': category,
  'group': group,
  'subgroup': subgroup
 };

   VideoProperties.fromJson(Map<String, dynamic>json)
 : videoUrl = json['videoUrl'],
   thumbnailUrl = json['thumbnailUrl'],
   title = json['title'],
   time = json['time'],
   category = json['category'],
   group = json['group'],
   subgroup = json['subgroup'];
}