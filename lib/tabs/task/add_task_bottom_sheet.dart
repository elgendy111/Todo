import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo3/widgets/custom_elevated_bottom.dart';
import 'package:todo3/widgets/custom_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
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
      padding: EdgeInsets.all(20),
      child: Form(
        key: formState,
        child: Column(
          children: [
            Text(
              'Add New Task',
              style: theme.textTheme.titleMedium,
            ),
            SizedBox(
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
            SizedBox(
              height: 16,
            ),
            CustomTextFormField(
              hintText: 'Enter Describtion Task',
              controller: describtionController,
              maxLines: 5,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Select Date',
              style: theme.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 8,
            ),
            InkWell(
              onTap: () async {
                DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: selectDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
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
            SizedBox(
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

  void addTask() {}
}
