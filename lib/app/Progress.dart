import 'package:fit_track/app/Challenges.dart';
import 'package:fit_track/app/NutritionInput.dart';
import 'package:fit_track/app/Timer.dart';
import 'package:fit_track/app/WorkoutPlan.dart';
import 'package:fit_track/app/calendar.dart';
import 'package:fit_track/app/login.dart';
import 'package:flutter/material.dart';
import 'profile.dart';

class ScreenSwiperPage extends StatefulWidget {
  const ScreenSwiperPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ScreenSwiperPage> createState() => _ScreenSwiperPageState();
}

class _ScreenSwiperPageState extends State<ScreenSwiperPage> {
  int _counter = 0;

  final controller = PageController(initialPage: 0);

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
      appBar: AppBar(title: const Text('FitTrack', textAlign: TextAlign.right)),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(''),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: const Text('Profile'),
              onTap: () {
                // Navigation zur neuen Seite
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month_outlined),
              title: const Text("Calendar"),
              onTap: () {
                // Navigation zur neuen Seite
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CalendarPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.query_stats),
              title: const Text("Stats"),
              onTap: () {
                // Navigation zur neuen Seite
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenSwiperPage(title: widget.title),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.fastfood),
              title: const Text("Nutrition"),
              onTap: () {
                // Navigation zur neuen Seite
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) =>
                            NutritionInputPage(currentDate: widget.title),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.list_alt),
              title: const Text("Workout plan"),
              onTap: () {
                // Navigation zur neuen Seite
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => WorkoutPlanPage(currentDate: widget.title),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.fitness_center),
              title: const Text('Challenges'),
              onTap: () {
                // Navigation zur neuen Seite
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChallengesPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.timer),
              title: const Text('Timer'),
              onTap: () {
                // Navigation zur neuen Seite
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TimerPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                // Navigation zur neuen Seite
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: controller,
        children: [StatsPage(headline: widget.title)],
      ),
    );
  }
}

class StatsPage extends StatefulWidget {
  const StatsPage({super.key, required this.headline});

  final String headline;

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(32, 48, 32, 32),
        child: Column(
          children: [
            Text(
              widget.headline,
              style: TextStyle(fontSize: 48, color: Color(0xFFFFFFFF)),
            ),
            const TrackingElement(
              color: Color(0xFFEFB21A),
              icondata: Icons.directions_run,
              unit: "m",
              max: 5000,
            ),
            const TrackingElement(
              color: Color(0xFF1A4CEF),
              icondata: Icons.local_drink,
              unit: "ml",
              max: 3000,
            ),
            const TrackingElement(
              color: Color(0xFFEF1A5A),
              icondata: Icons.fastfood,
              unit: "kcal",
              max: 1800,
            ),
          ],
        ),
      ),
    );
  }
}

class TrackingElement extends StatefulWidget {
  const TrackingElement({
    super.key,
    required this.color,
    required this.icondata,
    required this.unit,
    required this.max,
  });

  final Color color;
  final IconData icondata;
  final String unit;
  final double max;

  @override
  State<TrackingElement> createState() => _TrackingElementState();
}

class _TrackingElementState extends State<TrackingElement> {
  int _counter = 0;
  double _progress = 0;
  void _incrementCounter() {
    setState(() {
      _counter += 200;
      _progress = _counter / widget.max;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _incrementCounter,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(32, 64, 32, 32),

            child: Row(
              children: [
                Icon(widget.icondata, color: Colors.white70, size: 50),

                Text(
                  "$_counter/${widget.max.toInt()}${widget.unit}",
                  style: TextStyle(color: Color(0xFFE5F4F3), fontSize: 35),
                ),
              ],
            ),
          ),
          LinearProgressIndicator(
            value: _progress,
            color: widget.color,
            backgroundColor: const Color(0x40FFFFFF),
            minHeight: 12.0,
          ),
        ],
      ),
    );
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
      appBar: AppBar(
        title: const Text('FitTrack', textAlign: TextAlign.center),
      ),
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
              child: Text(''),
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

class OptionSideBar extends StatefulWidget {
  const OptionSideBar({super.key});

  @override
  State<OptionSideBar> createState() => _OptionSideBarState();
}

class _OptionSideBarState extends State<OptionSideBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AppBar with hamburger button')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(''),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                // Update the state of the app.
              },
            ),
          ],
        ),
      ),
    );
  }
}
