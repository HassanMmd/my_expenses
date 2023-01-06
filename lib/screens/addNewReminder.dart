import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:my_expenses/model/reminder.dart';
import 'package:my_expenses/viewModel/reminderViewModel.dart';
import 'package:provider/provider.dart';

class AddNewReminder extends StatefulWidget {
  final int? id;
  final Color? color;
  final String? title;
  String? content;

  AddNewReminder({this.id, this.color, this.title, this.content});

  @override
  State<AddNewReminder> createState() => _AddNewReminderState();
}

class _AddNewReminderState extends State<AddNewReminder> {
  DateTime selectedDate = DateTime.now();
  DateTime fullDate = DateTime.now();

  Future<DateTime> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: selectedDate,
        lastDate: DateTime(2100));
    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );
      if (time != null) {
        setState(() {
          fullDate = DateTimeField.combine(date, time);
        });
        // await _notificationService.scheduleNotifications(
        //     id: widget.id,
        //     title: widget.title,
        //     body: widget.content,
        //     time: fullDate);
      }
      return DateTimeField.combine(date, time);
    } else {
      return selectedDate;
    }
  }

  bool added = false;

  @override
  Widget build(BuildContext context) {
    var reminder = Provider.of<ReminderViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Reminder'),
        centerTitle: true,
      ),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              color: const Color(0XFFf5e6db),
              borderRadius: BorderRadius.circular(10.0),
            ),
            padding: const EdgeInsets.all(10),
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    SizedBox(
                      child: TextField(
                        maxLength: 35,
                        onChanged: (value) {
                          widget.content = value;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Description*',
                          hintStyle: TextStyle(color: Color(0XFFC3BCBC)),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0XFF568ABB),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0XFF568ABB),
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    'The Date:',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '${fullDate.day} / ${fullDate.month} / ${fullDate.year} at ${fullDate.hour}:${fullDate.minute}'
                            .toString(),
                        style: const TextStyle(fontSize: 20.0),
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () async {
                              if (widget.content == null) {
                                showModalBottomSheet(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 200.0,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Text(
                                              'Please fill the description field',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(height: 25.0),
                                            ElevatedButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          const Color(
                                                              0XFF67C1AD)),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Ok'))
                                          ],
                                        ),
                                      );
                                    });
                              } else {
                                _selectDate(context);
                                added = true;
                                setState(() {});
                              }
                            },
                            child: const Icon(
                              Icons.alarm,
                              color: Color(0XFF125F61),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (added == true)
                    const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(const Color(0XFF67C1AD)),
            ),
            onPressed: () async {
              if (widget.content == null) {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return SizedBox(
                        height: 200.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Please fill the description field',
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 25.0),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0XFF67C1AD)),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Ok'))
                          ],
                        ),
                      );
                    });
              } else {
                reminder.addReminder(Reminder(widget.content, fullDate));
                Navigator.pop(context);
              }
            },
            child: const Text('Ok'),
          ),
        )
      ]),
    );
  }
}
