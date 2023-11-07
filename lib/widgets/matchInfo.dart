import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import '../page/detailHistory.dart' as detail;

class MatchInfo extends StatefulWidget {
  MatchInfo({super.key,this.data,this.nickname});
  final data;
  final nickname;

  @override
  State<MatchInfo> createState() => _MatchInfoState();
}

class _MatchInfoState extends State<MatchInfo> {
  var matchInfo={};
  var matchDetail={};
  var vic="";
  Color bg=Colors.white;
  Color ic=Colors.black;
  var lastmatch="";

  setColor(Color value1,Color value2){
    setState(() {
      bg=value1;
      ic=value2;
    });
  }
  setDate(value){
    setState((){
      lastmatch=value;
    });
  }
  // 좌측의 승패를 나타내는 함수
  setMatchvl(){
    // 홈 유저가 검색한 유저일떄
    if(widget.data["matchInfo"][0]["nickname"]==widget.nickname){
      // 정상적으로 끝난 매치
      if(widget.data['matchInfo'][0]['matchDetail']["matchEndType"]==0){
        setState(() {vic=widget.data['matchInfo'][0]['matchDetail']["matchResult"];});
        if(vic=="승"){
          setColor(Color.fromRGBO(255, 255, 255, 0.8),Color.fromRGBO(0, 0, 0, 0.8));
        }else if(vic=="패"){
          setColor(Color.fromRGBO(0, 0, 0, 0.8),Color.fromRGBO(255, 255, 255, 0.8));
        }else {
          setColor(Colors.transparent,Color.fromRGBO(255, 255, 255, 0.8));
        }
      }else if(widget.data['matchInfo'][0]['matchDetail']["matchEndType"]==1){
        // 몰수 승일때
        setState(() {vic="몰수승";});
        setColor(Color.fromRGBO(255, 255, 255, 0.8),Color.fromRGBO(0, 0, 0, 0.8));
      }else{
        setState(() {vic="몰수패";});
        setColor(Color.fromRGBO(0, 0, 0, 0.8),Color.fromRGBO(255, 255, 255, 0.8));
      }
    }else{
      if(widget.data['matchInfo'][1]['matchDetail']["matchEndType"]==0){
        setState(() {vic=widget.data['matchInfo'][1]['matchDetail']["matchResult"];});
        if(vic=="승"){
          setColor(Color.fromRGBO(255, 255, 255, 0.8),Color.fromRGBO(0, 0, 0, 0.8));
        }else if(vic=="패"){
          setColor(Color.fromRGBO(0, 0, 0, 0.8),Color.fromRGBO(255, 255, 255, 0.8));
        }else {
          setColor(Colors.transparent,Color.fromRGBO(255, 255, 255, 0.8));
        }
      }else if(widget.data['matchInfo'][1]['matchDetail']["matchEndType"]==1){
        // 몰수 승일때
        setState(() {vic="몰수승";});
        setColor(Color.fromRGBO(255, 255, 255, 0.8),Color.fromRGBO(0, 0, 0, 0.8));
      }else{
        setState(() {vic="몰수패";});
        setColor(Color.fromRGBO(0, 0, 0, 0.8),Color.fromRGBO(255, 255, 255, 0.8));
      }
    }

  }
  getSearchUser() async {
    var storage = await SharedPreferences.getInstance();
    var user=storage.getString("SearchUser");
    if(user!=null){
      print("유저 정보: ${json.decode(user)}");
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 데이터 잘 넘어왔는지 확인
    setMatchvl();
    // 반복문 돌려서 match
    var nowTime=DateTime.now();
    var matchTime=DateTime.parse(widget.data["matchDate"]);
    print("$nowTime $matchTime");
    var lastTime=nowTime.difference(matchTime);
    var lastDay=lastTime.inDays.toString();
    if(lastDay=="0"){
      print(lastTime.inHours.toString());
      setDate("${lastTime.inHours.toString()} 시간 전");
    }else{
      setDate("${lastDay} 일 전");
    }


    //print(widget.data['matchInfo'][0]);
    //print(widget.data['matchInfo'].runtimeType);
  }

  @override
  Widget build(BuildContext context) {
    var widgetWidth=MediaQuery.of(context).size.width;
    var widgetHeight=MediaQuery.of(context).size.height;
    return Container(
      width: widgetWidth,
      height:80,
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color:Colors.grey,
                width:1,
              )
          )
      ),
      child: Row(
        children: [
          Container(
            width: widgetWidth*0.1,
            height: 80,
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
            decoration: BoxDecoration(
              color: bg,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                  vic,
                //widget.data['matchInfo'][0]['matchDetail']["matchResult"]
                style: TextStyle(color:  ic,fontSize: vic=="몰수승" || vic=="몰수패" ?12:17,fontWeight: FontWeight.w500),),),
          ),
          Container(
            width:widgetWidth*0.8,
            height:80,
            child: Stack(
              children: [
                Align(alignment: Alignment(0.0,0.44),
                  child: Container(
                    width: widgetWidth*0.7,
                    height: 30,
                    decoration: BoxDecoration(border: Border.all(color: Colors.transparent,)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.data["matchInfo"][0]["nickname"],style: TextStyle(color: Colors.white,fontSize: 20.0-widget.data["matchInfo"][0]["nickname"]?.length*1),),
                        Text(widget.data["matchInfo"][1]["nickname"],style: TextStyle(color: Colors.white,fontSize: 20.0-widget.data["matchInfo"][1]["nickname"]?.length*1),),
                      ],
                    ),
                  ),
                ),
                Align(alignment: Alignment(0.0,-0.7),
                  child: Container(
                    width: widgetWidth*0.2,
                    height: widgetHeight*0.05,
                    decoration: BoxDecoration(border: Border.all(color: Colors.transparent,)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.data["matchInfo"][0]["shoot"]["goalTotalDisplay"].toString(),style: TextStyle(color: Colors.white,fontSize: 25),),
                        Text(widget.data["matchInfo"][1]["shoot"]["goalTotalDisplay"].toString(),style: TextStyle(color: Colors.white,fontSize: 25),),
                      ],
                    ),
                  ),
                ),
                Align(alignment: Alignment(0.0,-0.6),
                  child: Text(":",style: TextStyle(color: Colors.white,fontSize: 25),)
                ),
                Align(alignment: Alignment(0.0,0.6),
                    child: Text(lastmatch,style: TextStyle(color: Colors.white,fontSize: 15),)
                ),
              ],
            ),
          ),
          Container(
            width:widgetWidth*0.1,
            height: 80,
            decoration:BoxDecoration(
              color:bg,
            ),
            child: Align(
              alignment: Alignment.center,
              child: IconButton(
                onPressed: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context)=>detail.detailHistory(data:widget.data["matchInfo"])));
                },
                icon: Icon(Icons.navigate_next,color: ic,),
              ),),

          )
        ],
      ),
    );
  }
}
