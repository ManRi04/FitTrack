
import 'package:fit_track/app/calendar.dart';
import 'package:flutter/material.dart';
import 'profile.dart';


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
          GestureDetector(
            onTap: () {
              // Navigation zur neuen Seite
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilPage()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Verschiebt das Icon nach links
              children: [
                Icon(
                  Icons.account_circle,
                  size: 50,
                  color: Colors.white,
                ),
              ],
            ),
          ),


          GestureDetector(
            onTap: () {
              // Navigation zur neuen Seite
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CalendarPage()),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Verschiebt das Icon nach links
              children: [
                Icon(
                  Icons.calendar_month_outlined,
                  size: 50,
                  color: Colors.white,
                ),
              ],
            ),
          )

          ,
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

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: const Text('AppBar with hamburger button')),
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
    );
  }
}
