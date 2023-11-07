import 'package:fcselect/model/yplaylist.dart';
import 'package:flutter/material.dart';
import 'style.dart' as theme;
import './page/home.dart' as home;
import './utils/api.dart' as api;
import './model/yplaylist.dart' as ymodel;
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await dotenv.load(fileName: ".env");
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
      MaterialApp(
        theme: theme.themeData,
        home: MyApp(),
      )
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var change=0;

  getSharedBox() async {
    final SharedPreferences box=await SharedPreferences.getInstance();

    // 즐겨찾기관련 데이터가 없다면 생성하기
    if(box.getStringList("Bookmark")==null){
      await box.setStringList("Bookmark",<String>[]);
    }
    if(box.getStringList("searched")==null){
      await box.setStringList("searched",<String>[]);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 재생목록 불러오기
    getSharedBox();
    api.setSpid();
  }
  @override
  Widget build(BuildContext context) {
    return home.HomeSelect();
  }
}
