import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import '../model/yplaylist.dart' as yplay;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


getUserInfo(name) async {
  var url=Uri.parse('https://public.api.nexon.com/openapi/fconline/v1.0/users?nickname=${name}');

  // var result=await http.get(url,headers: {'Authorization':api.nexon_api_key});
  var result=await http.get(url,headers: {'Authorization':dotenv.env["nexon_api_key"]!});
  var data=jsonDecode(result.body);
  //print(data["accessId"]);
  return data;
}

getUserRank(accessid) async {
  var url=Uri.parse('https://public.api.nexon.com/openapi/fconline/v1.0/users/${accessid}/maxdivision');
  var result=await http.get(url,headers: {'Authorization':dotenv.env["nexon_api_key"]!});
  var data=jsonDecode(result.body);
  return data;
}

getRankMatch(accessid,int match) async {
  // 공식 경기
  //var matchInfo=50;
  // 불러올 매치 수
  var limit=30;
  var url=Uri.parse("https://public.api.nexon.com/openapi/fconline/v1.0/users/${accessid}/matches?matchtype=${match}&limit=${limit}");
  var result=await http.get(url,headers: {'Authorization':dotenv.env["nexon_api_key"]!});
  var data=jsonDecode(result.body);
  return data;
}
getRankMatch2(accessid,int match) async {
  // 공식 경기
  //var matchInfo=50;
  // 불러올 매치 수
  var limit=30;
  var url=Uri.parse("https://public.api.nexon.com/openapi/fconline/v1.0/users/${accessid}/matches?matchtype=${match}&limit=${limit}");
  var result=await http.get(url,headers: {'Authorization':dotenv.env["nexon_api_key"]!});
  return result.body;
}
getMatchDetail(matchId) async {
  // matchId=매치 식별자
  var url=Uri.parse('https://public.api.nexon.com/openapi/fconline/v1.0/matches/${matchId}');
  var result=await http.get(url,headers: {'Authorization':dotenv.env["nexon_api_key"]!});
  Map<String,dynamic> data=jsonDecode(result.body);

  return data;
}


// 선수 데이터 저장하는 함수
setSpid() async {
  // 선수 데이터 가져오기
  var url=Uri.parse('https://static.api.nexon.co.kr/fconline/latest/spid.json');
  var result=await http.get(url,headers: {'Authorization':dotenv.env["nexon_api_key"]!});
  List<dynamic> data=jsonDecode(utf8.decode(result.bodyBytes));

  // json화 된 데이터 data
  String jsonString=jsonEncode(data);

  final directory = await getApplicationDocumentsDirectory();
  final file = await File('${directory.path}/spid.json');
  // 파일이 있다면
  file.exists().then((exists){
    if(!exists){
      file.writeAsString(jsonString);
    }
  });


  // 파일 나중에는 다시 json화 해서 사용해야함
}
// Future<List?> _future(int match) async {
//   List<dynamic> data=await api.getRankMatch(widget.data['accessId'],match); // 5초를 강제적으로 딜레이 시킨다.
//   List store=[];
//   for(var match in data){
//     var detailMatch=await api.getMatchDetail(match);
//     store=[...store,detailMatch];
//   }
//
//   return store;
//   //return data; // 5초 후 '짜잔!' 리턴
// }
// 유튜브의 재생목록을 불러오는 함수
// 즐겨찾기 목록도
Future getYoutubeList() async {
  final SharedPreferences box=await SharedPreferences.getInstance();
  final List<String>? items=box.getStringList("Bookmark");
  // listId=PLrdjirZluQW4qqsH1_XiU6GvxqtDk1kHW
  Uri url=Uri.parse("https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=5&playlistId=PLrdjirZluQW4qqsH1_XiU6GvxqtDk1kHW&key=${dotenv.env["youtube_api_key"]!}");
  var response=await http.get(url);
  print(items);
  if(response.statusCode==200){
     Map<String,dynamic> datas=jsonDecode(response.body);
     var youtubeRes=yplay.YoutubeItems.fromJson(datas);

     //print(youtubeRes.items[0].snippet.resourceId["videoId"]);
     return [items,youtubeRes];
  }
  // 통신 실패시
  return [items,null];
}
getSpid(spId) async {
  final directory = await getApplicationDocumentsDirectory();
  final file=await File('${directory.path}/spid.json');

  final contents = await file.readAsString();

  //print(jsonDecode(contents));
  final spStore=await jsonDecode(contents);
  for(var i=0; i<spStore.length; i++){
    if(spStore[i]["id"]==spId){
      return spStore[i]["name"];
    }
  }
}

getSquadSpId(List datas) async {
  final directory = await getApplicationDocumentsDirectory();
  final file=await File('${directory.path}/spid.json');

  final contents = await file.readAsString();
  final spStore=await jsonDecode(contents);

  List store=[];
  for (var i=0; i<datas.length; i++){
    for (var j=0; j<spStore.length; j++){
      if(datas[i][0] == spStore[j]["id"]){
        var tmp=[spStore[j]["name"],datas[i][1],datas[i][2],datas[i][0]];
        store.add(tmp);
        break;
      }
    }
  }

  return jsonEncode(store);
}

