import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Giải phương trình bậc nhất',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LinearEquationSolver(),
    );
  }
}

class LinearEquationSolver extends StatefulWidget {
  @override
  _LinearEquationSolverState createState() => _LinearEquationSolverState();
}

class _LinearEquationSolverState extends State<LinearEquationSolver> {
  TextEditingController aController = TextEditingController();
  TextEditingController bController = TextEditingController();
  String result = '';

  String? validateInput(String value) {
    if (value.isEmpty) {
      return 'Vui lòng nhập giá trị';
    }
    if (double.tryParse(value) == null) {
      return 'Chỉ được nhập số';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giải phương trình bậc nhất'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: aController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d*$'),
                ),
              ],
              decoration: InputDecoration(
                labelText: 'Nhập hệ số a',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            TextFormField(
              controller: bController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(
                  RegExp(r'^\d*\.?\d*$'),
                ),
              ],
              decoration: InputDecoration(
                labelText: 'Nhập hệ số b',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (validateInput(aController.text) == null && validateInput(bController.text) == null) {
                  solveEquation();
                } else {
                  setState(() {
                    result = '';
                  });
                }
              },
              child: Text('Giải'),
            ),
            SizedBox(height: 20.0),
            Text(
              result,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }

  void solveEquation() {
    double a = double.tryParse(aController.text) ?? 0;
    double b = double.tryParse(bController.text) ?? 0;

    if (a == 0) {
      setState(() {
        result =
        'Phương trình ${a}x + ${b} = 0 không phải là phương trình bậc nhất.';
      });
    } else {
      double x = -b / a;
      setState(() {
        result = 'Nghiệm của phương trình ${a}x + ${b} = 0 là: x = ${x}';
      });
    }
  }
}
