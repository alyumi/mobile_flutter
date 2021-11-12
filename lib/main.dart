import 'package:flutter/material.dart';
import 'Labs/lab1.dart';
import 'Labs/lab2.dart';
import 'Labs/lab3.dart';
import 'Labs/lab4.dart';
import 'Labs/lab5.dart';
import 'Labs/lab6.dart';
import 'Labs/lab7.dart';
import 'Labs/lab8.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  runApp(MyApp(cameras: cameras));
} 

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  final List<CameraDescription> cameras;
  const MyApp({Key? key, required this.cameras}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    FirebaseAnalytics()
        .logEvent(name: 'App_flutter_labs_launch', parameters: null);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Labs',
      navigatorObservers: <NavigatorObserver>[observer],
      home: MyHomePage(cameras: cameras),
    );
  }
}

class MyHomePage extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  final List<CameraDescription> cameras;

  const MyHomePage({Key? key, required this.cameras}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: <NavigatorObserver>[observer],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          primaryColor: Colors.lightBlue,
          accentColor: Colors.lightBlue,
          unselectedWidgetColor: Colors.lightBlue),
      home: DefaultTabController(
        length: 8,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: 'Lab1'),
                Tab(text: 'Lab2'),
                Tab(text: 'Lab3'),
                Tab(text: 'Lab4'),
                Tab(text: 'Lab5'),
                Tab(text: 'Lab6'),
                Tab(text: 'Lab7'),
                Tab(text: 'Lab8'),
              ],
            ),
            title: const Text(
              'Flutter Labs',
            ),
          ),
          body: TabBarView(
            children: [
              Lab01(),
              Lab02(cameras: cameras),
              Lab03(),
              Lab04(),
              Lab05(),
              Lab06(),
              Lab07(),
              Lab08(),
            ],
          ),
        ),
      ),
    );
  }
}