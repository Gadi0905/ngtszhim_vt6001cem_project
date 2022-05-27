import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TodoModel {
  String? id;
  String? title;
  String? description;
  Timestamp? time;

  TodoModel(this.id, this.title, this.description, this.time);

  TodoModel.fromJson(Map<String, dynamic> json, {String? documentId}) {
    id = documentId;
    title = json['title'];
    description = json['description'];
    time = json['time'];
  }

  Map<String, Object?> toJson(DateTime? dateTime) {
    return {
      'title': title,
      'description': description,
      'time': datetimeToTimestamp(dateTime),
    };
  }

  static String timestampConvertToString(Timestamp? timeStamp) {
    if (timeStamp == null) {
      return '';
    }
    var dateFromTimeStamp =
        DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('yyyy-MM-dd – kk:mm').format(dateFromTimeStamp);
  }

  static Timestamp datetimeToTimestamp(DateTime? dateTime) {
    dateTime ??= DateTime.now();
    return Timestamp.fromDate(dateTime);
  }

  @override
  String toString() {
    return 'TodoModel{id: $id, title: $title, description: $description, time: $time}';
  }
}
