import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_expenses/model/reminder.dart';
import 'package:my_expenses/screens/addNewReminder.dart';
import 'package:my_expenses/screens/reminderInfo.dart';
import 'package:my_expenses/viewModel/reminderViewModel.dart';
import 'package:provider/provider.dart';

class ReminderList extends StatefulWidget {
  const ReminderList({Key? key}) : super(key: key);

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  @override
  Widget build(BuildContext context) {
    var reminder = Provider.of<ReminderViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reminders'),
        centerTitle: true,
        actions: [
          AspectRatio(
            aspectRatio: 1.5/1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(  const Color(0XFF125F61)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.white))),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddNewReminder()));
                  },
                  child: const Center(child: Icon(Icons.add,size: 15.0,))),
            ),
          ),
          const SizedBox(width: 10.0,),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
                future: reminder.gerReminders(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Reminder>> remindersList) {
                  if (remindersList.hasData) {
                    return Column(
                      children: remindersList.data!
                          .map((e) => ReminderInfo(e))
                          .toList(),
                    );
                  } else if (remindersList.hasError) {
                    return const Text('Error');
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}
