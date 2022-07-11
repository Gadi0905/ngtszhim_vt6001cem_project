import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/firebase_helper/model_helper/todo_model/todo_model.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/routes_helper/routes_helper.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/appbar_widget/default_appbar_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/asset_image_widget/asset_image_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/background_widget/default_background_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/button_widget/button_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/helpers/widgets_helper/top_snack_bar_widget/top_snack_bar_widget.dart';
import 'package:ngtszhim_vt6001cem_project/src/screens/logged_in_screens/todo_list_screen/todo_list_screen.dart';

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
      appBar: DefaultAppBarWidget.basicColor(),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return DefaultBackgroundWidget.basicColor(
      context: context,
      child: Stack(
        children: [
          _buildBackgroundImage(context),
          _buildItem(context),
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(BuildContext context) {
    return Positioned.fill(
      child: Opacity(
        opacity: 0.3,
        child: AssetImageWidget.basicImage(
          context: context,
          image: 'wallpaper.jpg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildItem(BuildContext context) {
    return Center(
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
              ButtonWidget.basicStyle(
                context: context,
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
            icon: Icon(Icons.title_rounded),
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
            icon: Icon(Icons.description),
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
        TopSnackBar.showInfo(
            context: context, message: 'Todo list has been added');
        RoutesHelper.popToRoot(context);
        RoutesHelper.pushScreen(context, const TodoListScreen());
      });
    } catch (e) {
      TopSnackBar.showError(context: context, errorMessage: e.toString());
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
