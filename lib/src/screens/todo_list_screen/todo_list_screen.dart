import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/firebase_helper/model_helper/todo_model.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/firebase_helper/services_helper/todo_services.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/route_helper.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_appbar.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_background.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/todo_list_screen/add_todo_screen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  String errorMessage = '';
  late List<TodoModel> todoList = [];

  @override
  void initState() {
    super.initState();
    _getTodos();
  }

  _getTodos() async {
    todoList = await TodoServices.getTodos();
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar.basicColor(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return CustomBackground(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              _buildText(context),
              const SizedBox(height: 10),
              _buildCard(context),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0),
      child: Row(
        children: [
          const Text(
            'Todo List',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          _buildAddTodoButton(),
        ],
      ),
    );
  }

  Widget _buildAddTodoButton() {
    return InkWell(
      onTap: () {
        RoutesHelper.pushScreen(context, const AddTodoScreen());
      },
      child: Row(
        children: const [
          Icon(Icons.add_rounded, color: Colors.white, size: 25),
          SizedBox(width: 10),
          Text('Add todo', style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.75,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 10,
        child: _buildListView(),
      ),
    );
  }

  Widget _buildListView() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: todoList.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(index);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(
          thickness: 3,
          indent: 0,
          endIndent: 0,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildListItem(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          'Todo ${index.toString()}',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Title: ${todoList[index].title ?? 'title'}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.clip,
                ),
              ),
              Text(
                'Description: ${todoList[index].description ?? 'description'}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.clip,
                ),
              ),
              Text(
                'Date: ${TodoModel.timestampConvertToString(todoList[index].time)}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.clip,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: () {
            TodoServices.deleteTodo(context, todoList[index].id ?? '');
            setState(() {
              _getTodos();
            });
          },
          icon: const Icon(Icons.delete, size: 20),
        ),
      ],
    );
  }
}