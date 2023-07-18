import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_storage/get_storage.dart';
import 'package:taskapp/models/task.dart';

class FirestoreRepository {
  static Future<void> create({Task? task}) async {
    try {
      String email = GetStorage().read('email');
      await FirebaseFirestore.instance
          .collection(email)
          .doc(task!.id)
          .set(task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<Task>> get() async {
    List<Task> taskList = [];
    try {
      String email = GetStorage().read('email');
      final data = await FirebaseFirestore.instance.collection(email).get();
      for (var task in data.docs) {
        taskList.add(Task.fromMap(task.data()));
      }
      return taskList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<Task>> getTodayTasks(String date) async {
    List<Task> taskList = [];
    try {
      String email = GetStorage().read('email');
      final data = await FirebaseFirestore.instance
          .collection(email)
          .where('date', isEqualTo: date)
          .where('isDone', isEqualTo: false)
          .get();

      for (var task in data.docs) {
        taskList.add(Task.fromMap(task.data()));
      }
      print('$taskList, $date');
      return taskList;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> update({Task? task}) async {
    try {
      String email = GetStorage().read('email');
      final data = FirebaseFirestore.instance.collection(email);
      data.doc(task!.id).update(task.toMap());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> delete({Task? task}) async {
    try {
      String email = GetStorage().read('email');
      final data = FirebaseFirestore.instance.collection(email);
      data.doc(task!.id).delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<void> deleteAllRemovedTasks({List<Task>? taskList}) async {
    try {
      String email = GetStorage().read('email');
      final data = FirebaseFirestore.instance.collection(email);
      for (var task in taskList!) {
        data.doc(task.id).delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
