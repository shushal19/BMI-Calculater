import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BMI APP",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomepage(),
    );
  }
}

// ignore: must_be_immutable
class MyHomepage extends StatefulWidget {
  const MyHomepage({super.key});

  @override
  State<MyHomepage> createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inchController = TextEditingController();
  var result = "";
  var finalResult = "";
  late Color bgColor = Colors.yellowAccent; // Default background color

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BMI APP"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Container(
        color: bgColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  "BMI Calculator",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 60),
              Center(
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: wtController,
                    decoration: InputDecoration(
                      label: const Text("Enter your weight (in kgs)"),
                      prefixIcon: const Icon(Icons.line_weight),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: ftController,
                    decoration: InputDecoration(
                      label: const Text("Enter your height (in feet)"),
                      prefixIcon: const Icon(Icons.height),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: SizedBox(
                  width: 300,
                  child: TextField(
                    controller: inchController,
                    decoration: InputDecoration(
                      label: const Text("Enter your height (in inches)"),
                      prefixIcon: const Icon(Icons.height),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    var wt = wtController.text.toString();
                    var feet = ftController.text.toString();
                    var inch = inchController.text.toString();
                    if (wt.isNotEmpty && feet.isNotEmpty && inch.isNotEmpty) {
                      var iWt = int.parse(wt);
                      var iFt = int.parse(feet);
                      var iInch = int.parse(inch);
                      var tInch = (iFt * 12) + iInch;
                      var tCm = tInch * 2.54;
                      var tM = tCm / 100;
                      var bmi = iWt / (tM * tM);

                      // Define BMI categories with corresponding colors
                      if (bmi > 30) {
                        finalResult = "You're Obese";
                        bgColor = Colors.red; // Obese
                      } else if (bmi >= 25 && bmi <= 30) {
                        finalResult = "You're Overweight";
                        bgColor = Colors.orange; // Overweight
                      } else if (bmi >= 18.5 && bmi < 25) {
                        finalResult = "You're Healthy!";
                        bgColor = Colors.green; // Healthy
                      } else if (bmi < 18.5) {
                        finalResult = "You're Underweight";
                        bgColor = Colors.blue.shade300; // Underweight
                      } else {
                        finalResult = "Invalid Data!";
                        bgColor = Colors.grey; // Error state
                      }

                      setState(() {
                        result =
                            "$finalResult\nYour BMI is : ${bmi.toStringAsFixed(2)}";
                      });
                    } else {
                      setState(() {
                        result = "Please fill all the required fields!";
                      });
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 128, 195, 74)),
                  ),
                  child: const Text("Calculate"),
                ),
              ),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  result,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
