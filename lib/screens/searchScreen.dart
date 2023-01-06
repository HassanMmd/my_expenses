import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/viewModel/MoneyViewModel.dart';
import '../model/money.dart';
import 'moneyInfo.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController dateInputStartDate = TextEditingController();
  TextEditingController dateInputEndDate = TextEditingController();

  @override
  void initState() {
    dateInputStartDate.text = '';
    dateInputEndDate.text = '';
    super.initState();
  }

  bool search = false;
  String? startDate;
  String? endDate;

  @override
  Widget build(BuildContext context) {
    MoneyViewModel moneyViewModel = MoneyViewModel();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
                width: 350,
                child: TextField(
                  controller: dateInputStartDate,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dateInputStartDate.text = formattedDate;
                        startDate = dateInputStartDate.text;
                        //set output date to TextField value.
                      });
                    } else {}
                  },
                  // textAlign: TextAlign.center,
                  onChanged: (value) {
                    startDate = value;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    hintText: 'Start date*',
                    hintStyle: TextStyle(color: Color(0XFFC3BCBC)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
                height: 30.0,
              ),
              SizedBox(
                height: 50,
                width: 350,
                child: TextField(
                  controller: dateInputEndDate,
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      print(
                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(
                          formattedDate); //formatted date output using intl package =>  2021-03-16
                      setState(() {
                        dateInputEndDate.text = formattedDate;
                        endDate = dateInputEndDate.text;
                        //set output date to TextField value.
                      });
                    } else {}
                  },
                  // textAlign: TextAlign.center,
                  onChanged: (value) {
                    endDate = value;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    hintText: 'End date*',
                    hintStyle: TextStyle(color: Color(0XFFC3BCBC)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
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
                height: 30.0,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0XFF67C1AD)),
                ),
                onPressed: () {
                  if (startDate == null || endDate == null) {
                    showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 200.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Please fill all the fields',
                                style: TextStyle(
                                    fontSize: 20.0,
                                    fontWeight: FontWeight.bold),
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
                                  child: const Text('Ok')),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    search = true;
                    setState(() {});
                  }
                },
                child: const Icon(Icons.search),
              ),
              if (search == true)
                FutureBuilder(
                    future: moneyViewModel.getMoneyByDate(
                        DateTime.parse(startDate!).millisecondsSinceEpoch,
                        DateTime.parse(endDate!).millisecondsSinceEpoch),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Money>> moneyListByDate) {
                      if (moneyListByDate.hasData) {
                        return Column(
                          children: moneyListByDate.data!
                              .map((e) => MoneyInfo(e, e.categoryId))
                              .toList(),
                        );
                      } else if (moneyListByDate.hasError) {
                        return const Text('Error');
                      } else {
                        return const Text('No Data');
                      }
                    }),
            ],
          ),
        ),
      ),
    );
  }
}
