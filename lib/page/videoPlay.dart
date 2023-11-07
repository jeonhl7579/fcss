import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class videoPlay extends StatefulWidget {
  videoPlay({super.key,this.video});
  var video;

  @override
  State<videoPlay> createState() => _videoPlayState();
}

class _videoPlayState extends State<videoPlay> {
  String id="";

  setId(){
    setState(() {
      id=widget.video;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setId();
  }

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(initialVideoId: id,flags: YoutubePlayerFlags(
      autoPlay: true,
    ),
    );
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,),
      body: Align(
        alignment: Alignment(0,-0.2),
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
          progressColors: ProgressBarColors(
            playedColor: Colors.amber,
            handleColor: Colors.amberAccent,
          ),
          bottomActions: [
            CurrentPosition(),
            const SizedBox(width: 10.0),
            ProgressBar(isExpanded: true),
            const SizedBox(width: 10.0),
            RemainingDuration(),
            //FullScreenButton(),
          ],
        ),
      )
    );
  }
}
