import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController numberOfPeopleController = TextEditingController();
  TextEditingController valueOfBillController = TextEditingController();
  String _valuePerson = 'Fill the fields';

  GlobalKey<FormState> _formkey = GlobalKey<FormState>(); //validar form


  void _calculateBills() {
    double numberOfPeople = double.parse(numberOfPeopleController.text);
    double valueOfBill = double.parse(valueOfBillController.text);
    double value = valueOfBill / numberOfPeople;

    setState(() {
      _valuePerson = "Value by person: \$${value.toStringAsPrecision(3)}";
    });
  }

  void _cleanFields() {
    setState(() {
      _valuePerson = 'Fill the fields';
      numberOfPeopleController.text = '';
      valueOfBillController.text = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Split Bills"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _cleanFields();
            },
          )
        ],
      ),
      body: SingleChildScrollView(
          //widget responsavel por permitir que a gente role a tela
          child: Padding(
        padding: EdgeInsets.all(10),
        child: Form(
          key: _formkey,
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Icon(
              Icons.monetization_on,
              size: 90,
              color: Colors.blue,
            ),

            //input people
            TextFormField(
              keyboardType: TextInputType.number,
              controller: numberOfPeopleController,
              decoration: InputDecoration(
                  labelText: "Number of people",
                  labelStyle: TextStyle(color: Colors.blue)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 18),
              validator: (value) {
                if(value?.isEmpty ?? true){
                  return 'Insert number of people';
                }
              }
            ),

            //input bill
            TextFormField(
              keyboardType: TextInputType.number,
              controller: valueOfBillController,
              decoration: InputDecoration(
                  labelText: "Bill value ",
                  labelStyle: TextStyle(color: Colors.blue)),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 18),
              validator: (value) {
                if(value?.isEmpty ?? true){
                  return 'Insert bill value';
                }
              }
            ),

            //button
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Container(
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {
                      if(_formkey.currentState?.validate() == true) {
                        _calculateBills();
                        // valueOfBillController.clear();
                        // numberOfPeopleController.clear();
                      }
                    },
                    color: Colors.blue,
                    child: Text(
                      "Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )),
            ),

            Text(
              _valuePerson,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.blue, fontSize: 18),
            ),
          ],
        )),
      )),
    );
  }
}
