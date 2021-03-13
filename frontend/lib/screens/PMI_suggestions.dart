import 'package:earthling/constants.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class PMI_suggest extends StatefulWidget {
  @override
  _PMI_suggestState createState() => _PMI_suggestState();
}

class _PMI_suggestState extends State<PMI_suggest> {
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
                    flex: 4,
                    child: Center(
                      child: Text(
                        "Reduce Your PMI",
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
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: pmisuggestions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  pmisuggestions[index][0],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  pmisuggestions[index][1],
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          );
                        })),
              )
            ],
          ),
        ),
      ),
    );
  }
}
