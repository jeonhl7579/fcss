import 'package:flutter/material.dart';
import '../utils/api.dart' as api;
import 'dart:convert';
class teamInfo extends StatefulWidget {
  teamInfo({super.key,this.data});
  final data;

  @override
  State<teamInfo> createState() => _teamInfoState();
}

class _teamInfoState extends State<teamInfo> {
  List position=List.generate(29, (_)=>null);
  List rePlayer=[];

  setExtra(List data){
    setState((){
      rePlayer=[...data];
    });
  }
  setPosition(List data){
    List newPosition=[...position];

    for(var i=0; i<data.length; i++){
      //(data[i]);
      newPosition[data[i][1]]=[data[i][0],data[i][2],data[i][3]];
    }
    print(newPosition);
    setState(() {
      position=newPosition;
    });
  }
  initPosititon() async{
    List store=[];
    List extra=[];
    for (var i=0; i<widget.data?.length; i++){
      print("${widget.data[i]["spId"]} ${widget.data[i]["spPosition"]} ${widget.data[i]["status"]["spRating"]}");
      if(widget.data[i]["spPosition"] != 28){
        store.add([widget.data[i]["spId"],widget.data[i]["spPosition"],widget.data[i]["status"]["spRating"]]);
      }else{
        extra.add([widget.data[i]["spId"],widget.data[i]["spPosition"],widget.data[i]["status"]["spRating"]]);
      }
    }
    var tmp=await api.getSquadSpId(store);
    var tmp2=await api.getSquadSpId(extra);
    var box=jsonDecode(tmp);
    var box2=jsonDecode(tmp2);

    // for(var i=0; i<box.length; i++){
    //   print(i);
    //   print(tmp[i]);
    // }

    //print(tmp);
    setPosition(box);
    setExtra(box2);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //print(position);
    initPosititon();
  }
  @override
  Widget build(BuildContext context) {
    var deviceWidth=MediaQuery.of(context).size.width;
    var deviceHeight=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        width: deviceWidth,
        height:deviceHeight,

        child: Column(
          children: [
            SizedBox(height: deviceHeight*0.03,),
            Container(width:deviceWidth,height :deviceHeight*0.65,
              child: Stack(
                children: [
                  Align(alignment: Alignment(0,0),child: Image.asset('assets/soccer.png',fit: BoxFit.fill,),),
                  // ST
                  Align(alignment:Alignment(0,-1),child: Container(
                    width: position[25]!=null?position[25][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[25] != null?position[25][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[25] != null?position[25][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // LS
                  Align(alignment:Alignment(-0.4,-0.85),child: Container(
                    width: position[26]!=null?position[26][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[26] != null?position[26][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[26] != null?position[26][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // RS
                  Align(alignment:Alignment(0.4,-0.85),child: Container(
                    width: position[24]!=null?position[24][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[24] != null?position[24][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[24] != null?position[24][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // CF
                  Align(alignment:Alignment(0,-0.52),child: Container(
                    width: position[21]!=null?position[21][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[21] != null?position[21][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[21] != null?position[21][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )

                  ),),
                  // LF
                  Align(alignment:Alignment(-0.4,-0.65),child: Container(
                    width: position[22]!=null?position[22][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[22] != null?position[22][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[22] != null?position[22][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // Rf
                  Align(alignment:Alignment(0.4,-0.65),child: Container(
                    width: position[20]!=null?position[20][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[20] != null?position[20][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[20] != null?position[20][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // LW
                  Align(alignment:Alignment(-0.85,-0.75),child: Container(
                      width: position[27]!=null?position[27][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[27] != null?position[27][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[27] != null?position[27][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // RW
                  Align(alignment:Alignment(0.85,-0.75),child: Container(
                      width: position[23]!=null?position[23][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[23] != null?position[23][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[23] != null?position[23][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // CAM
                  Align(alignment:Alignment(0,-0.4),child: Container(
                      width: position[18]!=null?position[18][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[18] != null?position[18][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[18] != null?position[18][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // LAM
                  Align(alignment:Alignment(-0.6,-0.38),child: Container(
                    width: position[19]!=null?position[19][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[19] != null?position[19][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[19] != null?position[19][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // RAM
                  Align(alignment:Alignment(0.6,-0.38),child: Container(
                    width: position[17]!=null?position[17][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[17] != null?position[17][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[17] != null?position[17][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // LM
                  Align(alignment:Alignment(-0.9,-0.15),child: Container(
                    width: position[16]!=null?position[16][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[16] != null?position[16][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[16] != null?position[16][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // RM
                  Align(alignment:Alignment(0.9,-0.15),child: Container(
                    width: position[12]!=null?position[12][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[12] != null?position[12][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[12] != null?position[12][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // LCM
                  Align(alignment:Alignment(-0.65,0.05),child: Container(
                    width: position[15]!=null?position[15][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[15] != null?position[15][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[15] != null?position[15][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // RCM
                  Align(alignment:Alignment(0.65,0.05),child: Container(
                    width: position[13]!=null?position[13][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[13] != null?position[13][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[13] != null?position[13][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // CM
                  Align(alignment:Alignment(0,0.15),child: Container(
                    width: position[14]!=null?position[14][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[14] != null?position[14][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[14] != null?position[14][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  //LDM
                  Align(alignment:Alignment(-0.6,0.3),child: Container(
                      width: position[11]!=null?position[11][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[11] != null?position[11][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[11] != null?position[11][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // RDM
                  Align(alignment:Alignment(0.6,0.3),child: Container(
                      width: position[9]!=null?position[9][0].length.toDouble()*16:120,height: 40,

                    child: Stack(
                      children: [
                        Align(alignment: Alignment(0,-0.5),child: Text(position[9] != null?position[9][0]:"",style: TextStyle(
                            color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                        Align(alignment: Alignment(0,0.9),child: Text(position[9] != null?position[9][1].toString():"",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                      ],
                    )
                  ),),
                  // CDM
                  Align(alignment:Alignment(0,0.4),child: Container(
                    width: position[10]!=null?position[10][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[10] != null?position[10][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[10] != null?position[10][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // SW
                  Align(alignment:Alignment(0,0.6),child: Container(
                    width: position[1]!=null?position[1][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[1] != null?position[1][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[1] != null?position[1][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // CB
                  Align(alignment:Alignment(0,0.8),child: Container(
                    width: position[5]!=null?position[5][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[5] != null?position[5][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[5] != null?position[5][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // LCB
                  Align(alignment:Alignment(-0.5,0.85),child: Container(
                      width: position[6]!=null?position[6][0].length.toDouble()*16:120,height: 40,
                    child: Stack(
                      children: [
                        Align(alignment: Alignment(0,-0.5),child: Text(position[6] != null?position[6][0]:"",style: TextStyle(
                            color: Colors.black87,fontFamily: "PretendardMedium",fontSize: 16),),),
                        Align(alignment: Alignment(0,0.9),child: Text(position[6] != null?position[6][1].toString():"",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                      ],
                    )
                  ),),
                  // RCB
                  Align(alignment:Alignment(0.5,0.85),child: Container(
                      width: position[4]!=null?position[4][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[4] != null?position[4][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[4] != null?position[4][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // LWB
                  Align(alignment:Alignment(-0.9,0.55),child: Container(
                      width: position[8]!=null?position[8][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[8] != null?position[8][0]:"",overflow: TextOverflow.visible,style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: "PretendardMedium",),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[8] != null?position[8][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // RWB
                  Align(alignment:Alignment(0.8,0.55),child: Container(
                      width: position[2]!=null?position[2][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[2] != null?position[2][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[2] != null?position[2][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // LB
                  Align(alignment:Alignment(-0.8,0.7),child: Container(
                    width: position[7]!=null?position[7][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[7] != null?position[7][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[7] != null?position[7][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // RB
                  Align(alignment:Alignment(0.9,0.7),child: Container(
                    width: position[3]!=null?position[3][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[3] != null?position[3][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[3] != null?position[3][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                  // GK
                  Align(alignment:Alignment(0,1),child: Container(
                      width: position[0]!=null?position[0][0].length.toDouble()*16:120,height: 40,
                      child: Stack(
                        children: [
                          Align(alignment: Alignment(0,-0.5),child: Text(position[0] != null?position[0][0]:"",style: TextStyle(
                              color: Colors.black,fontFamily: "PretendardMedium",fontSize: 16),),),
                          Align(alignment: Alignment(0,0.9),child: Text(position[0] != null?position[0][1].toString():"",
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),),
                        ],
                      )
                  ),),
                ],
              ),
            ),
            SizedBox(height:deviceHeight*0.02),
            Flexible(
              fit: FlexFit.tight,
              child: Container(
                width: deviceWidth,
                margin: EdgeInsets.fromLTRB(10 , 0, 10, 0),
                child: ListView.builder(
                  itemCount: rePlayer.length+1,
                  itemBuilder: (context,idx){
                    if(idx==0){
                      return Container(

                        height: deviceHeight*0.035,
                        decoration: BoxDecoration(
                            color: Colors.white54,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          )
                        ),
                        child: Row(children: [
                          SizedBox(width: deviceWidth*0.2,child: Center(child: Text("포지션",style: TextStyle(color: Colors.black,fontSize: 15),),),),
                          SizedBox(width: deviceWidth*0.55,child: Center(child: Text("선수",style: TextStyle(color: Colors.black,fontSize: 15)),),),
                          Expanded(child: Center(child: Text("평점",style: TextStyle(color: Colors.black,fontSize: 15)),),)
                        ],),
                      );
                    }else{
                      return Container(
                        height: deviceHeight*0.028,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color:Colors.grey,width: 0.5)
                          ),
                        ),
                        child: Row(children: [
                          SizedBox(width: deviceWidth*0.2,child: Center(child: Text("교체",style: TextStyle(color: Colors.white),),),),
                          SizedBox(width: deviceWidth*0.55,child: Center(child: Text(rePlayer[idx-1][0],style: TextStyle(color: Colors.white)),),),
                          Expanded(child: Center(child: Text(rePlayer[idx-1][2].toString(),style: TextStyle(color: Colors.white)),),)

                        ],),
                      );
                    }
                  },
                )
              ),
            )
          ],
        )
      )
    );
  }
}
