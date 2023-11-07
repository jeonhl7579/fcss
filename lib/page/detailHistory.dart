import 'dart:ffi';
import '../utils/api.dart' as api;
import 'package:flutter/material.dart';
import '../utils/team.dart' as team;
import '../page/detailTeam.dart' as detailTeam;

class detailHistory extends StatefulWidget {
  detailHistory({super.key,this.data});
  final data;

  @override
  State<detailHistory> createState() => _detailHistoryState();
}

class _detailHistoryState extends State<detailHistory> {
  var homeposition="";
  var awayposition="";
  var homeGoals=[];
  var awayGoals=[];

  checkHomePosition(){
    List? homePlayer=widget.data[0]["player"];
    List result=[];
    List df=[];
    List cdm=[];
    List cm=[];
    List cam=[];
    List fw=[];
    if(homePlayer!=null){
      for(int i=0; i<homePlayer.length; i++){
        if([1, 2, 3, 4, 5, 6, 7, 8].contains(homePlayer[i]["spPosition"])==true){
          df.add(0);
        }else if([9,10,11].contains(homePlayer[i]["spPosition"])==true){
          cdm.add(0);
        }else if([12, 13, 14, 15, 16].contains(homePlayer[i]["spPosition"])==true){
          cm.add(0);
        }else if([17, 18, 19].contains(homePlayer[i]["spPosition"])==true){
          cam.add(0);
        }else if([20,21, 22, 23,24,25,26,27].contains(homePlayer[i]["spPosition"])==true){
          fw.add(0);
        }
      }
      if(df.length>0) result.add(df.length);
      if(cdm.length>0) result.add(cdm.length);
      if(cm.length>0) result.add(cm.length);
      if(cam.length>0) result.add(cam.length);
      if(fw.length>0) result.add(fw.length);
    }
    setState(() {
      homeposition=result.join("-");
    });
  }
  checkAwayPosition(){
    List? awayPlayer=widget.data[1]["player"];
    List result=[];
    List df=[];
    List cdm=[];
    List cm=[];
    List cam=[];
    List fw=[];
    if(awayPlayer!=null){
      for(int i=0; i<awayPlayer.length; i++){
        if([1, 2, 3, 4, 5, 6, 7, 8].contains(awayPlayer[i]["spPosition"])==true){
          df.add(0);
        }else if([9,10,11].contains(awayPlayer[i]["spPosition"])==true){
          cdm.add(0);
        }else if([12, 13, 14, 15, 16].contains(awayPlayer[i]["spPosition"])==true){
          cm.add(0);
        }else if([17, 18, 19].contains(awayPlayer[i]["spPosition"])==true){
          cam.add(0);
        }else if([20,21, 22, 23,24,25,26,27].contains(awayPlayer[i]["spPosition"])==true){
          fw.add(0);
        }
      }
      if(df.length>0) result.add(df.length);
      if(cdm.length>0) result.add(cdm.length);
      if(cm.length>0) result.add(cm.length);
      if(cam.length>0) result.add(cam.length);
      if(fw.length>0) result.add(fw.length);
    }
    setState(() {
      awayposition=result.join("-");
    });
  }
  setAwayGoals() async {
    //print(widget.data[0]["shootDetail"]);
    var spStore=widget.data[1]["shootDetail"];
    List<List> newBox=[];
    for(var i in spStore){
      if(i["result"]==3){
        var name=await api.getSpid(i["spId"]);
        // 어시스트 받은 골이면
        if(i['assist']==true){
          var assitName=await api.getSpid(i["assistSpId"]);
          newBox.add([name,assitName]);
        }else{
          newBox.add([name,""]);
        }
      }
    }
    print(newBox);
    setState(() {
      awayGoals=[...newBox];
    });
  }
  setHomeGoals() async {
    //print(widget.data[0]["shootDetail"]);
    var spStore=widget.data[0]["shootDetail"];
    List<List> newBox=[];
    for(var i in spStore){
      if(i["result"]==3){
        var name=await api.getSpid(i["spId"]);
        // 어시스트 받은 골이면
        if(i['assist']==true){
          var assitName=await api.getSpid(i["assistSpId"]);
          newBox.add([name,assitName]);
        }else{
          newBox.add([name,""]);
        }
      }
    }
    print(newBox);
    setState(() {
      homeGoals=[...newBox];
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setHomeGoals();
    setAwayGoals();
    checkHomePosition();
    checkAwayPosition();

  }
  @override
  Widget build(BuildContext context) {
    var deviceWidth=MediaQuery.of(context).size.width;
    var deviceHeight=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height:deviceHeight*0.07),
          Container(width:deviceWidth,height: deviceHeight*0.1,

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: deviceWidth*0.25,
                  height:deviceHeight*0.17,

                  child:Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(width:deviceWidth*0.25,height:deviceHeight*0.03
                        ,child: Center(child: Text("Home",style: TextStyle(color:Colors.white70,fontSize: 25),),),
                      ),
                      SizedBox(height:deviceHeight*0.03),
                      SizedBox(width:deviceWidth*0.25,height: deviceHeight*0.03,
                          child: Center(
                            child:
                            Text(widget.data[0]["nickname"],
                              style: TextStyle(color:Colors.white70,fontSize: widget.data[0]["nickname"].length>6?13:18
                                ,),
                            ),
                          )
                      )
                    ],
                  )
                ),
                Container(
                  width: deviceWidth*0.25,
                  height:deviceHeight*0.17,

                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width:deviceWidth*0.25,height:deviceHeight*0.03
                          ,child: Center(child: Text("Away",style: TextStyle(color:Colors.white70,fontSize: 25),),),
                        ),
                        SizedBox(height:deviceHeight*0.03),
                        SizedBox(width:deviceWidth*0.25,height: deviceHeight*0.03,
                          child: Center(
                            child:
                            Text(widget.data[1]["nickname"],
                                style: TextStyle(color:Colors.white70,fontSize: widget.data[1]["nickname"].length>6?15:18
                              ,),
                            ),
                          )
                        )
                      ],
                    )
                ),
              ],
            )
          ),
          SizedBox(height: deviceHeight*0.03,),
          Container(width: deviceWidth,height: deviceHeight*0.38,
            child: Stack(
              children: [
                Align(alignment: Alignment(-0.7,0),
                  child: Container(width: deviceWidth*0.25,height: deviceHeight*0.38,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(widget.data[0]["matchDetail"]["matchEndType"]==0?
                          widget.data[0]["matchDetail"]["matchResult"]:"몰수${widget.data[0]["matchDetail"]["matchResult"]}",style: TextStyle(color: Colors.white),),
                          Text(widget.data[0]["shoot"]["goalTotalDisplay"].toString(),style: TextStyle(color: Colors.white),),
                          Text(widget.data[0]["matchDetail"]["controller"]=="keyboard"?"키보드":"게임패드",style: TextStyle(color: Colors.white),),
                          Text(widget.data[0]["matchDetail"]["possession"].toStringAsFixed(1),style: TextStyle(color: Colors.white),),
                          Text(widget.data[0]["matchDetail"]["averageRating"].toStringAsFixed(2),style: TextStyle(color: Colors.white),),
                          Container(width:200,height: deviceHeight*0.0215,
                            margin: EdgeInsets.zero,
                            child: TextButton(style:TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                            ),onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>detailTeam.teamInfo(data:widget.data[0]["player"])));
                            }, child: Center(child: Text("보기",style: TextStyle(color: Colors.white),),)),
                          ),
                          Text(homeposition,style:TextStyle(color:Colors.white)),
                        ],
                      )
                  ),
                ),
                Align(alignment: Alignment(0,0),
                  child: Container(width: deviceWidth*0.25,height: deviceHeight*0.38,
                    decoration: BoxDecoration(color: Colors.white12,borderRadius: BorderRadius.circular(5)),
                    child:Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("매치 결과",style: TextStyle(color: Colors.white70),),
                        Text("점수",style: TextStyle(color: Colors.white70),),
                        Text("컨트롤러",style: TextStyle(color: Colors.white70),),
                        Text("점유율",style: TextStyle(color: Colors.white70),),
                        Text("경기 평점",style: TextStyle(color: Colors.white70),),
                        Text("스쿼드",style: TextStyle(color:Colors.white70),),
                        Text("포메이션",style:TextStyle(color:Colors.white70))
                      ],
                    )
                  ),
                ),
                Align(alignment: Alignment(0.7,0),
                  child: Container(width: deviceWidth*0.25,height: deviceHeight*0.38,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(widget.data[1]["matchDetail"]["matchEndType"]==0?
                          widget.data[1]["matchDetail"]["matchResult"]:"몰수${widget.data[1]["matchDetail"]["matchResult"]}",style: TextStyle(color: Colors.white),),
                          Text(widget.data[1]["shoot"]["goalTotalDisplay"].toString(),style: TextStyle(color: Colors.white),),
                          Text(widget.data[1]["matchDetail"]["controller"]=="keyboard"?"키보드":"게임패드",style: TextStyle(color: Colors.white),),
                          Text(widget.data[1]["matchDetail"]["possession"].toStringAsFixed(1),style: TextStyle(color: Colors.white),),
                          Text(widget.data[1]["matchDetail"]["averageRating"].toStringAsFixed(2),style: TextStyle(color: Colors.white),),
                          Container(width:200,height: deviceHeight*0.0215,
                            margin: EdgeInsets.zero,
                            child: TextButton(style:TextButton.styleFrom(
                              padding: EdgeInsets.zero,

                            ),onPressed: (){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>detailTeam.teamInfo(data:widget.data[1]["player"])));
                            }, child: Center(child: Text("보기",style: TextStyle(color: Colors.white),),)),
                          ),
                          Text(awayposition,style:TextStyle(color:Colors.white)),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
          Container(
            width:deviceWidth,height: deviceHeight*0.05,
          ),
          Container(
            height: deviceHeight*0.22,

            child: Stack(
              children: [
                // 홈 득점자
                Align(alignment: Alignment(-0.71,0),
                  child: Container(
                    width: deviceWidth*0.31,height: deviceHeight*0.18,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        itemCount: homeGoals.length,
                        itemBuilder: (context,idx){
                          if(homeGoals[idx][1] == "") return Align(alignment:Alignment.centerLeft,child: Text(homeGoals[idx][0],style: TextStyle(color:Colors.white),));
                          else return Column(
                            children: [
                              Align(alignment:Alignment.centerLeft,child: Text(homeGoals[idx][0],style: TextStyle(color:Colors.white),)),
                              Container(
                                padding:const EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Align(alignment: Alignment.centerLeft,child: Text(homeGoals[idx][1],style: TextStyle(color:Colors.white70,fontSize:10),),),
                              )
                            ],
                          );
                        },
                    ),
                  ),
                ),
                Align(alignment: Alignment(0,-1.4),
                  child: Container(
                    width: deviceWidth*0.2,height: deviceHeight*0.05,

                    child: Center(child: Text("득점자",style: TextStyle(color: Colors.white70,fontSize: 18),),),
                  ),
                ),
                // 어웨이 득점자
                Align(alignment: Alignment(0.7,0),
                  child: Container(
                    width: deviceWidth*0.3,height: deviceHeight*0.18,
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                    ),
                    child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      itemCount: awayGoals.length,
                      itemBuilder: (context,idx){
                        if(awayGoals[idx][1] == "") return Align(alignment:Alignment.centerRight,child: Text(awayGoals[idx][0],style: TextStyle(color:Colors.white),));
                        else return Column(
                          children: [
                            Align(alignment:Alignment.centerRight,child: Text(awayGoals[idx][0],style: TextStyle(color:Colors.white),)),
                            Container(
                              padding:const EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Align(alignment: Alignment.centerRight,child: Text(awayGoals[idx][1],style: TextStyle(color:Colors.white.withOpacity(0.9),fontSize:10),),),
                            )
                          ],
                        );

                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
