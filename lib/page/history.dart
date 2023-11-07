import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/api.dart' as api;
import '../widgets/matchList.dart' as match;
import '../widgets/matchInfo.dart' as lc;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/tier.dart' as tier;
import '../widgets/matchChart.dart' as chart;
import './search.dart' as search;
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'dart:io' show Platform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 전적 검색 화면
class HistorySearch extends StatefulWidget {
  HistorySearch({super.key,this.data,this.nickname,this.update});
  final data;
  final nickname;
  final update;
  @override
  State<HistorySearch> createState() => _HistorySearchState();
}

class _HistorySearchState extends State<HistorySearch> {
  // 유저 정보 저장할 map
  var userMap={};
  var userRank=[];
  var userMatches=[];
  //var userMatchDetails=[];
  var profile="";
  int backNumber=1;
  int menuState=0;
  int loadState=1;
  int iconState=0;
  late Future<List?> userMatchDetails;
  BannerAd? banner;
  // 테스트 키
  final String iOSTestId = 'ca-app-pub-3940256099942544/2934735716';
  final String androidTestId='ca-app-pub-3940256099942544/6300978111';
  // 로딩 상태

  Future<List?> _future(int match) async {
    List<dynamic> data=await api.getRankMatch(widget.data['accessId'],match); // 5초를 강제적으로 딜레이 시킨다.
    List store=[];
    for(var match in data){
      var detailMatch=await api.getMatchDetail(match);
      store=[...store,detailMatch];
    }

    return store;
    //return data; // 5초 후 '짜잔!' 리턴
  }

  // 즐겨찾기 되었는지 확인하는 함수
  checkBookmark(nickname) async {
    final store=await SharedPreferences.getInstance();

    List<String>? result=store.getStringList("Bookmark");

    if(result!=null){
      if(result.contains(nickname)==true){
        setState(() {
          iconState=1;
        });
      }else{
        setState(() {
          iconState=0;
        });
      }
    }


  }
  // 즐겨찾기 추가
  updateOnIcon(nick) async {
    final store=await SharedPreferences.getInstance();
    List<String>? result=store.getStringList("Bookmark");

    if(result!=null){
      result.add(nick);
      store.setStringList("Bookmark", <String>[...result]);
    }
    setState(() {
      iconState=1;
    });
  }
  // 즐겨찾기 제거
  updateDownIcon(nick) async {
    final store=await SharedPreferences.getInstance();
    List<String>? result=store.getStringList("Bookmark");
    if(result!=null){
      result.remove(nick);
      store.setStringList("Bookmark", <String>[...result]);
    }
    setState(() {
      iconState=0;
    });
  }
  setMatches(value){
    userMatchDetails=_future(value);
  }
  setLoadState(int value){
    setState(() {
      loadState=value;
    });
  }
  setProfile(value){
    setState(() {
      profile=value;
    });
  }
  setMenuState(value){
    setState(() {
      menuState=value;
    });
  }
  setUserMap(data){
    setState(() {
      userMap=data;
    });
  }

  // userMatches초기화
  initMatches(){
    setState(() {
      userMatches=[];
    });
  }

