import 'package:earthling/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PMI_calculator extends StatefulWidget {
  @override
  _PMI_calculatorState createState() => _PMI_calculatorState();
}

class _PMI_calculatorState extends State<PMI_calculator> {
  Map<String, int> FoodandKitchen = {
    "Softdrink Bottles": 0,
    "Plastic Bags": 0,
    "Food Wrappers": 0,
    "Yoghurt Containers": 0
  };
  Map<String, int> bathroom = {
    "Cotton Swabs": 0,
    "Refill packets": 0,
    "Toothbrushes": 0,
    "Toothpastes": 0,
    "Detergent, cleaning products bottles": 0,
    "Shampoo, Shower Gel, Cosmetics bottles": 0
  };
  Map<String, int> containersandPackaging = {
    "Take-away Plastic Box": 0,
    "Take-away Plastic Cup": 0,
    "Straws": 0,
    "Disposable Cutlery": 0,
    "Plastic Plates": 0,
  };

  double pmi = 0;

  void incrementValues(value, inputList) {
    setState(() {
      if (inputList[value] >= 0) {
        inputList[value] = inputList[value] + 1;
        calculatePMI();
      }
    });
  }

  void decrementValues(value, inputList) {
    setState(() {
      if (inputList[value] > 0) {
        inputList[value] = inputList[value] - 1;
        calculatePMI();
      }
    });
  }

  void calculatePMI() {
    setState(() {
      pmi = FoodandKitchen["Plastic Bags"] * (0.4 / 52) +
          FoodandKitchen["Softdrink Bottles"] * (1.9 / 52) +
          FoodandKitchen["Food Wrappers"] * (0.8 / 52) +
          FoodandKitchen["Yoghurt Containers"] * (0.8 / 52) +
          bathroom["Cotton Swabs"] * (0.1 / 52) +
          bathroom["Refill packets"] * (0.034 / 52) +
          bathroom["Toothbrushes"] * (0.020 / 52) +
          bathroom["Toothpastes"] * (0.015 / 52) +
          bathroom["Detergent, cleaning products bottles"] * (0.2 / 52) +
          bathroom["Shampoo, Shower Gel, Cosmetics bottles"] * (0.2 / 52) +
          containersandPackaging["Take-away Plastic Box"] * (1.7 / 52) +
          containersandPackaging["Take-away Plastic Cup"] * (1 / 52) +
          containersandPackaging["Straws"] * (0.53 / 52) +
          containersandPackaging["Disposable Cutlery"] * (0.015 / 52) +
          containersandPackaging["Plastic Plates"] * (0.287 / 52);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    //TODO will pop scope
    return Scaffold(
        backgroundColor: Color(0xFF3D3D3D),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xFF3D3D3D),
          elevation: 0,
          leading: BackButton(
            color: Color(0xFFFFFFFF),
          ),
          title: Text(
            "PMI Check",
            style: TextStyle(fontSize: width * 0.06, letterSpacing: 1.3),
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
                                image: AssetImage('images/icon/pmi.png'),
                                fit: BoxFit.fill,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  pmi.toStringAsFixed(3),
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
                                  "Kgs/week",
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
                                  //TODO navigate to suggestions
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
                                "Decrease your PMI",
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
                      padding: const EdgeInsets.all(35),
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
                                "Food and Kitchen needs",
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
                                    decrementValues,
                                    incrementValues,
                                    "Softdrink Bottles",
                                    FoodandKitchen["Softdrink Bottles"],
                                    FoodandKitchen),
                                inputWidgets(
                                    decrementValues,
                                    incrementValues,
                                    "Plastic Bags",
                                    FoodandKitchen["Plastic Bags"],
                                    FoodandKitchen),
                                inputWidgets(
                                    decrementValues,
                                    incrementValues,
                                    "Food Wrappers",
                                    FoodandKitchen["Food Wrappers"],
                                    FoodandKitchen),
                                inputWidgets(
                                    decrementValues,
                                    incrementValues,
                                    "Yoghurt Containers",
                                    FoodandKitchen["Yoghurt Containers"],
                                    FoodandKitchen),
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
                                "Bathroom and Laundry",
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
                                    decrementValues,
                                    incrementValues,
                                    "Cotton Swabs",
                                    bathroom["Cotton Swabs"],
                                    bathroom),
                                inputWidgets(
                                    decrementValues,
                                    incrementValues,
                                    "Refill packets",
                                    bathroom["Refill packets"],
                                    bathroom),
                                inputWidgets(
                                    decrementValues,
                                    incrementValues,
                                    "Toothbrushes",
                                    bathroom["Toothbrushes"],
                                    bathroom),
                                inputWidgets(
                                    decrementValues,
                                    incrementValues,
                                    "Detergent, cleaning products bottles",
                                    bathroom[
                                        "Detergent, cleaning products bottles"],
                                    bathroom),
                                inputWidgets(
                                    decrementValues,
                                    incrementValues,
                                    "Toothpastes",
                                    bathroom["Toothpastes"],
                                    bathroom),
                                inputWidgets(
                                    decrementValues,
                                    incrementValues,
                                    "Shampoo, Shower Gel, Cosmetics bottles",
                                    bathroom[
                                        "Shampoo, Shower Gel, Cosmetics bottles"],
                                    bathroom),
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
                                "Disposable Containers and Packaging",
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
                                    decrementValues,
                                    incrementValues,
                                    "Take-away Plastic Box",
                                    containersandPackaging[
                                        "Take-away Plastic Box"],
                                    containersandPackaging),
                                inputWidgets(
                                    decrementValues,
                                    incrementValues,
                                    "Take-away Plastic Cup",
                                    containersandPackaging[
                                        "Take-away Plastic Cup"],
                                    containersandPackaging),
                                inputWidgets(
                                    decrementValues,
                                    incrementValues,
                                    "Straws",
                                    containersandPackaging["Straws"],
                                    containersandPackaging),
                                inputWidgets(
                                    decrementValues,
                                    incrementValues,
                                    "Disposable Cutlery",
                                    containersandPackaging[
                                        "Disposable Cutlery"],
                                    containersandPackaging),
                                inputWidgets(
                                    decrementValues,
                                    incrementValues,
                                    "Plastic Plates",
                                    containersandPackaging["Plastic Plates"],
                                    containersandPackaging),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ));
  }
}

class inputWidgets extends StatelessWidget {
  Function decrementValues;
  Function incrementValues;
  String object;
  int value;
  Map<String, int> inputList;
  inputWidgets(this.decrementValues, this.incrementValues, this.object,
      this.value, this.inputList);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
          child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Text(
              object,
              style: TextStyle(
                fontSize: 0.04 * width,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                InkWell(
                  onTap: () => decrementValues(object, inputList),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF707070).withOpacity(0.07),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "-",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 0.04 * width,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF707070))),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      fontSize: 0.04 * width,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => incrementValues(object, inputList),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF707070).withOpacity(0.07),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "+",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 0.04 * width,
                      ),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: Text(
                //     "kgs",
                //     style: TextStyle(
                //       fontSize: 0.04 * width,
                //     ),
                //   ),
                // ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
