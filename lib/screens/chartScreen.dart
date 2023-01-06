import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/viewModel/MoneyViewModel.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import '../model/money.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  Map<String, double> dataMap = {};

  final colorList = <Color>[
    const Color(0xfffdcb6e),
    const Color(0xff0984e3),
    const Color(0xfffd79a8),
    const Color(0xffe17055),
    const Color(0xff6c5ce7),
  ];

  ChartType? chartType = ChartType.ring;

  bool showCenterText = true;

  double? chartLegendSpacing = 32;

  bool emptyMap = true;

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
  bool percent = true;

  bool showChartValuesInPercentage() {
    if (percent == true) {
      return true;
    } else if (percent == false) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var money = Provider.of<MoneyViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Expenses Chart'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
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
                    setState(() {});
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
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
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
                    setState(() {});
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
              const SizedBox(
                height: 20.0,
              ),
              if (search == false)
                FutureBuilder(
                    future: money.getSumValues(),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Money>> moneyList) {
                      if (moneyList.hasData) {
                        moneyList.data!.forEach((element) {
                          dataMap[element.categoryName!] = element.totalAmount!;
                          emptyMap = false;
                        });
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0XFF67C1AD)),
                                      ),
                                      onPressed: () {
                                        percent = true;
                                        setState(() {});
                                      },
                                      child: const Text('Percentage'),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color(0XFF67C1AD)),
                                      ),
                                      onPressed: () {
                                        percent = false;
                                        setState(() {});
                                      },
                                      child: const Text('Numbers'),
                                    ),
                                  ],
                                ),
                              ),
                              if (emptyMap == true)
                                const Center(
                                  child: Text(
                                    'No categories',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 20.0,
                              ),
                                PieChart(
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValuesInPercentage: percent,
                                  ),
                                  dataMap: dataMap,
                                  animationDuration:
                                      const Duration(milliseconds: 1000),
                                  chartLegendSpacing: chartLegendSpacing!,
                                  colorList: colorList,
                                  chartType: chartType!,
                                  centerText:
                                      showCenterText ? "My Expenses" : null,
                                  emptyColor: Colors.grey,
                                ),
                              if (emptyMap == true)
                                const Center(
                                  child: Text(
                                    'No categories',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 80.0,
                              ),
                            ]);
                      } else if (moneyList.hasError) {
                        return const Text('Error');
                      } else {
                        return const Text('No Data');
                      }
                    }),
              if (search == true && emptyMap==false)
                FutureBuilder(
                    future: money.getTotalForCategory(
                        DateTime.parse(startDate!).millisecondsSinceEpoch,
                        DateTime.parse(endDate!).millisecondsSinceEpoch),
                    builder: (BuildContext context,
                        AsyncSnapshot<List<Money>> moneyList) {
                      dataMap.clear();
                      if (moneyList.hasData && moneyList.data!.isNotEmpty) {
                        moneyList.data!.forEach((element) {
                          dataMap[element.categoryName!] = element.totalAmount!;
                          emptyMap = false;
                        });
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            const Color(0XFF67C1AD)),
                                      ),
                                      onPressed: () {
                                        percent = true;
                                        setState(() {});
                                      },
                                      child: const Text('Percentage'),
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(
                                            const Color(0XFF67C1AD)),
                                      ),
                                      onPressed: () {
                                        percent = false;
                                        setState(() {});
                                      },
                                      child: const Text('Numbers'),
                                    ),
                                  ],
                                ),
                              ),
                              if(emptyMap==false)
                                PieChart(
                                  chartValuesOptions: ChartValuesOptions(
                                    showChartValuesInPercentage: percent,
                                  ),
                                  dataMap: dataMap,
                                  animationDuration:
                                  const Duration(milliseconds: 1000),
                                  chartLegendSpacing: chartLegendSpacing!,
                                  colorList: colorList,
                                  chartType: chartType!,
                                  centerText:
                                  showCenterText ? "My Expenses" : null,
                                  emptyColor: Colors.grey,
                                ),


                              if (emptyMap == true)
                                const Center(
                                  child: Text(
                                    'No categories',
                                    style: TextStyle(
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),

                              const SizedBox(
                                height: 80.0,
                              ),
                            ]);
                      } else if (moneyList.hasError) {
                        return const Text('Error');
                      } else {
                        return const Text('No Data');
                      }
                    }),
            ]),
          ),
        ),
      ),
    );
  }
}
