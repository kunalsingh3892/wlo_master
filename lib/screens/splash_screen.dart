import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'checklist_screen.dart';
import 'job_pagination.dart';
import 'jobs_homepage.dart';
import 'login.dart';


class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _loggedIn = false;
  bool _next = false;
  bool firstShow = false;
  final splashDelay = 3;
  String formattedDate1 = "";
  String lastVisitDate="";
  @override
  void initState() {
    super.initState();

    _checkLoggedIn();
   // checkIsTodayVisit();


  }
  _checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var _isLoggedIn = prefs.getBool('logged_in');
    if (_isLoggedIn == true) {
      setState(() {
        _loggedIn = _isLoggedIn;
      });


    } else {
      setState(() {
        _loggedIn = false;
      });
    }
    checkIsTodayVisit();
  }
  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigationPage);
  }
  TextStyle normalText = GoogleFonts.montserrat(
      fontSize: 30, fontWeight: FontWeight.w300, color: Colors.black);
  void navigationPage() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => _next==true?homeOrLog():homeOrLog1()));
  }

  checkIsTodayVisit() async {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

    SharedPreferences prefs = await _prefs;
    lastVisitDate = prefs.get("mDateKey");
    if(prefs.getBool("firstShow")!=null){
      firstShow = prefs.getBool("firstShow");
    }

    var now = new DateTime.now();
    var formatter = new DateFormat('dd-MMM-yyyy');
    String toDayDate = formatter.format(now);

    if (toDayDate == lastVisitDate) {
      print(lastVisitDate);
      setState(() {
        _next = true;
      });
    }
    else {
      print(lastVisitDate);
      if (lastVisitDate==null) {
      if(firstShow) {
        setState(() {
          _next = true;
        });
      }
      else{
        setState(() {
          _next = false;
        });
      }
    }
      else{
        setState(() {
          _next = false;
        });
      }

     /* if(firstShow) {
        prefs.setString("mDateKey", toDayDate);
      }
      else{
        prefs.setString("mDateKey", "");
      }*/
    }
    _loadWidget();
  }
  Widget homeOrLog() {
    if(this._loggedIn){
      var obj = 0;
      return JobsScreen11();
    }
    else{
      return LoginScreen();
    }
  }
  Widget homeOrLog1() {
    if(this._loggedIn){
      var obj = 0;
      return VehicleChecklists();
    }
    else{
      return LoginScreen();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: InkWell(
        child: Container(

          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(

              children: <Widget>[

                Container(
                  height:  MediaQuery.of(context).size.height * 0.40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/login.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.90,
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Image.asset("assets/images/logo.png"),
                ),


              ],
            ),
              Container(
                padding: EdgeInsets.only(bottom: 30),
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: MaterialButton(
                    onPressed: () => {},
                    child: Text("Loading...",style: normalText),
                  ),
                ),
              ),

            ]
          ),
        ),
      ),
    );
  }
}