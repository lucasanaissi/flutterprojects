import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  String _infoText = "Informe ses dados!";
  String? _errorTextHeight = "";
  String? _errorTextWeight = "";

  void _resetFields() {
    heightController.text = '';
    weightController.text = '';
    _infoText = "Informe seus dados!";
  }

  void _calculate() {
    double height = double.parse(heightController.text);
    double weight = double.parse(weightController.text);
    double bmi = weight / (height * height);
    bmi = bmi * 10000;

    if (bmi < 18.5) {
      _infoText = "Magreza (IMC: ${bmi})";
    } else if (bmi >= 18.5 && bmi < 24.9) {
      _infoText = "Normal (IMC: ${bmi})";
    } else if (bmi >= 24.9 && bmi < 30.0) {
      _infoText = "Sobrepeso (IMC: ${bmi})";
    } else {
      _infoText = "Obesidade (IMC: ${bmi})";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          CupertinoIcons.person_alt,
          color: Colors.lightBlue,
        ),
        title: const Text(
          'Calculadora de IMC',
          style: TextStyle(
            color: Colors.lightBlue,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.grey[100],
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _resetFields();
                _errorTextHeight = null;
                _errorTextWeight = null;
              });
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.lightBlue,
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.person_outline,
                size: 200,
                color: Colors.lightBlue,
              ),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                controller: weightController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _errorTextWeight,
                  labelText: 'Insira o peso. (Em kg)',
                  labelStyle: const TextStyle(
                    color: Colors.lightBlue,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                controller: heightController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  errorText: _errorTextHeight,
                  labelText: 'Insira a altura. (Em cm)',
                  labelStyle: const TextStyle(
                    color: Colors.lightBlue,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      if (weightController.text.isEmpty && heightController.text.isEmpty) {
                        setState(() {
                          _errorTextHeight = 'Insira o peso!';
                          _errorTextWeight = 'Insira a altura!';
                        });
                      } else if (weightController.text.isEmpty) {
                        setState(() {
                          _errorTextWeight = 'Insira a altura!';
                        });
                      } else if (heightController.text.isEmpty) {
                        setState(() {
                          _errorTextHeight = 'Insira o peso!';
                        });
                      } else {
                        setState(() {
                          _calculate();
                          _errorTextHeight = null;
                          _errorTextWeight = null;
                        });
                      }
                    },
                    child: const Text(
                      'Calcular o IMC',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _infoText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.lightBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
