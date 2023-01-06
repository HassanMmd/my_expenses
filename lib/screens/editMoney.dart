import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_expenses/model/category.dart';
import 'package:my_expenses/model/money.dart';
import 'package:my_expenses/screens/mainScreen.dart';
import 'package:my_expenses/viewModel/MoneyViewModel.dart';
import 'package:my_expenses/viewModel/categoryViewModel.dart';
import 'package:provider/provider.dart';

class EditMoneyScreen extends StatefulWidget {
  Money? moneyToEdit;

  EditMoneyScreen(this.moneyToEdit);

  @override
  State<EditMoneyScreen> createState() => _EditMoneyScreenState();
}

class _EditMoneyScreenState extends State<EditMoneyScreen> {
  TextEditingController dateInput = TextEditingController();

  double? amount;
  String? text;
  Category? dropdownValue;
  String? date;
  String? addedCategory;

  List<Category> lisst = [];
  String? categoryText;

  Category? getSelectedDropDownValue() {
    if (lisst.contains(dropdownValue)) {
      return dropdownValue;
    }
    return null;
  }

  @override
  void initState() {
    dateInput.text = widget.moneyToEdit!.date.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var money = Provider.of<MoneyViewModel>(context);
    var categoryViewModel = Provider.of<CategoryViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              SizedBox(
                child: TextFormField(
                  initialValue: widget.moneyToEdit?.amount.toString(),
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    var amount = value.isEmpty ? 0.0: double.parse(value);
                      widget.moneyToEdit?.amount = amount;
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
                        lastDate: DateTime(2100));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('yyyy-MM-dd').format(pickedDate);
                      setState(() {
                        dateInput.text = formattedDate;
                        widget.moneyToEdit?.date =
                            DateTime.parse(formattedDate);
                        //set output date to TextField value.
                      });
                    } else {}
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
              const SizedBox(
                height: 27.0,
              ),
              SizedBox(
                child: TextFormField(
                  initialValue: widget.moneyToEdit?.text,
                  maxLength: 40,
                  onChanged: (value) {
                    widget.moneyToEdit?.text = value;
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
                  const SizedBox(
                    height: 10.0,
                  ),
                  TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0))),
                          context: context,
                          builder: (BuildContext context) {
                            return SizedBox(
                              height: 500.0,
                              child: Padding(
                                padding: const EdgeInsets.all(30.0),
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
                        if (categoryList.hasData) {
                          var filterd = lisst.where((element) =>
                              element.id == widget.moneyToEdit?.categoryId);
                          if (filterd.isNotEmpty && dropdownValue == null) {
                            dropdownValue = filterd.first;
                          }
                          lisst = categoryList.data!;
                          return DropdownButton<Category>(
                            value: getSelectedDropDownValue(),
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
                                widget.moneyToEdit?.categoryId = value.id;
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
                        if (amount == 6) {
                          showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return SizedBox(
                                  height: 200.0,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Text(
                                        'Please fill The fields',
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
                          await money.editMoney(widget.moneyToEdit!);
                          setState(() {});
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MainScreen()));
                        }
                      },
                      child: const Text('Save')),
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
