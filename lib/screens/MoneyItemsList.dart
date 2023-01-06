import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:my_expenses/model/money.dart';
import 'package:my_expenses/screens/addMoneyItem.dart';
import 'package:my_expenses/screens/moneyInfo.dart';
import 'package:my_expenses/viewModel/MoneyViewModel.dart';
import 'package:provider/provider.dart';

class MoneyItemsList extends StatefulWidget {
  const MoneyItemsList({Key? key}) : super(key: key);

  @override
  State<MoneyItemsList> createState() => _MoneyItemsListState();
}

class _MoneyItemsListState extends State<MoneyItemsList> {
  @override
  Widget build(BuildContext context) {
    var money = Provider.of<MoneyViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Expenses'),
        centerTitle: true,
        actions: [
          AspectRatio(
            aspectRatio: 1.5 / 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0XFF125F61)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(color: Colors.white))),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AddMoneyItem()));
                  },
                  child: const Center(
                      child: Icon(
                    Icons.add,
                    size: 15.0,
                  ))),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: const Color(0XFF67C1AD),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Year',
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              FutureBuilder(
                                  future: money.getTotalYear(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<double> totalYear) {
                                    if (totalYear.hasData) {
                                      return Text(
                                        totalYear.data.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      );
                                    } else if (totalYear.hasError) {
                                      return const Text('Error');
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Month',
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              FutureBuilder(
                                  future: money.getTotalMonth(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<double> totalMonth) {
                                    if (totalMonth.hasData) {
                                      return Text(
                                        totalMonth.data.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      );
                                    } else if (totalMonth.hasError) {
                                      return const Text('Error');
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Week',
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              FutureBuilder(
                                  future: money.getTotalWeek(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<double> totalWeek) {
                                    if (totalWeek.hasData) {
                                      return Text(
                                        totalWeek.data.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      );
                                    } else if (totalWeek.hasError) {
                                      return const Text('Error');
                                    } else {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                  }),
                            ],
                          ),
                        ]),
                    const SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
            FutureBuilder(
                future: money.getItems(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Money>> moneyList) {
                  if (moneyList.hasData) {
                    return Column(
                      children: moneyList.data!
                          .map((e) => MoneyInfo(e, e.categoryId))
                          .toList(),
                    );
                  } else if (moneyList.hasError) {
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
