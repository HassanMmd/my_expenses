import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/reminder.dart';
import '../viewModel/reminderViewModel.dart';

class ReminderInfo extends StatelessWidget {
  Reminder reminder;

  ReminderInfo(this.reminder);

  @override
  Widget build(BuildContext context) {
    var reminderViewModel = Provider.of<ReminderViewModel>(context);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Card(
          color: const Color(0XFFf5e6db),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        const Text(
                          'Date',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          '${reminder.date.year}/${reminder.date.month}/${reminder.date.day} at ${reminder.date.hour}:${reminder.date.minute}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          reminder.description!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
                TextButton(
                    onPressed: () {
                      reminderViewModel.deleteItem(reminder.id!);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Color(0XFF125F61),
                    )),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
