import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo3/app_theme.dart';
import 'package:todo3/auth/user_provider.dart';
import 'package:todo3/models/task_model.dart';
import 'package:todo3/tabs/settings/settings_provider.dart';
import 'package:todo3/tabs/task/function_firebase.dart';
import 'package:todo3/tabs/task/task_provider.dart';
import 'package:todo3/widgets/custom_elevated_bottom.dart';
import 'package:todo3/widgets/custom_text_form_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditTask extends StatefulWidget {
  static const String routeName = 'edit';

  const EditTask({super.key});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  DateTime selectDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController describtionController = TextEditingController();
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  late TaskModel task;
  @override
  @override
  Widget build(BuildContext context) {
    SettingsProvider settingsProvider = Provider.of<SettingsProvider>(context);
    final task = ModalRoute.of(context)?.settings.arguments as TaskModel?;

    if (task != null) {
      titleController.text = task.title;
      describtionController.text = task.describtion;
      selectDate = task.date;
    }
    return Scaffold(
      body: Form(
        key: formState,
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
              color: AppTheme.primary,
            ),
            height: MediaQuery.of(context).size.height * 0.17,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsetsDirectional.only(top: 40, start: 20),
              child: Text(
                AppLocalizations.of(context)!.toDoList,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 22,
                    color: settingsProvider.isDark
                        ? AppTheme.backgriundDark
                        : AppTheme.white),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              margin: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.12,
                horizontal: MediaQuery.of(context).size.width * 0.07,
              ),
              decoration: BoxDecoration(
                  color: settingsProvider.isDark
                      ? AppTheme.darkGrayish
                      : AppTheme.white,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)!.editTask,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: settingsProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black,
                        ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  CustomTextFormField(
                    controller: titleController,
                    hintText: 'This is title',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'title can not be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextFormField(
                    controller: describtionController,
                    hintText: 'Task details',
                    maxLines: 3,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Text(
                    'Select Date',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: settingsProvider.isDark
                            ? AppTheme.white.withOpacity(0.5)
                            : AppTheme.grey),
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
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                          initialEntryMode: DatePickerEntryMode.calendarOnly);
                      if (dateTime != null) {
                        selectDate = dateTime;
                        setState(() {});
                      }
                    },
                    child: Text(
                      dateFormat.format(selectDate),
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: settingsProvider.isDark
                              ? AppTheme.white.withOpacity(0.4)
                              : AppTheme.grey),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ),
                  CustomElevatedBottom(
                    label: AppLocalizations.of(context)!.saveChanges,
                    onPressed: () {
                      if (formState.currentState?.validate() ?? false) {
                        changeTask();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }

  void changeTask() {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);
    final task = ModalRoute.of(context)?.settings.arguments as TaskModel?;

    if (task != null) {
      task.title = titleController.text;
      task.describtion = describtionController.text;
      task.date = selectDate;

      FunctionFirebase.updateTaskInFirebase(task,
              Provider.of<UserProvider>(context, listen: false).currentUser!.id)
          .then((_) {
        taskProvider.getTask(
            Provider.of<UserProvider>(context, listen: false).currentUser!.id);
        print('Task updated with timeout');
      }).then((_) {
        Navigator.of(context).pop();
        taskProvider.getTask(
            Provider.of<UserProvider>(context, listen: false).currentUser!.id);
        print('Task updated successfully');
      }).catchError((error) {
        print('Error');
      });
    }
  }
}
