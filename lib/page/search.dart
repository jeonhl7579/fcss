import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import './history.dart' as history;
import '../utils/api.dart' as api;
import '../utils/error.dart' as ed;

class SearchPage extends StatefulWidget {
  SearchPage({super.key,this.update});
  var update;
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _controller=TextEditingController();
  var searchBox=[];
  var searchBookmark=[];
  int widgetState=0;
  widgetUpdate(){
    setState(() {
      widgetState+=1;
    });
  }
  // 최근 검색 데이터중 요소 삭제
  removeSearchItem(idx) async {
    var storage=await SharedPreferences.getInstance();

    List<String>? result=storage.getStringList("searched");
    List<String>? tmp=[];
    tmp=result;

    if(tmp != null){
      tmp.removeAt(idx);
      storage.setStringList("searched",<String>[...tmp]);
      setState(() {
        tmp!=null?searchBox=<String>[...tmp]:null;
      });
    }
    //

  }
  // 검색데이터 초기화
  removeSearchData() async{
    var storage=await SharedPreferences.getInstance();

    await storage.remove("searched");

    updateSearchBox();
  }
  //로컬에 저장 함수
  saveSearchData(name) async {
    var storage = await SharedPreferences.getInstance();
    var box=storage.getStringList("searched");

    if(box==null){
      // 로컬에 저장되어 있지 않는 경우,
      storage.setStringList("searched", <String>[name]);

    }else{
      if(box.contains(name)==false){
        storage.setStringList("searched",<String>[name,...box]);
      }
    }
    updateSearchBox();
  }

  getSaveSData() async {
    var storage = await SharedPreferences.getInstance();
    var result=storage.getStringList("searched");

    return result;
  }
  getBookmark() async{
    var storage=await SharedPreferences.getInstance();
    var result=storage.getStringList("Bookmark");

    return result;
  }

  _handleSubmitted(String text) async {
    //print(await getSaveSData());
    var response=await api.getUserInfo(text);
    // 존재하지 않은 구단주를 검색했을때
    if (response['accessId']==null){
      showDialog(context: context, builder: (context){
        return ed.ErrorDialog();
      });
    }else{
      // 존재하는 소환사명일때,
      saveSearchData(_controller.text);
      Navigator.push(context,MaterialPageRoute(builder: (context)=>history.HistorySearch(data:response,nickname:text,update: updateSearchBox,)));
    }
    _controller.clear();
  }
  updateSearchBox() async {
    // 검색 기록
    List tmp=await getSaveSData();
    // 즐겨찾기 기록
    List cmp=await getBookmark();

    if (tmp==null){
      setState(() {
        searchBox=[];
      });
      setState(() {
        searchBookmark=[];
      });
    }else{
      // 검색 기록이 있다면
      List result=[];
      for(var i=0; i<tmp.length; i++){
        // 즐겨찾기에 속해있다면
        if(cmp.contains(tmp[i])==true){
          result.add(1);
        }else{
          result.add(0);
        }
      }
      setState(() {
        searchBox=tmp;
      });
      setState(() {
        searchBookmark=result;
      });
    }

  }
  // updateBookmark(idx){
  //   List box=[...searchBookmark];
  //
  //   box[idx]==0 ? box[idx] = 1 : box[idx] = 0;
  //
  //   setState(() {
  //     searchBookmark=box;
  //   });
  // }
  // 위젯 실행시에 최근검색 데이터 불로서 state에 저장하기
  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    updateSearchBox();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth=MediaQuery.of(context).size.width;
    var deviceHeight=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: deviceHeight*0.075,
        leading: IconButton(
          onPressed: (){
            widget.update();
            // 뒤로 가기
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: TextField(
          controller: _controller,
          onSubmitted: _handleSubmitted,
          style: TextStyle(color: Colors.white54),
        ),
      ),
      body: Container(
        width: deviceWidth,
        height:deviceHeight,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              width: deviceWidth,
              height: deviceHeight*0.018,
            ),
            SizedBox(
              width:deviceWidth,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("최근 검색",style: TextStyle(
                    fontSize:25,
                    color: Colors.white,
                  ),),
                  TextButton(onPressed: (){
                    removeSearchData();
                  },child: Text("전체 삭제",style: TextStyle(color:Colors.grey),),),
                ],
              ),
            ),
            SizedBox(
              height:deviceHeight*0.018
            )
            ,
            Expanded(
              child: ListView.builder(
                itemCount: searchBox.length,
                itemBuilder: (BuildContext context,int idx){
                  return Container(
                    height: 50,

                    child: TextButton(
                      onPressed: () async {
                        // 최근 검색 유저로 검색할때
                        var result=await api.getUserInfo(searchBox[idx]);
                        var storage = await SharedPreferences.getInstance();
                        storage.setString("SearchUser",json.encode(result));
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>history.HistorySearch(data:result,nickname:searchBox[idx],update: updateSearchBox)));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(searchBox[idx],style:TextStyle(
                              color: Colors.white,
                            fontSize: 18,
                          )),
                          Row(
                            children: [
                              IconButton(icon: searchBookmark[idx]==0 ?Icon(Icons.star_border):Icon(Icons.star),onPressed: (){
                                //updateBookmark(idx);
                              },splashColor: Colors.transparent,highlightColor: Colors.transparent,),
                              IconButton(icon:Icon(Icons.close),onPressed: (){
                                // parameter=idx를 기준으로 해도 될듯
                                removeSearchItem(idx);
                              },splashColor: Colors.transparent,highlightColor: Colors.transparent,)
                            ],
                          )

                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}
