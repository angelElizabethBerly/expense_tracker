// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expense_tracker/constants/color_constants.dart';
import 'package:expense_tracker/controller/home_screen_controller.dart';
import 'package:expense_tracker/view/add_record_screen/add_record_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  fetchData() async {
    await HomeScreenController.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.primaryBlack,
        leading: Padding(
          padding: EdgeInsets.only(
            left: 20,
          ),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://images.pexels.com/photos/1772475/pexels-photo-1772475.jpeg?auto=compress&cs=tinysrgb&w=600"),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Hello Angel",
                style: TextStyle(
                    color: ColorConstant.primaryWhite,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
            Text(
              "Welcome Back!",
              style: TextStyle(
                  color: ColorConstant.primaryWhite.withOpacity(0.8),
                  fontSize: 15),
            )
          ],
        ),
        actions: [
          Icon(Icons.segment, color: ColorConstant.primaryWhite),
          SizedBox(width: 20)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              decoration: BoxDecoration(
                  color: ColorConstant.primaryBlack,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Balance",
                    style: TextStyle(
                        fontSize: 25,
                        color: ColorConstant.primaryWhite.withOpacity(0.6)),
                  ),
                  Text(
                    "\$14,564",
                    style: TextStyle(
                        fontSize: 40,
                        color: ColorConstant.primaryWhite,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 80,
                        width: 150,
                        decoration: BoxDecoration(
                            color: ColorConstant.primaryWhite,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_circle_up,
                                color: ColorConstant.primaryGreen,
                                size: 40,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Income",
                                    style: TextStyle(
                                        color: ColorConstant.primaryGreen),
                                  ),
                                  Text(
                                    "\$2653",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  )
                                ],
                              )
                            ]),
                      ),
                      Container(
                        height: 80,
                        width: 150,
                        decoration: BoxDecoration(
                            color: ColorConstant.primaryWhite,
                            borderRadius: BorderRadius.circular(15)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_circle_down,
                                color: ColorConstant.primaryRed,
                                size: 40,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Expense",
                                    style: TextStyle(
                                        color: ColorConstant.primaryRed),
                                  ),
                                  Text(
                                    "\$4561",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  )
                                ],
                              )
                            ]),
                      )
                    ],
                  )
                ],
              ),
            ),
            // SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Recent Transactions",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            Column(
              children: List.generate(
                  HomeScreenController.transactionList.length,
                  (index) => Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 20),
                        child: ListTile(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: ColorConstant.primaryBlack
                                      .withOpacity(0.2))),
                          leading: HomeScreenController
                                      .transactionList[index].transactionType ==
                                  "Income"
                              ? Icon(
                                  Icons.arrow_circle_up,
                                  color: ColorConstant.primaryGreen,
                                  size: 40,
                                )
                              : Icon(
                                  Icons.arrow_circle_down,
                                  color: ColorConstant.primaryRed,
                                  size: 40,
                                ),
                          title: Text(
                            HomeScreenController.transactionList[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(HomeScreenController
                              .transactionList[index].category),
                          trailing: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '\$${HomeScreenController.transactionList[index].amount.toString()}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              Text(HomeScreenController
                                  .transactionList[index].date)
                            ],
                          ),
                        ),
                      )),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddRecordScreen(),
              ));
        },
        backgroundColor: ColorConstant.primaryBlack,
        child: Icon(
          Icons.add,
          color: ColorConstant.primaryWhite,
        ),
      ),
    );
  }
}
