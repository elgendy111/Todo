import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/auth/user_provider.dart';
import 'package:todo3/models/task_model.dart';
import 'package:todo3/tabs/task/function_firebase.dart';
import 'package:todo3/tabs/task/task_provider.dart';
import 'package:todo3/widgets/custom_elevated_bottom.dart';
import 'package:todo3/widgets/custom_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime selectDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController describtionController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      height: MediaQuery.of(context).size.height * 0.55,
      padding: const EdgeInsets.all(20),
      child: Form(
        key: formState,
        child: Column(
          children: [
            Text(
              'Add New Task',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              hintText: 'Enter Title Task',
              controller: titleController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'title can not be empty';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              hintText: 'Enter Describtion Task',
              controller: describtionController,
              maxLines: 5,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Select Date',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () async {
                DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: selectDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                    initialEntryMode: DatePickerEntryMode.calendarOnly);
                if (dateTime != null) {
                  selectDate = dateTime;
                  setState(() {});
                }
              },
              child: Text(
                dateFormat.format(selectDate),
                style: theme.textTheme.titleMedium,
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            CustomElevatedBottom(
              label: 'Add Task',
              onPressed: () {
                if (formState.currentState?.validate() ?? false) {
                  addTask();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void addTask() {
    final userId =
        Provider.of<UserProvider>(context, listen: false).currentUser!.id;
    FunctionFirebase.addTasksToFirebase(
      TaskModel(
        title: titleController.text,
        describtion: describtionController.text,
        date: selectDate,
      ),
      userId,
    ).then((_) {
      Navigator.of(context).pop();
      Provider.of<TaskProvider>(context, listen: false).getTask(userId);
      Fluttertoast.showToast(
          msg: "Something went Error!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: AppTheme.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }).catchError((error) {
      Fluttertoast.showToast(
          msg: "Something went Error!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          backgroundColor: AppTheme.red,
          textColor: Colors.white,
          fontSize: 16.0);
    });
  }
}
