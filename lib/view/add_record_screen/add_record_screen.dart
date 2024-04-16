// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expense_tracker/constants/color_constants.dart';
import 'package:expense_tracker/controller/home_screen_controller.dart';
import 'package:expense_tracker/view/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddRecordScreen extends StatefulWidget {
  const AddRecordScreen({super.key});

  @override
  State<AddRecordScreen> createState() => _AddRecordScreenState();
}

class _AddRecordScreenState extends State<AddRecordScreen> {
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  String? transaction;
  String? selectedCategory;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Record",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Radio(
                            value: "Income",
                            groupValue: transaction,
                            onChanged: (value) {
                              transaction = value;
                              setState(() {});
                            }),
                        Text("Income")
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Radio(
                            value: "Expense",
                            groupValue: transaction,
                            onChanged: (value) {
                              transaction = value;
                              setState(() {});
                            }),
                        Text("Expense")
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                "Amount",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextFormField(
                controller: amountController,
                decoration: InputDecoration(
                    hintText: "Enter Amount",
                    border: OutlineInputBorder(borderSide: BorderSide())),
              ),
              SizedBox(height: 10),
              Text(
                "Category",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              InputDecorator(
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderSide: BorderSide())),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: selectedCategory,
                    hint: Text("Select Category"),
                    items: [
                      DropdownMenuItem(value: "1", child: Text("Food")),
                      DropdownMenuItem(value: "2", child: Text("Personal")),
                      DropdownMenuItem(value: "3", child: Text("Books")),
                      DropdownMenuItem(value: "4", child: Text("Shopping")),
                    ],
                    onChanged: (value) {
                      selectedCategory = value;

                      setState(() {});
                      (() {});
                    },
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Date",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                    hintText: "Select Date",
                    border: OutlineInputBorder(borderSide: BorderSide()),
                    suffixIcon: IconButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2034));
                          if (selectedDate != null) {
                            String formattedDate =
                                DateFormat('MMMMEEEEd').format(selectedDate);
                            dateController.text = formattedDate.toString();
                          }
                          setState(() {});
                        },
                        icon: Icon(Icons.calendar_month))),
              ),
              SizedBox(height: 10),
              Text(
                "Notes",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "Enter Notes",
                    border: OutlineInputBorder(borderSide: BorderSide())),
              ),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    String showCategory = "";
                    if (selectedCategory == "1") {
                      showCategory = "Food";
                    } else if (selectedCategory == "2") {
                      showCategory = "Personal";
                    } else if (selectedCategory == "3") {
                      showCategory = "Books";
                    } else {
                      showCategory = "Shopping";
                    }
                    await HomeScreenController.addData(
                        type: transaction!,
                        title: titleController.text,
                        category: showCategory ?? "",
                        date: dateController.text,
                        amount: int.parse(amountController.text));
                    setState(() {});
                    await HomeScreenController.getAllData();

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  },
                  style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.symmetric(horizontal: 120)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                      backgroundColor:
                          MaterialStatePropertyAll(ColorConstant.primaryBlack)),
                  child: Text(
                    "Add Record",
                    style: TextStyle(color: ColorConstant.primaryWhite),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
