import 'package:earthling/constants.dart';
import 'package:earthling/screens/PMI_suggestions.dart';
import 'package:earthling/screens/suggestions_screen.dart';
import 'package:flutter/material.dart';

class suggestionsList extends StatefulWidget {
  @override
  _suggestionsListState createState() => _suggestionsListState();
}

class _suggestionsListState extends State<suggestionsList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(color: Colors.white),
          child: ListView(
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
                        "Pass on Plastic!",
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        // color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.0),
                          child: Image(
                            image: AssetImage('images/giphy.gif'),
                            height: 300,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: FlatButton(
                                  shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          // color: Color(0xFFA5C528),
                                          color: Colors.white,
                                          width: 1,
                                          style: BorderStyle.solid),
                                      borderRadius: BorderRadius.circular(50)),
                                  // color: Color(0xFFA5C528),
                                  color: Colors.white,
                                  onPressed: () => {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PMI_suggest(),
                                            ))
                                      },
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    "Do something today..",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.0),
                    topLeft: Radius.circular(20.0),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 45),
                        child: Container(
                          child: Text(
                            "Recycling Centres",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'roboto',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        height: 250,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            recyclingWidgets(
                              "Sahakari Bhandhar",
                              "Mumbai",
                              "www.google.com",
                              "4.5/5",
                            ),
                            recyclingWidgets(
                              "Sahakari Bhandhar",
                              "Mumbai",
                              "www.google.com",
                              "4.5/5",
                            ),
                            recyclingWidgets(
                              "Sahakari Bhandhar",
                              "Mumbai",
                              "www.google.com",
                              "4.5/5",
                            ),
                            recyclingWidgets(
                              "Sahakari Bhandhar",
                              "Mumbai",
                              "www.google.com",
                              "4.5/5",
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class recyclingWidgets extends StatelessWidget {
  String name = "XXXXXX";
  String address = "XXXX Mumbai";
  String directions = "XXXXXXXXXXXXXXXXX";
  String rating = "3.5/4";
  recyclingWidgets(this.name, this.address, this.directions, this.rating);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(15),
      width: 275,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Color(0xFFA5C528),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    rating,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    address,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () => {},
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    // Replace with a Row for horizontal icon + text
                    children: <Widget>[
                      Text("Directions"),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox(),
          ),
        ],
      ),
    );
  }
}
