import 'package:StudiosDost/Components/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class WaterTracker extends StatefulWidget {
  final String userId;
  const WaterTracker({Key? key, required this.userId}) : super(key: key);

  @override
  State<WaterTracker> createState() => _WaterTrackerState();
}

class _WaterTrackerState extends State<WaterTracker> {
  TextEditingController intervalController = TextEditingController();

  bool isStarted = false;
  bool setBool = false;
  String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  void sendData() {
    Map<String, dynamic> data = {
      'timestamp': DateTime.now(),
      'isStarted': setBool,
      "date": date
    };
    Database().addWaterDrinked(data, widget.userId, date);
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  showNotification() async {
    var androidDetails = const AndroidNotificationDetails(
        "ChannelId", "StudiosDost",
        importance: Importance.max);

    var generalNotificationDetails =
        NotificationDetails(android: androidDetails);

    await flutterLocalNotificationsPlugin.show(
        0, "Reminder turned on", "Drink Water", generalNotificationDetails);

    Database().getWaterNotificationStatus(widget.userId).then((val) {
      if (val == true) {
        flutterLocalNotificationsPlugin.periodicallyShow(0, "Water Reminder",
            "Drink Water", RepeatInterval.hourly, generalNotificationDetails);
            
      } else if (val == false) {
        flutterLocalNotificationsPlugin.cancelAll();
      }
    });
    setState(() {});
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  String buttonTitle = "Not Started";
  init() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('icon');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) {});

    Database().getWaterNotificationStatus(widget.userId).then((val) {
      isStarted = val;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Tracker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: LiquidCircularProgressIndicator(
                value: .30,
                valueColor: const AlwaysStoppedAnimation(Colors.blue),
                backgroundColor: Colors.white,
                borderColor: Colors.blue,
                borderWidth: 2.0,
                direction: Axis.vertical,
                center: const Text(
                  'Drink Water Stay Hydrated',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                if (setBool == false) {
                  setBool = true;
                  buttonTitle = "Started";
                  setState(() {});
                } else if (setBool == true) {
                  setBool = false;
                  buttonTitle = "Stopped";
                  setState(() {});
                }
                sendData();
                showNotification();
                Database()
                    .getWaterNotificationStatus(widget.userId)
                    .then((val) {
                  isStarted = val;
                  if (val == true) {
                    buttonTitle = "Started";
                    setState(() {});
                  } else {
                    buttonTitle = "Stopped";
                    setState(() {});
                  }
                });
              },
              child: Container(
                height: 50,
                width: 150,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(18.0)),
                child: Center(
                    child: Text(
                  buttonTitle,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
