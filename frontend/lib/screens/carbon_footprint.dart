import 'package:earthling/main.dart';
import 'package:earthling/screens/suggestions_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class carbonFootprint extends StatefulWidget {
  @override
  _carbonFootprintState createState() => _carbonFootprintState();
}

class _carbonFootprintState extends State<carbonFootprint> {
  Map<String, dynamic> household = {
    "Electricity": 0.0,
    "Natural Gas": 0.0,
    "Fuel Oil": 0.0,
    "LPG": 0.0,
    "Waste": 0.0,
  };

  Map<String, dynamic> food = {
    "Lamb": 0.0,
    "Beef": 0.0,
    "Cheese": 0.0,
    "Pork": 0.0,
    "Chicken": 0.0,
    "Eggs": 0.0,
    "Potatoes": 0.0,
    "Rice": 0.0,
    "Nuts": 0.0,
    "Beans": 0.0,
    "Vegetables": 0.0,
    "Milk": 0.0,
    "Fruit": 0.0,
    "Lentils": 0.0,
  };

  Map<String, dynamic> travel = {
    "Diesel": 0.0,
    "Petrol": 0.0,
    "LPG": 0.0,
    "CNG": 0.0,
  };

  Map<String, dynamic> other = {
    "Paper": 0.0,
  };

  double carbon_footprint = 0;

  void saveValue(inputList, key, value) {
    setState(() {
      inputList[key] = double.parse(value);
      calculateCF();
      saveMaps();
    });
  }