  getUserRank(accessId) async {
    var tmp=await api.getUserRank(accessId);
    setState(() {
      userRank=tmp;
    });
    for(var i in tier.division){
      if(i["divisionId"]==tmp[0]["division"]){
        setProfile(i["divisionImg"]);
        break;
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //setUsermatchDetail(50);
    // 전적 검색 배경화면 랜덤 생성
    backNumber=Random().nextInt(3)+1;
    checkBookmark(widget.nickname);

    if (widget.data != null){
      setUserMap(widget.data);
      getUserRank(widget.data["accessId"]);
    }else{
      // 데이터가 멀쩡히 넘어오지 않았을때
      print("전적 검색이 되지 않았습니다.");
    }
    userMatchDetails=_future(50);
    banner=BannerAd(
      size:AdSize.banner,
      // adUnitId: Platform.isAndroid ? dotenv.env["android_mob_id"]!:iOSTestId,
      adUnitId: Platform.isAndroid ? dotenv.env["android_mob_id"]!:iOSTestId,
      listener: BannerAdListener(
          onAdLoaded: (ad){
          }
      ),
      request: AdRequest(),
    )..load();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var deviceWidth=MediaQuery.of(context).size.width;
    var deviceHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            if(context.widget==search.SearchPage()){
              widget.update();
            }
            // 뒤로 가기
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: (){
              iconState==0? updateOnIcon(widget.nickname):updateDownIcon(widget.nickname);
            },
            icon: iconState==0?Icon(Icons.star_border,color: Colors.white,size: 30,weight: 1):
              Icon(Icons.star,color: Colors.white,size: 30,weight: 1),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: SizedBox(
        width:deviceWidth,
        height:deviceHeight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: deviceWidth,
                height: deviceHeight*0.33,
                child: Stack(
                  children: [
                    ShaderMask(
                      shaderCallback: (Rect bound){
                        return LinearGradient(
                            begin:Alignment.topCenter,
                            end:Alignment.bottomCenter,
                            colors: [Colors.white,Colors.transparent],
                            stops: [0.6,0.8]
                        ).createShader(bound);
                      },
                      blendMode: BlendMode.dstIn,
                      child: Image.asset('assets/background/back${backNumber}.png',
                        fit: BoxFit.cover,
                        width:deviceWidth,
                        height:deviceHeight*0.33,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: deviceWidth,
                        height: deviceHeight*0.15,
                        child: Row(
                          children: [
                            SizedBox(width: deviceWidth*0.3, height:70,
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                  Container(
                                    width:70, height:70, margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(251, 234, 255, 0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: profile!=""?Image.asset(profile,fit: BoxFit.fill,):null,
                                  )
                                    ,SizedBox(),
                                  ],
                                ),
                              )
                            ),
                            SizedBox(width:deviceWidth*0.7,height:50,
                              child: Row(
                                  children: [
                                    Text(userMap["nickname"],style: TextStyle(color: Colors.white,fontSize: 25)),

                                  ]
                                ),
                              )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
            ),
            // 전적 리스트
            Container(
              width: deviceWidth,
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: match.MatchList(change:setMenuState,init:initMatches,update:setMatches),
            ),
            SizedBox(height: 25),
            Flexible(
                fit:FlexFit.tight,
                child: FutureBuilder(
                  future: userMatchDetails,
                  builder: (BuildContext context, AsyncSnapshot<List?> snapshot){
                    if(snapshot.hasData==false || snapshot.connectionState==ConnectionState.waiting){
                      return Align(
                        alignment: Alignment(0,-0.1),
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(0, 201, 184, 1),
                          strokeWidth: 3,
                        ),
                      );
                      // return SpinKitWave(
                      //   color:Colors.white30,
                      //   size:50.0,
                      //   //duration:Duration(seconds: 2),
                      // );
                    }else{
                      List sl=[...snapshot.data!];
                      sl.insert(0,{});
                      //sl.add({});
                      int win=0;
                      int defeat=0;
                      int mu=0;
                      for(var i=1; i<sl.length; i++){
                        var hw=[sl[i]["matchInfo"][0]["nickname"],sl[i]["matchInfo"][1]["nickname"]].indexOf(widget.nickname);
                        sl[i]["matchInfo"][hw]["matchDetail"]["matchResult"]=="승"?win++:
                        sl[i]["matchInfo"][hw]["matchDetail"]["matchResult"]=="무"?mu++:defeat++;
                        //print(sl[i]["matchInfo"][hw]["matchDetail"]["matchResult"]);
                      }
                      //print("$win 승 $mu 무 $defeat 패");
                      return ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: sl.length,
                        itemBuilder: (context,idx) {
                          if(idx==0){
                            return chart.pieChart(data: [win,defeat,mu],);
                          }else{
                            return lc.MatchInfo(data:snapshot.data?[idx-1],nickname:widget.nickname);
                          }
                        },
                      );
                    }
                  },
                )
            ),
            Container(width: deviceWidth,height: 50,
              child: AdWidget(
                ad: banner!,
              ),
            )
          ],
        ),
      ),
    );
  }


}



