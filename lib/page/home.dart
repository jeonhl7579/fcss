import 'package:fcselect/model/yplaylist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'search.dart' as search;
import '../utils/api.dart' as api;
import 'package:shared_preferences/shared_preferences.dart';
import './videoPlay.dart';
import './history.dart' as history;


class HomeSelect extends StatefulWidget {
  HomeSelect({super.key});

  @override
  State<HomeSelect> createState() => _HomeSelectState();
}

class _HomeSelectState extends State<HomeSelect> {
  int widgetState=0;


  widgetUpdate(){
    setState(() {
      widgetState+=1;
    });
  }
  deleteBookmark(int idx) async {
    final SharedPreferences tmp=await SharedPreferences.getInstance();

    List<String>? dtmp=tmp.getStringList("Bookmark");
    List<String>? rtmp=dtmp;

    rtmp?.removeAt(idx);
    // print(dtmp);
    // print(rtmp);
    if(rtmp != null) tmp.setStringList("Bookmark", rtmp);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FocusNode textFocus=FocusNode();
    var deviceWidth=MediaQuery.of(context).size.width;
    var deviceHeight=MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("FCSS"),
      ),
      body: Container(
          width:deviceWidth,
          height: deviceHeight*0.99,
          child: FutureBuilder(
            future: api.getYoutubeList(),
            builder: (context,snapshot){
              late YoutubeItems pList;
              late List<Items> store;
              late List<String> Bookmark;
              if(snapshot.hasData==false || snapshot.connectionState==ConnectionState.waiting) {
                return SpinKitRotatingCircle(color: Colors.white,size: 50,);
              }else{
                if(snapshot.data != null){
                  Bookmark=snapshot.data[0]!;
                  pList=snapshot.data[1]!;
                  store=pList.items;
                }
                print(store);
              }

              return Column(
                children: [
                  SizedBox(height: deviceHeight*0.03,),
                  Padding(padding: EdgeInsets.fromLTRB(20, 7, 20, 7),
                    child: TextField(
                      readOnly: true,
                      onTap: (){
                        FocusManager.instance.primaryFocus?.unfocus();
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>search.SearchPage(update:widgetUpdate)));
                      },
                      decoration: InputDecoration(
                          label : RichText(text: TextSpan(
                              children: [
                                WidgetSpan(child:Icon(Icons.search,color: Color.fromRGBO(255, 255, 255, 0.3),)),
                                TextSpan(text:" 구단주명 검색",style: TextStyle(fontSize:20,color: Color.fromRGBO(255, 255, 255, 0.3))),
                              ]
                          ),)
                      ),
                    ),
                  ),
                  SizedBox(height: deviceHeight*0.03,),
                  Container(
                    width: deviceWidth,
                    height: deviceHeight*0.2,
                    decoration: BoxDecoration(
                        color:Colors.white.withOpacity(0.03)
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: deviceWidth,
                          height: deviceHeight*0.07,

                          padding: EdgeInsets.fromLTRB(20, 25, 20, 10),
                          child: Text("즐겨찾기한 구단주",style: TextStyle(color: Colors.white.withOpacity(0.95),fontWeight: FontWeight.bold,fontSize: 22),),
                        ),

                        Flexible(
                          fit: FlexFit.tight,
                          child: Container(

                            child: ListView.builder(
                              padding: EdgeInsets.fromLTRB(20, 3, 20, 0),
                              itemCount: Bookmark.length,
                              itemBuilder: (context,idx){
                                return Container(
                                  width: deviceWidth,
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(width: deviceWidth*0.8,
                                          child: TextButton(
                                              onPressed: () async {
                                                var result=await api.getUserInfo(Bookmark[idx]);
                                                Navigator.push(context,MaterialPageRoute(builder: (context)=>history.HistorySearch(data:result,nickname:Bookmark[idx])));
                                              },
                                              child: Align(alignment: Alignment.centerLeft,
                                                child: Text("${Bookmark[idx]}",style: TextStyle(color: Colors.white,fontSize: 18),),
                                              )
                                          )
                                      ),
                                      Expanded(
                                        child: IconButton(
                                            onPressed: (){
                                              deleteBookmark(idx);
                                            },
                                            icon: Icon(Icons.close,color: Colors.white,size: 25,)
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: deviceHeight*0.03,),

                  Container(
                      width: deviceWidth,
                      height: deviceHeight*0.26,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.03),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: deviceWidth,
                            padding: EdgeInsets.fromLTRB(20, 25, 0, 10),
                            child: Text("네로 하프타임",style: TextStyle(color: Colors.white.withOpacity(0.95),fontSize: 25,fontWeight: FontWeight.bold),),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: [
                                  SizedBox(
                                    width: deviceWidth, height: deviceHeight*0.159,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: store.length,
                                      itemBuilder: (context,idx){
                                        return GestureDetector(
                                          onTap: (){
                                            print(store[idx].snippet.resourceId);
                                            Navigator.push(context,MaterialPageRoute(builder: (context)=>videoPlay(video:store[idx].snippet.resourceId["videoId"])));
                                          },
                                          child: Container(
                                              margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                              width: 120,
                                              height: 135,

                                              child: Column(
                                                children: [
                                                  SizedBox(width: 120,height: 90,child: Image.network(store[idx].snippet.thumbnails["default"]["url"],fit: BoxFit.fill,),),
                                                  SizedBox(width: 120,height: 10,),
                                                  SizedBox(width:120,height: 40,child: Text(store[idx].snippet.title,style: TextStyle(color: Colors.white),maxLines: 2,),)
                                                ],
                                              )
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ]
                            ),
                          )
                        ],
                      )
                  ),


                ],
              );
            },
          )
      ),
    );

  }

}
