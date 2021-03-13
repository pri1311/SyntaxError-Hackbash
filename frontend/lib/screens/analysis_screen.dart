import 'package:earthling/constants.dart';
import 'package:flutter/material.dart';

class AnalysisScreen extends StatefulWidget {
  static String material;
  static int check(String materialName) {
    if (materialName == "Cardboard" || materialName == "cardboard")
      return 0;
    else if (materialName == "Glass" || materialName == "glass")
      return 1;
    else if (materialName == "Metal" || materialName == "metal")
      return 2;
    else if (materialName == "Paper" || materialName == "paper")
      return 3;
    else if (materialName == "Plastic" || materialName == "plastic")
      return 4;
    else if (materialName == "Trash" || materialName == "trash")
      return 5;
    else
      return null;
  }

  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  int materialIndex;

  @override
  void initState() {
    materialIndex = AnalysisScreen.check(AnalysisScreen.material);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: IconButton(
                        iconSize: 25,
                        icon: Icon(Icons.arrow_back),
                        color: Color(0xff3D3D3D),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ),
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        "Analysis",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff3D3D3D),
                            fontSize: 25),
                      ),
                    ),
                  ),
                  Expanded(flex: 1, child: SizedBox())
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Image(
                image: AssetImage('images/analysis.png'),
                height: 190,
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 45, 40, 30),
                  decoration: BoxDecoration(
                    color: Color(0xff3D3D3D),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: ListView(
                    children: [
                      Text(
                        materials[materialIndex][0],
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        materials[materialIndex][1],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
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
