import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/firebase_helper/model_helper/todo_model/todo_model.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/top_snack_bar_widget/top_snack_bar_widget.dart';

class TodoServices {
  TodoServices._();

  static final instance = TodoServices._();

  static Future<List<TodoModel>> getTodos() async {
    List<TodoModel> todos = [];
    final todoDocuments =
        await FirebaseFirestore.instance.collection('todos').orderBy('time').get();
    for (var todo in todoDocuments.docs) {
      todos.add(TodoModel.fromJson(todo.data(), documentId: todo.id));
    }
    return todos;
  }

  static Future<void> deleteTodo(BuildContext context, String docId) async {
    try {
      await FirebaseFirestore.instance.collection("todos").doc(docId)
          .delete();
      TopSnackBar.showInfo(context: context, message: 'Todo has been deleted');
    } catch (e) {
      TopSnackBar.showError(context: context, errorMessage: e.toString());
    }
    return;
  }
}
