import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_final_exam/utils/all_information.dart';
import 'package:flutter_final_exam/utils/helper_class/database_helper.dart';
import 'package:flutter_final_exam/utils/helper_class/func.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int num1 = 0;
  int num2 = 0;
  int? answer;
  GlobalKey<FormState> globalKey = GlobalKey();
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  String sign = "+";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Calculator"),
        actions: [
          IconButton(
            onPressed: () {
              num1Controller.clear();
              num2Controller.clear();
              answer = null;
              sign = "+";
              setState(() {});
            },
            icon: const Icon(Icons.clear),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "History_screen");
            },
            icon: const Icon(Icons.history),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: globalKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: num1Controller,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter The First Number";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Number 1",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: num2Controller,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return "Enter The Second Number";
                  } else {
                    return null;
                  }
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Enter Number 2",
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    hint: const Text("SELECT OPERATION"),
                    alignment: Alignment.center,
                    elevation: 3,
                    items: allSigns
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(
                              "$e",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      sign = val.toString();
                      setState(() {});
                    },
                    value: sign,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (answer != null)
                Text(
                  'Answer: $answer',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              const SizedBox(height: 20),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: IconButton(
                  onPressed: () async {
                    if (globalKey.currentState!.validate()) {
                      num1 = int.parse(num1Controller.text);
                      num2 = int.parse(num2Controller.text);

                      if (sign == "+") {
                        answer = FuncHelper.funcHelper
                            .addOfNumbers(a: num1, b: num2);
                      } else if (sign == "-") {
                        answer = FuncHelper.funcHelper
                            .subOfNumbers(a: num1, b: num2);
                      } else if (sign == "x") {
                        answer = FuncHelper.funcHelper
                            .mulOfNumbers(a: num1, b: num2);
                      } else if (sign == "/") {
                        answer = FuncHelper.funcHelper
                            .divOfNumbers(a: num1, b: num2);
                      }

                      await DBHelper.dbHelper.insertIntoDatabase(
                        num1: num1,
                        num2: num2,
                        operation: sign,
                        result: answer!,
                      );

                      setState(() {});

                      log("=====================================");
                      log("$answer");
                      log("=====================================");
                    }
                  },
                  icon: const Icon(Icons.calculate),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
