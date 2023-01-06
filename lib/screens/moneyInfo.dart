import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:my_expenses/model/money.dart';
import 'package:my_expenses/screens/editMoney.dart';
import 'package:my_expenses/viewModel/MoneyViewModel.dart';
import 'package:provider/provider.dart';

class MoneyInfo extends StatelessWidget {
  Money money;
  int? categoryId;

  MoneyInfo(this.money, this.categoryId);

  @override
  Widget build(BuildContext context) {
    var moneyViewModel = Provider.of<MoneyViewModel>(context);
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
                  children: <Widget>[
                    Row(
                      children: [
                        const Text(
                          'Amount',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          money.amount.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'Details',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          money.text,
                          style: const TextStyle(
                            // fontWeight: FontWeight.bold,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          'category',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black45),
                        ),
                        const SizedBox(
                          width: 10.0,
                        ),
                        Text(money.categoryName!),
                      ],
                    ),
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
                          '${money.date.year}/${money.date.month}/${money.date.day}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditMoneyScreen(money)));
                        },
                        child: const Icon(
                          Icons.edit,
                          color: Color(0XFF125F61),
                        )),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextButton(
                        onPressed: () {
                          moneyViewModel.deleteItem(money.id!);
                        },
                        child: const Icon(
                          Icons.delete,
                          color: Color(0XFF125F61),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
