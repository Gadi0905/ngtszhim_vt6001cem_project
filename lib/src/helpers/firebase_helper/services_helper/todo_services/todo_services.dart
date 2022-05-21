import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/firebase_helper/model_helper/todo_model/todo_model.dart';

class TodoServices {
  TodoServices._();

  static final instance = TodoServices._();

  static Future<List<TodoModel>> getTodos() async {
    List<TodoModel> todos = [];
    final todoDocuments =
        await FirebaseFirestore.instance.collection('todos').get();
    for (var todo in todoDocuments.docs) {
      todos.add(TodoModel.fromJson(todo.data(), documentId: todo.id));
    }
    return todos;
  }

  static Future<void> deleteTodo(String docId) async {
    try {
      await FirebaseFirestore.instance.collection("todos").doc(docId)
          .delete();
    } catch (e) {
      print(e.toString());
    }
    return;
  }
}
