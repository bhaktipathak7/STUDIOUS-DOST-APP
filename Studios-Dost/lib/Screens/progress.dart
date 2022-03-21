import 'package:StudiosDost/Screens/add_spi.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressPage extends StatefulWidget {
  final String userId;
  const ProgressPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<ProgressPage> createState() => _ProgressPageState();
}

class _ProgressPageState extends State<ProgressPage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

   List<ChartData> chartDataFinal = [];

  double sem1 = 0.0;
  double sem2 = 0.0;
  double sem3 = 0.0;
  double sem4 = 0.0;
  double sem5 = 0.0;
  double sem6 = 0.0;
  getData() async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(widget.userId)
        .collection("marks")
        .where("id", isEqualTo: widget.userId)
        .get();
    var sem1a = snapshot.docs[0]['sem1'];
    var sem2a = snapshot.docs[0]['sem2'];
    var sem3a = snapshot.docs[0]['sem3'];
    var sem4a = snapshot.docs[0]['sem4'];
    var sem5a = snapshot.docs[0]['sem5'];
    var sem6a = snapshot.docs[0]['sem6'];
    sem1 = double.parse(sem1a);
    sem2 = double.parse(sem2a);
    sem3 = double.parse(sem3a);
    sem4 = double.parse(sem4a);
    sem5 = double.parse(sem5a);
    sem6 = double.parse(sem6a);
     chartDataFinal = [
      ChartData('Semester 1', sem1, color: Colors.brown),
      ChartData('Semester 2', sem2, color: Colors.blueGrey),
      ChartData('Semester 3', sem3, color: Colors.green),
      ChartData('Semester 4', sem4, color: Colors.blue),
      ChartData('Semester 5', sem5, color: Colors.deepOrangeAccent),
      ChartData('Semester 6', sem6, color: Colors.amber),
    ];

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                getData();
              },
              icon: const Icon(Icons.replay_outlined))
        ],
        title: const Text('Progress'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.brown,
              ),
              title: const Text("SEMESTER 1"),
              subtitle: Text(sem1.toString() + " SPI"),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blueGrey,
              ),
              title: const Text("SEMESTER 2"),
              subtitle: Text(sem2.toString() + " SPI"),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
              ),
              title: const Text("SEMESTER 3"),
              subtitle: Text(sem3.toString() + " SPI"),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
              ),
              title: const Text("SEMESTER 4"),
              subtitle: Text(sem4.toString() + " SPI"),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.deepOrangeAccent,
              ),
              title: const Text("SEMESTER 5"),
              subtitle: Text(sem5.toString() + " SPI"),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.amber,
              ),
              title: const Text("SEMESTER 6"),
              subtitle: Text(sem6.toString() + " SPI"),
            ),
            SfCircularChart(
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                    dataSource: chartDataFinal,
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                    pointColorMapper: (ChartData data, _) => data.color,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y)
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => AddSpi(
                      userId: widget.userId,
                    )))),
        child: const Icon(
          Icons.add,
          size: 40,
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, {required this.color});
  final String x;
  final double y;
  final Color color;
}
