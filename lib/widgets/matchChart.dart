import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class pieChart extends StatefulWidget {
  pieChart({super.key,this.data});
  final data;

  @override
  State<pieChart> createState() => _pieChartState();
}

class _pieChartState extends State<pieChart> {
  int win=0;
  int mu=0;
  int defeat=0;


  findValue(data){
    List<int>? smallList=[...data];
    int sumValue=0;
    smallList.forEach((value)=>sumValue+=value);
    //print("${}${((smallList[2]/sumValue)*100).toStringAsFixed(2)}${((smallList[1]/sumValue)*100).toStringAsFixed(2)}");

    setState(() {
      win=((smallList[0]/sumValue)*100).round();
      mu=((smallList[2]/sumValue)*100).round();
      defeat=((smallList[1]/sumValue)*100).round();
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    findValue(widget.data);

  }
  @override
  Widget build(BuildContext context) {
    var deviceWidth=MediaQuery.of(context).size.width;
    return Container(
        width: deviceWidth,
        height: 120,
        decoration: BoxDecoration(
          //color: Color.fromRGBO(192, 218, 238, 0.2),
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width:1,
            ),
            bottom: BorderSide(
              color: Colors.grey,
              width: 1,
            )
          )
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0.5,0.3),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "${widget.data[0]}승 ${widget.data[2]}무 ${widget.data[1]}패", style: TextStyle(color: Colors.white,fontSize: 22,
                      fontFamily: "PretendardExtra"
                    )),
                    TextSpan(text: " (${win}%)",style: TextStyle(color: Colors.white,fontSize: 15)),
                  ]
                ),
              )
              // Text("${widget.data[0]}승 ${widget.data[2]}무 ${widget.data[1]}패",style: TextStyle(

              // ),),
            ),
            Align(
              alignment: Alignment(-0.55,0),
              child: Container(
                child: AspectRatio(
                  aspectRatio: 0.5,
                  child: PieChart(
                      PieChartData(
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 2,
                        centerSpaceRadius: 33,
                        sections: showingSections(),
                      )
                  ),
                ),
              ),
            ),
          ],

        ),
    );
  }
  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final radius = 7.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.grey.withOpacity(0.85),
            value: mu==0?30:mu.toDouble(),
            title: "",
            radius: radius,
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blueAccent.withOpacity(0.85),
            value: win==0?40:win.toDouble(),
            title: "",
            radius: radius,
          );
        case 2:
          return PieChartSectionData(
            color: Colors.red.withOpacity(0.85),
            value: defeat==0?30:defeat.toDouble(),
            title: "",
            radius: radius,
          );
        default:
          throw Error();
      }
    });
  }
}