  void calculateCF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      carbon_footprint = household["Electricity"] * 0.35 +
          household["Natural Gas"] * 6.6 +
          household["Fuel Oil"] * 3.1 +
          household["LPG"] * 1.8 +
          household["Waste"] * 0.715 +
          food["Lamb"] * 39.2 +
          food["Beef"] * 27 +
          food["Cheese"] * 13.5 +
          food["Pork"] * 12.1 +
          food["Chicken"] * 6.9 +
          food["Eggs"] * 4.8 +
          food["Potatoes"] * 2.9 +
          food["Rice"] * 2.7 +
          food["Nuts"] * 2.3 +
          food["Beans"] * 2 +
          food["Vegetables"] * 2 +
          food["Milk"] * 1.9 +
          food["Fruit"] * 1.1 +
          food["Lentils"] * 0.9 +
          travel["Diesel"] * 2.64 +
          travel["Petrol"] * 2.39 +
          travel["LPG"] * 1.6 +
          travel["CNG"] * 2.6 +
          other["Paper"] * 0.647;
      prefs.setDouble('carbon_footprint', carbon_footprint);
    });
  }

  void saveMaps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var h = json.encode(household);
    var f = json.encode(food);
    var t = json.encode(travel);
    var o = json.encode(other);

    prefs.setString('household', h);
    prefs.setString('food', f);
    prefs.setString('travel', t);
    prefs.setString('other', o);
  }

  void retrieve_maps() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue1 = prefs.getString('household');
    String stringValue2 = prefs.getString('food');
    String stringValue3 = prefs.getString('travel');
    String stringValue4 = prefs.getString('other');
    setState(() {
      print(stringValue1);
      if (stringValue1 != null) household = json.decode(stringValue1);
      if (stringValue2 != null) food = json.decode(stringValue2);
      if (stringValue3 != null) travel = json.decode(stringValue3);
      if (stringValue4 != null) other = json.decode(stringValue4);
    });
  }

  getCFValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    setState(() {
      double car_f = prefs.getDouble('carbon_footprint');
      print(car_f);
      if (car_f != null) {
        carbon_footprint = car_f;
      } else {
        carbon_footprint = 0.0;
      }
    });
  }

  @override
  void initState() {
    setState(() {
      retrieve_maps();
      getCFValues();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);
      },
      child: Scaffold(
          backgroundColor: Color(0xFF3D3D3D),
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xFF3D3D3D),
            elevation: 0,
            leading: BackButton(
              color: Color(0xFFFFFFFF),
            ),
            title: Text(
              "Carbon Footprint",
              style: TextStyle(fontSize: width * 0.06),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
              return Container(
                child: ListView(
                  children: [
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            padding: EdgeInsets.only(right: 25),
                            decoration: BoxDecoration(
                                border: Border(
                              right: BorderSide(
                                //                   <--- left side
                                color: Colors.white,
                                width: 1.0,
                              ),
                            )),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  height: 0.082 * constraints.maxHeight,
                                  image: AssetImage('images/icon/co2.png'),
                                  fit: BoxFit.fill,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Text(
                                    carbon_footprint <= 9999
                                        ? carbon_footprint.toStringAsFixed(3)
                                        : "9999",
                                    style: TextStyle(
                                      fontSize: 0.07 * width,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 0),
                                  child: Text(
                                    "Kgs/month",
                                    style: TextStyle(
                                      fontSize: 0.03 * width,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: 0.082 * constraints.maxHeight,
                                height: 0.082 * constraints.maxHeight,
                                child: RawMaterialButton(
                                  fillColor: Color(0xFFA5C528),
                                  shape: CircleBorder(),
                                  elevation: 1,
                                  child: Icon(
                                    Icons.arrow_forward,
                                    color: Color(0xFF3D3D3D),
                                    size: 0.028 * constraints.maxHeight,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              suggestionScreen(),
                                        ));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  "Suggestions",
                                  style: TextStyle(
                                    fontSize: 0.07 * width,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 0),
                                child: Text(
                                  "Cut your emissions!",
                                  style: TextStyle(
                                    fontSize: 0.03 * width,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 35,
                          left: 35,
                          right: 35,
                          top: 35,
                        ),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 25, bottom: 25, left: 25),
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Text(
                                  "Household",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 0.05 * width,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 0.08 * width,
                              ),
                              Column(
                                children: [
                                  inputWidgets(
                                      "Electricity",
                                      household["Electricity"],
                                      household,
                                      "kWh/month",
                                      saveValue),
                                  inputWidgets(
                                      "Natural Gas",
                                      household["Natural Gas"],
                                      household,
                                      "therms/month",
                                      saveValue),
                                  inputWidgets(
                                      "Fuel Oil",
                                      household["Fuel Oil"],
                                      household,
                                      "litres/month",
                                      saveValue),
                                  inputWidgets("LPG", household["LPG"],
                                      household, "litres/month", saveValue),
                                  inputWidgets("Waste", household["Waste"],
                                      household, "kgs/month", saveValue),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 35,
                          left: 35,
                          right: 35,
                        ),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 25, bottom: 25, left: 25),
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Text(
                                  "Food",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 0.05 * width,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 0.08 * width,
                              ),
                              Column(
                                children: [
                                  inputWidgets("Lamb", food["Lamb"], food,
                                      "kgs/month", saveValue),
                                  inputWidgets("Beef", food["Beef"], food,
                                      "kgs/month", saveValue),
                                  inputWidgets("Cheese", food["Cheese"], food,
                                      "kgs/month", saveValue),
                                  inputWidgets("Pork", food["Pork"], food,
                                      "kgs/month", saveValue),
                                  inputWidgets("Chicken", food["Chicken"], food,
                                      "kgs/month", saveValue),
                                  inputWidgets("Eggs", food["Eggs"], food,
                                      "kgs/month", saveValue),
                                  inputWidgets("Potatoes", food["Potatoes"],
                                      food, "kgs/month", saveValue),
                                  inputWidgets("Rice", food["Rice"], food,
                                      "kgs/month", saveValue),
                                  inputWidgets("Nuts", food["Nuts"], food,
                                      "kgs/month", saveValue),
                                  inputWidgets("Vegetables", food["Vegetables"],
                                      food, "kgs/month", saveValue),
                                  inputWidgets("Milk", food["Milk"], food,
                                      "kgs/month", saveValue),
                                  inputWidgets("Fruit", food["Fruit"], food,
                                      "kgs/month", saveValue),
                                  inputWidgets("Lentils", food["Lentils"], food,
                                      "kgs/month", saveValue),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 35,
                          left: 35,
                          right: 35,
                        ),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 25, bottom: 25, left: 25),
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Text(
                                  "Traveling",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 0.05 * width,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 0.08 * width,
                              ),
                              Column(
                                children: [
                                  inputWidgets("Diesel", travel["Diesel"], food,
                                      "litres/mo", saveValue),
                                  inputWidgets("Petrol", travel["Petrol"], food,
                                      "litres/mo", saveValue),
                                  inputWidgets("LPG", travel["LPG"], food,
                                      "litres/mo", saveValue),
                                  inputWidgets("CNG", travel["CNG"], food,
                                      "litres/mo", saveValue),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 35,
                          left: 35,
                          right: 35,
                        ),
                        child: Container(
                          padding:
                              EdgeInsets.only(top: 25, bottom: 25, left: 25),
                          width: width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Text(
                                  "Other",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 0.05 * width,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(
                                height: 0.08 * width,
                              ),
                              Column(
                                children: [
                                  inputWidgets("Paper", other["Paper"], food,
                                      "kgs/month", saveValue),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          )),
    );
  }
}

class inputWidgets extends StatefulWidget {
  String object;
  double value;
  String unit;
  Map<String, dynamic> inputList;
  Function saveValue;
  inputWidgets(
      this.object, this.value, this.inputList, this.unit, this.saveValue);

  @override
  _inputWidgetsState createState() => _inputWidgetsState();
}

class _inputWidgetsState extends State<inputWidgets> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              widget.object,
              style: TextStyle(
                fontSize: 0.04 * width,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      initialValue: widget.value.toStringAsFixed(2),
                      keyboardType: TextInputType.number,
                      onChanged: (text) {
                        if (text == "")
                          widget.saveValue(
                              widget.inputList, widget.object, "0");
                        else
                          widget.saveValue(
                              widget.inputList, widget.object, text);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.unit,
                style: TextStyle(
                  fontSize: 0.04 * width,
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
