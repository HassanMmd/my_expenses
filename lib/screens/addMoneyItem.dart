import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/model/category.dart';
import 'package:my_expenses/model/money.dart';
import 'package:my_expenses/viewModel/MoneyViewModel.dart';
import 'package:my_expenses/viewModel/categoryViewModel.dart';
import 'package:provider/provider.dart';

class AddMoneyItem extends StatefulWidget {
  const AddMoneyItem({Key? key}) : super(key: key);

  @override
  State<AddMoneyItem> createState() => _AddMoneyItemState();
}

class _AddMoneyItemState extends State<AddMoneyItem> {
  TextEditingController dateInput = TextEditingController();

  double? amount;
  String? text;
  Category? dropdownValue;
  String? date;
  String? addedCategory;

  List<Category> lisst = [];
  String? categoryText;

  Category? getselectedDropDownValue() {
    if (lisst.contains(dropdownValue)) {
      return dropdownValue;
    }
    return null;
  }

  @override
  void initState() {
    dateInput.text = '';
  }

  @override
  Widget build(BuildContext context) {
    var money = Provider.of<MoneyViewModel>(context);
    var categoryViewModel = Provider.of<CategoryViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add your expenses'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              SizedBox(
                child: TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    amount = double.parse(value);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Amount*',
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
                height: 8.0,
              ),
              SizedBox(
                height: 50,
                width: 350,
                child: TextField(
                  controller: dateInput,
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
                        dateInput.text = formattedDate;
                        date = dateInput.text;
                        //set output date to TextField value.
                      });
                    } else {}
                  },
                  // textAlign: TextAlign.center,
                  onChanged: (value) {
                    date = value;
                  },
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    hintText: 'Date*',
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
              SizedBox(
                height: 27.0,
              ),
              SizedBox(
                child: TextField(
                  maxLength: 40,
                  onChanged: (value) {
                    text = value;
                  },
                  decoration: const InputDecoration(
                    hintText: 'Details*',
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
                height: 15.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Category',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0))),
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 500.0,
                              child: Padding(
                                padding: EdgeInsets.all(30.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          hintText: 'Add Category*',
                                          hintStyle: TextStyle(
                                              color: Color(0XFFC3BCBC)),
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 10.0, horizontal: 10.0),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30.0)),
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
                                        onChanged: (value) {
                                          addedCategory = value;
                                          setState(() {});
                                        },
                                        maxLength: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 25.0),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color(0XFF67C1AD)),
                                            ),
                                            onPressed: () async {
                                              if (addedCategory == null) {
                                                showModalBottomSheet(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return SizedBox(
                                                      height: 200.0,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Text(
                                                            'Please fill the field',
                                                            style: TextStyle(
                                                                fontSize: 20.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                          const SizedBox(
                                                              height: 25.0),
                                                          ElevatedButton(
                                                              style:
                                                                  ButtonStyle(
                                                                backgroundColor:
                                                                    MaterialStateProperty.all(
                                                                        const Color(
                                                                            0XFF67C1AD)),
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'Ok')),
                                                        ],
                                                      ),
                                                    );
                                                  },
                                                );
                                              } else {
                                                Category category =
                                                    Category(addedCategory!);
                                                category.id =
                                                    await categoryViewModel
                                                        .addCategory(category);

                                                Navigator.pop(context);
                                                dropdownValue = category;
                                                setState(() {});
                                              }
                                            },
                                            child: const Text('Ok')),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      const Color(0XFF67C1AD)),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel')),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: const Icon(
                      Icons.add_box_rounded,
                      color: Color(0XFF67C1AD),
                      size: 40.0,
                    ),
                  ),
                  FutureBuilder(
                      future: categoryViewModel.getCategory(),
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Category>> categoryList) {
                        // lisst.add('..');

                        // print(date);
                        print(lisst);
                        if (categoryList.hasData) {
                          lisst = categoryList.data!;

                          return DropdownButton<Category>(
                            value: getselectedDropDownValue(),
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 1.0,
                              color: Colors.green,
                            ),
                            onChanged: (Category? value) {
                              setState(() {
                                dropdownValue = value!;
                              });
                            },
                            items: lisst.map((Category value) {
                              return DropdownMenuItem<Category>(
                                value: value,
                                child: Text(value.text),
                              );
                            }).toList(),
                          );
                        } else if (categoryList.hasError) {
                          return const Text('Error');
                        } else {
                          return const Text('No Data');
                        }
                      }),
                ],
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0XFF67C1AD)),
                      ),
                      onPressed: () async {
                        if (amount == null || text == null || dropdownValue==null) {
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
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    const Color(0XFF67C1AD)),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Ok')),
                                    ],
                                  ),
                                );
                              });
                        } else {
                          categoryText = addedCategory;
                          await money.addItem(Money(
                              amount!,
                              text!,
                              DateTime.parse(date!),
                              getselectedDropDownValue()!.id));
                          setState(() {});
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Add')),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0XFF67C1AD)),
                      ),
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: Text('Cancel'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
