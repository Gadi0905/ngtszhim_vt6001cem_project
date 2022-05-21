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

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'description': description,
      'time': currentDatetimeToTimestamp(),
    };
  }

  static String timestampConvertToString(Timestamp? timeStamp) {
    if (timeStamp == null) {
      return '';
    }
    var dateFromTimeStamp =
    DateTime.fromMillisecondsSinceEpoch(timeStamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy hh:mm a').format(dateFromTimeStamp);
  }

  static Timestamp currentDatetimeToTimestamp() {
    DateTime currentPhoneDate = DateTime.now(); //DateTime
    return Timestamp.fromDate(currentPhoneDate);
  }

  @override
  String toString() {
    return 'TodoModel{id: $id, title: $title, description: $description, time: $time}';
  }
}
