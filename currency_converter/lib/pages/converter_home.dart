import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:currency_converter/main.dart';
import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController dolarController = TextEditingController();
  TextEditingController euroController = TextEditingController();
  TextEditingController realController = TextEditingController();

  double dolar = 0;
  double euro = 0;

  void _dolarChanged(String text) {
    double dolar = double.parse(text);
    print(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  void _realChanged(String text) {
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        toolbarHeight: 70,
        leading: const Icon(
          CupertinoIcons.money_dollar,
          color: Colors.white,
          size: 40,
        ),
        title: const Text(
          'Conversor',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Map>(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Center(
                  child: Text(
                    'Carregando dados...',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              case ConnectionState.waiting:
                return const Center(
                  child: Text(
                    'Carregando dados...',
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 25.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              default:
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Carregando dados...',
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 25.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  dolar = snapshot.data!["results"]["currencies"]["USD"]["buy"];
                  euro = snapshot.data!["results"]["currencies"]["EUR"]["buy"];

                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            size: 150.0,
                            color: Colors.amber,
                          ),
                          const SizedBox(height: 10),
                          buildTextField(
                            "Dolár - US\$",
                            "US\$ ",
                            dolarController,
                            _dolarChanged,
                          ),
                          const SizedBox(height: 10),
                          buildTextField(
                            "Euro - €",
                            "€ ",
                            euroController,
                            _euroChanged,
                          ),
                          const SizedBox(height: 10),
                          buildTextField(
                            "Real - R\$",
                            "R\$ ",
                            realController,
                            _realChanged,
                          ),
                        ],
                      ),
                    ),
                  );
                }
            }
          }),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function function) {
  return TextField(
    keyboardType: TextInputType.number,
    controller: c,
    decoration: InputDecoration(
      border: const OutlineInputBorder(),
      prefixText: prefix,
      labelText: label,
      labelStyle: const TextStyle(
        color: Colors.amber,
        fontSize: 15,
      ),
    ),
    onChanged: (text) {
      function(text);
    },
  );
}
