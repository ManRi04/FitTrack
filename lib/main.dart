// ignore_for_file: unused_field, unused_element, use_super_parameters

//import 'dart:ffi';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFF0F0B1B),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

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
  int _counter = 0;

  final controller = PageController(initialPage:0);

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: PageView(
          controller: controller,
          children: [const DetailPage(headline: "Heute"),const DetailPage(headline: "Gestern")],)
    );
  }
}
class DetailPage extends StatefulWidget {
  const DetailPage({Key? key, required this.headline}) : super(key:key);

  final String headline;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsetsDirectional.fromSTEB(32, 48, 32, 32),
        child: Column(children: [
          Text(widget.headline, style: TextStyle(fontSize: 48, color: Color(0xFFFFFFFF)),),
          const TrackingElement(color: Color(0xFFEFB21A), icondata: Icons.directions_run,unit:"m", max:5000),
          const TrackingElement(color: Color(0xFF1A4CEF), icondata: Icons.local_drink, unit: "ml", max: 3000),
          const TrackingElement(color: Color(0xFFEF1A5A), icondata: Icons.fastfood, unit: "kcal", max:1800)],
        )
    );
  }
}




class TrackingElement extends StatefulWidget {
  const TrackingElement({Key? key, required this.color, required this.icondata , required this.unit ,required this.max}) : super(key:key);

  final Color color;
  final IconData icondata;
  final String unit;
  final double max;

  @override
  State<TrackingElement> createState() => _TrackingElementState();
}

class _TrackingElementState extends State<TrackingElement> {
  int _counter = 0;
  double _progress =0;
  void _incrementCounter() {
    setState(() {
      _counter+=200;
      _progress = _counter/widget.max;
    });
  }


  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: _incrementCounter ,
        child:Column(

          children: <Widget>[
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(32, 64, 32, 32),

              child: Row(children: [
                Icon(widget.icondata,color: Colors.white70, size: 50),

                Text(
                    "$_counter/${widget.max.toInt()}${widget.unit}",
                    style: TextStyle(color: Color(0xFFE5F4F3), fontSize: 35)
                ),]),
            ),
            LinearProgressIndicator(
              value:_progress,
              color: widget.color,
              backgroundColor: const Color(0x40FFFFFF),
              minHeight: 12.0,
            )


          ],
        ));

  }
}






