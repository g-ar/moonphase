import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io' as io;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  String _counter = "";
  var phases = ['New Moon', 'Waxing Crescent', 'First Quarter ', 'Waxing Gibbous',
  'Full Moon', 'Waning Gibbous', ' Last Quarter ', ' Waning Crescent '];
double _phase2 = 0;
double _phase = 4;
double _phase1 = 0;
int idx = 0;
  Alignment _bright = Alignment.centerLeft;
  Alignment _dark = Alignment.centerRight;
  List<Widget> _widgetList = <Widget>[];
  _MyHomePageState() {
    DateTime _now = DateTime.now();
    _phase = MoonPhase2(_now.year, _now.month, _now.day);
    if (_phase.toInt() == 0) idx = 0;
    else if (_phase.toInt() < 4) idx = 1;
    else if (_phase.toInt() < 8) idx = 2;
    else if (_phase.toInt() < 15) idx = 3;
    else if (_phase.toInt() == 15) idx = 4;
    else if (_phase.toInt() < 20) idx = 5;
    else if (_phase.toInt() < 24) idx = 6;
    else idx = 7;
    print(_phase);
    if (_phase > 15) {
      _phase2 = _phase - 15;
      _phase1 = 15 - _phase2;
      print(_phase1);
      print(_phase2);

    }
    else
    {
      _phase1 = _phase;
      _phase2 = 15 - _phase1;
      print(_phase1);
      print(_phase2);
    }

    Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        DateTime _now = DateTime.now();
        _counter = '${_now.hour.toString().padLeft(2,'0')}:${_now.minute.toString().padLeft(2,'0')}:${_now.second.toString().padLeft(2,'0')}';
      });
    });

  }
  int MoonPhase(int y, int m, int d)
  {
    /*
      calculates the moon phase (0-7), accurate to 1 segment.
      0 = > new moon.
      4 => full moon.
      */

    int c,e;
    double jd;
    int b;

    if (m < 3) {
      y--;
      m += 12;
    }
    ++m;
    c = (365.25*y).toInt();
    e = (30.6*m).toInt();
    jd = c+e+d-694039.09;  /* jd is total days elapsed */
    jd /= 29.53;           /* divide by the moon cycle (29.53 days) */
    b = jd.toInt();		   /* int(jd) -> b, take integer part of jd */
    jd -= b;		   /* subtract integer part to leave fractional part of original jd */
    b = (jd*8 + 0.5).toInt();	   /* scale fraction from 0-8 and round by adding 0.5 */
    b = b & 7;		   /* 0 and 8 are the same so turn 8 into 0 */
    return b;
  }

  double MoonPhase2(int y, int m, int d)
  {
    /*
      calculates the moon phase (0-7), accurate to 1 segment.
      0 = > new moon.
      4 => full moon.
      */

    int c,e;
    double jd;
    int b;

//    m =5;
//    d = 31;
    if (m < 3) {
      y--;
      m += 12;
    }
    ++m;
    c = (365.25*y).toInt();
    e = (30.6*m).toInt();
    jd = c+e+d-694039.09;  /* jd is total days elapsed */
    jd /= 29.53;           /* divide by the moon cycle (29.53 days) */
    b = jd.toInt();		   /* int(jd) -> b, take integer part of jd */
    jd -= b;		   /* subtract integer part to leave fractional part of original jd */
    return jd*29.53;
  }

  void _incrementCounter() {

    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

    });
  }

  @override
  Widget build(BuildContext context) {

    if (_phase < 16) {
      _widgetList = <Widget>[
        Container( // Progress to brightness
          decoration:  BoxDecoration(
              border: Border.all(width: 2,color: Colors.blue,),
              color: Colors.white
          ),
          width: MediaQuery
              .of(context)
              .size
              .width * _phase1 / 15 * 0.5,


          alignment: _bright,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const Text(
            "",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container( // Progress to darkness
          width: MediaQuery
              .of(context)
              .size
              .width * _phase2 / 15 * 0.5,
          decoration:  BoxDecoration(
              border: Border.all(width: 2,color: Colors.blue,),
              color: Colors.black
          ),
          alignment: _dark,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: const Text(
            "",
            style: TextStyle(color: Colors.white),
          ),
        )
      ];
    }
    else
      {
        _widgetList = <Widget>[
          Container( // Progress to darkness
            decoration:  BoxDecoration(
              border: Border.all(width: 2,color: Colors.blue,),
              color: Colors.black
            ),
            width: MediaQuery
                .of(context)
                .size
                .width * _phase2 / 15 * 0.5,

            alignment: _dark,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: const Text(
              "",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Container( // Progress to brightness
            decoration:  BoxDecoration(
              border: Border.all(width: 2,color: Colors.blue),
              color: Colors.white
            ),
            width: MediaQuery
                .of(context)
                .size
                .width * _phase1 / 15 * 0.5,

            alignment: _bright,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: const Text(
              "",
              style: TextStyle(color: Colors.white),
            ),
          ),

        ];
      }
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text(''),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
      ),
      body: Center(

        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

             Text(

              'Moon Phase: ${phases[idx]}',
              style: const TextStyle(
                color: Colors.white,
fontSize: 28
              )
            ),
            Text(
              '$_counter',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 28
                )
            ),

          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            children: _widgetList,

          ),
//             Image.network('https://moon.nasa.gov/internal_resources/361'),
             Image(image: AssetImage('assets/images/moon${idx}.jpeg'),
             width:   MediaQuery
                 .of(context)
                 .size
                 .width/4 ,
             )
             ,

          ],

        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
