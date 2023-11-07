import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/api.dart' as api;

class MatchList extends StatefulWidget {
  MatchList({super.key,this.change,this.init,this.update});
  var change;
  var init;
  var update;
  @override
  State<MatchList> createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {
  var menuNum=0;

  setMenu(tmp){
    setState(() {
      menuNum=tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    var widgetWidth=MediaQuery.of(context).size.width;
    return OverflowBar(
      alignment: MainAxisAlignment.start,
      children: [
        Container(
          width:widgetWidth*0.4,
          child: ElevatedButton(child: Text("공식 경기",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 19)),
            onPressed: () async {
              setMenu(0);
              // var storage=await SharedPreferences.getInstance();
              // storage.setInt("menuNum",0);
              await widget.change(0);
              await widget.init();
              //widget.load();
              widget.update(50);
              //await Future.delayed(Duration(seconds:1));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: menuNum==0? Color.fromRGBO(0, 201, 184, 1):Color.fromRGBO(0, 201, 184, 0.5),
            )

          ),
        ),
        SizedBox(width: widgetWidth*0.1,),
        Container(
          width:widgetWidth*0.4,
          child: ElevatedButton(child: Text("감독 모드",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 19),),
              onPressed: () async {
                setMenu(1);
                var storage=await SharedPreferences.getInstance();
                storage.setInt("menuNum",1);
                await widget.change(1);
                widget.update(52);
                //widget.load();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: menuNum==1? Color.fromRGBO(0, 201, 184, 1):Color.fromRGBO(0, 201, 184, 0.5),
              )

          ),
        ),
      ],
    );
  }
}
