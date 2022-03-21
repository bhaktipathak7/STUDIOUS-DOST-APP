import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Database {
  createUser(map, String id) async {
    return FirebaseFirestore.instance.collection('users').doc(id).set(map);
  }

  addTask(map, String userId, String taskId) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .set(map);
  }

  addSpis(map, String userId, String taskId) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('marks')
        .doc(taskId)
        .set(map);
  }

  getSpis(map, String userId, String taskId) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('marks')
        .doc(taskId)
        .get();
  }

  addWaterDrinked(map, String userId, String timeStamp) async {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(userId)
        .collection('waterTracker')
        .doc(timeStamp)
        .set(map);
  }

  getWaterNotificationStatus(String userId) async {
    String date = DateFormat('dd-MM-yyyy').format(DateTime.now());
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection("users")
        .doc(userId)
        .collection("waterTracker")
        .where("date", isEqualTo: date)
        .get();
    var bool = snapshot.docs[0]['isStarted'];
    return bool;
  }

  getTasks(String id) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('tasks')
        .snapshots();
  }

  deleteTasks(String userId, String taskId) async {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('tasks')
        .doc(taskId)
        .delete();
  }

  getUserName(String id) async {
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('users')
        .where('id', isEqualTo: id)
        .get();
    var name = snapshot.docs[0]['username'];
    return name;
  }
}
