import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/firebase_helper/model_helper/todo_model.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/route_helper.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_appbar.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_background.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_button.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/custom_top_snack_bar.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/todo_list_screen/todo_list_screen.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  // final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';
  late DateTime dateTime = DateTime.now();

  _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: child,
            ),
          );
        });
  }

  _onClickTxtBtn() {
    _showDialog(
      CupertinoDatePicker(
        initialDateTime: dateTime,
        use24hFormat: true,
        onDateTimeChanged: (DateTime newDateTime) {
          setState(() => dateTime = newDateTime);
        },
      ),
    );
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
        children: const [
          Text(
            'Add Todo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.5,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              _buildTitleField(),
              const SizedBox(height: 20),
              _buildDescriptionField(),
              const SizedBox(height: 20),
              _buildDateTimePicker(context),
              const SizedBox(height: 20),
              CustomButton(
                title: 'Add Todo',
                backgroundColor: Colors.deepOrangeAccent.shade200,
                textColor: Colors.white,
                onPressItem: () {
                  addTodo();
                },
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: titleController,
          validator: validateTitle,
          decoration: const InputDecoration(
            icon: Icon(FontAwesomeIcons.t),
            hintText: 'Please enter title here.',
            labelText: 'Title',
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: descriptionController,
          validator: validateDescription,
          decoration: const InputDecoration(
            icon: Icon(FontAwesomeIcons.solidFileLines),
            hintText: 'Please enter description here.',
            labelText: 'Description',
          ),
        ),
      ],
    );
  }

  Widget _buildDateTimePicker(BuildContext context) {
    return TextButton(
      onPressed: () {
        _onClickTxtBtn();
      },
      child: const Text(
        'Please select the date and time here',
        style: TextStyle(color: Colors.black54),
      ),
    );
  }

  Future addTodo() async {
    try {
      final todo = <String, dynamic>{
        'title': titleController.text,
        'description': descriptionController.text,
        'time': TodoModel.datetimeToTimestamp(dateTime),
      };
      FirebaseFirestore.instance
          .collection('todos')
          .add(todo)
          .then((DocumentReference doc) {
        CustomTopSnackBar.showInfo(
            context: context, message: 'Todo list has been added');
        RoutesHelper.popToRoot(context);
        RoutesHelper.pushScreen(context, const TodoListScreen());
      });
    } catch (e) {
      CustomTopSnackBar.showError(context: context, errorMessage: e.toString());
    }
  }
}

String? validateTitle(String? formTitle) {
  if (formTitle == null || formTitle.isEmpty) {
    return 'Title is required';
  }
  return null;
}

String? validateDescription(String? formDescription) {
  if (formDescription == null || formDescription.isEmpty) {
    return 'Description is required';
  }
  return null;
}
