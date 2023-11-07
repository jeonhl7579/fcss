import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceWidth=MediaQuery.of(context).size.width;
    var deviceHeight=MediaQuery.of(context).size.height;

    return Dialog(
      child: Container(
        width:deviceWidth*0.8,
        height: deviceHeight*0.12,
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(alignment: Alignment.centerLeft,child: Text("존재하지 않는 구단주입니다."),),
            Align(alignment:Alignment.bottomRight,child: TextButton(onPressed: (){
              //다시 뒤로가기
              Navigator.pop(context);
            }, child: Text("확인")),),
          ],
        )
      ),
    );
  }
}
