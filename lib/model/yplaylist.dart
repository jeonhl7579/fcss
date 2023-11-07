import 'dart:convert';

class YoutubeItems{
  final String kind;
  final String etag;
  final String nextPageToken;
  final List<Items> items;

  YoutubeItems(
    this.kind,
    this.etag,
    this.nextPageToken,
    this.items
  );

  YoutubeItems.fromJson(Map<String,dynamic> json) :
    kind=json["kind"],
    etag=json["etag"],
    nextPageToken=json["nextPageToken"],
    items=listDatasFromJson(json["items"]);


  Map<String,dynamic> toJson()=>{
    'kind':kind,
    'etag':etag,
    'nextPageToken':nextPageToken,
    'items':items,
  };
}

class Items{
  final String kind;
  final String etag;
  final String id;
  DetailSnippet snippet;

  Items(this.kind,this.etag,this.id,this.snippet);

  Items.fromJson(Map<String,dynamic> json) :
        kind=json["kind"],
        etag=json["etag"],
        id=json["id"],
        snippet=DetailSnippet.fromJson(json["snippet"]);
}

class DetailSnippet{
  String publishedAt;
  String channelId;
  String title;
  String description;
  Map thumbnails;
  String channelTitle;
  String playlistId;
  int position;
  Map resourceId;
  String videoOwnerChannelTitle;
  String videoOwnerChannelId;

  DetailSnippet(
      {required this.publishedAt,
        required this.channelId,
        required this.title,
        required this.description,
        required this.thumbnails,
        required this.channelTitle,
        required this.playlistId,
        required this.position,
        required this.resourceId,
        required this.videoOwnerChannelTitle,
        required this.videoOwnerChannelId});

  DetailSnippet.fromJson(Map<String,dynamic> json) :
        publishedAt = json["publishedAt"],
        channelId = json["channelId"],
        title = json["title"],
        description = json["description"],
        thumbnails = json["thumbnails"],
        channelTitle = json["channelTitle"],
        playlistId = json["playlistId"],
        position = json["position"],
        resourceId = json["resourceId"],
        videoOwnerChannelTitle = json["videoOwnerChannelTitle"],
        videoOwnerChannelId = json["videoOwnerChannelId"];
}

List<Items> listDatasFromJson(var json){
  List<dynamic> parsedJson=json;

  List<Items> listdatas=[];
  for(int i=0; i<parsedJson.length; i++){
    listdatas.add(Items.fromJson(parsedJson[i]));
  }
  return listdatas;
}





// {
//     "page": 1,
//   "per_page": 3,
//   "total": 12,
//   "total_pages": 4,
//   "author":{
//     "first_name": "Ms R",
//     "last_name":"Reddy"
//   },
//   "data": [
//     {
//       "id": 1,
//       "first_name": "George",
//       "last_name": "Bluth",
//       "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/calebogden/128.jpg",
//       "images": [
//         {
//           "id" : 122,
//           "imageName": "377cjsahdh388.jpeg"
//         },
//         {
//           "id" : 152,
//           "imageName": "1743fsahdh388.jpeg"
//         }
//         ]
//     },
//     {
//         "id": 2,
//         "first_name": "Janet",
//         "last_name": "Weaver",
//         "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/josephstein/128.jpg",
//         "images": [
//           {
//             "id" : 122,
//             "imageName": "377cjsahdh388.jpeg"
//           },
//           {
//             "id" : 152,
//             "imageName": "1743fsahdh388.jpeg"
//           }
//         ]
//     },
//     {
//         "id": 3,
//         "first_name": "Emma",
//         "last_name": "Wong",
//         "avatar": "https://s3.amazonaws.com/uifaces/faces/twitter/olegpogodaev/128.jpg",
//         "images": [
//           {
//             "id" : 122,
//             "imageName": "377cjsahdh388.jpeg"
//           },
//           {
//             "id" : 152,
//             "imageName": "1743fsahdh388.jpeg"
//           }
//       ]
//     }
//   ]
// }