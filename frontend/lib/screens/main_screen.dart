import 'package:earthling/screens/PMI_calculator.dart';
import 'package:earthling/screens/carbon_footprint.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:earthling/constants.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String input = "";
  List<String> news = ["", "", ""];
  @override
  void initState() {
    // TODO: implement initState
    news[0] =
        'India\'s Dietary Guidelines Have The Lowest Carbon Footprint In The World';
    news[1] =
        'Supreme Court asks Centre why environment regulator has not been set up';
    news[2] =
        'India\'s Dietary Guidelines Have The Lowest Carbon Footprint In The World';
    //TODO initialise 3 news statements (only title)

    super.initState();
  }

  int deedNo = 0;
  String newsBody =
      "The Union Environment Ministry and the Delhi government jointly launched 'Clean Air Campaign' which saw 4,347 violations in a week, officials said on Monday. The officials added that 1,892 violators were fined, leading to a collection of ₹54 crore. The campaign was launched on February 10 to find a permanent solution to pollution in Delhi-NCR.";

  Future<void> _showDeedDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraint) {
          return AlertDialog(
            contentPadding: EdgeInsets.only(left: 40, right: 40, bottom: 20),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Padding(
              padding: EdgeInsets.all(20),
              child: Image(
                image: AssetImage('images/deeds/$deedNo.png'),
                height: 150,
              ),
            ),
            content: SingleChildScrollView(
              child: Center(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                        child: Text(
                      deeds[deedNo][0],
                      style: TextStyle(
                          color: Color(0xff3D3D3D),
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.1),
                      textAlign: TextAlign.center,
                    )),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Text(
                        deeds[deedNo][1],
                        style: TextStyle(
                            color: Color(0xff737373),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 1.1),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    MaterialButton(
                      height: 40,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Color(0xff3D3D3D),
                      child: Text(
                        'Mark As Done',
                        style: TextStyle(
                            fontSize: constraint.maxHeight * 0.0251,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        deedNo = (deedNo + 1) % deeds.length;
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return Column(
//                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: constraints.maxWidth,
                    height: 0.32 * constraints.maxHeight,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('images/home-page.jpg'),
                          fit: BoxFit.fill),
                    ),
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: IconButton(
                        icon: Icon(Icons.format_list_bulleted),
                        onPressed: () {
                        //  TODO navigate to user profile drawer
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.0223,
                  ),
                  Text(
                    'Earthling',
                    style: TextStyle(
                      fontFamily: 'Calibri',
                      fontSize: constraints.maxHeight * 0.0379,
                      color: const Color(0xff3d3d3d),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.002,
                  ),
                  Text(
                    'The Earth is what we all have in common',
                    style: TextStyle(
                      fontFamily: 'Noto Sans',
                      fontSize: constraints.maxHeight * 0.0145,
                      color: const Color(0xff3d3d3d),
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.0223,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(constraints.maxWidth * 0.089,
                        0, constraints.maxWidth * 0.089, 0),
                    child: Column(
                      children: [
                        Container(
                          height: constraints.maxHeight * 0.064,
                          child: TextField(
                            style: TextStyle(
                              fontSize: constraints.maxHeight * 0.017,
                            ),
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF3D3D3D), width: 2.5)),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                    borderSide: BorderSide(
                                        color: Color(0xFF3D3D3D), width: 2.5)),
                                contentPadding: EdgeInsets.fromLTRB(
                                    constraints.maxHeight * 0.014,
                                    constraints.maxWidth * 0.014,
                                    0,
                                    constraints.maxWidth * 0.014),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.search,
                                    size: constraints.maxHeight * 0.025,
                                    color: Color(0xFF3D3D3D),
                                  ),
                                  onPressed: () {
                                  //TODO navigate to analysis screen
                                  },
                                ),
                                labelText: 'Input for Eco-check',
                                labelStyle: TextStyle(
                                  fontSize: constraints.maxHeight * 0.017,
                                ),
                                hintText: 'Enter material name',
                                fillColor: Colors.black),
                            onChanged: (value) {
                              // TODO assign analysis screen -> material = value
                            },
                            onSubmitted: (value) {
                            //  TODO navigate to analysis screen
                            },
                          ),
                        ),
                        SizedBox(
                          height: 0.0223 * constraints.maxHeight,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Container(
                                  width: 0.082 * constraints.maxHeight,
                                  height: 0.082 * constraints.maxHeight,
                                  child: RawMaterialButton(
                                    fillColor: Color(0xFF3D3D3D),
                                    shape: CircleBorder(),
                                    elevation: 3,
                                    child: Image(
//                                  width: constraints.maxWidth,
                                        height: 0.028 * constraints.maxHeight,
                                        image:
                                            AssetImage('images/icon/co2.png')),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  carbonFootprint()));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.01,
                                ),
                                Text(
                                  'CO₂ check',
                                  style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: constraints.maxHeight * 0.01339,
                                    color: const Color(0xff3d3d3d),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 0.082 * constraints.maxHeight,
                                  height: 0.082 * constraints.maxHeight,
                                  child: RawMaterialButton(
                                    fillColor: Color(0xFF3D3D3D),
                                    shape: CircleBorder(),
                                    elevation: 3,
                                    child: Image(
//                                  width: constraints.maxWidth,
                                        height: 0.028 * constraints.maxHeight,
                                        image:
                                            AssetImage('images/icon/pmi.png')),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PMI_calculator()));
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.01,
                                ),
                                Text(
                                  'PMI check',
                                  style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: constraints.maxHeight * 0.01339,
                                    color: const Color(0xff3d3d3d),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 0.082 * constraints.maxHeight,
                                  height: 0.082 * constraints.maxHeight,
                                  child: RawMaterialButton(
                                    fillColor: Color(0xFF3D3D3D),
                                    shape: CircleBorder(),
                                    elevation: 3,
                                    child: Image(
//                                  width: constraints.maxWidth,
                                        height: 0.028 * constraints.maxHeight,
                                        image: AssetImage(
                                            'images/icon/steps.png')),
                                    onPressed: () {
                                      //  TODO navigate to step screen
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.01,
                                ),
                                Text(
                                  'Foot steps',
                                  style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: constraints.maxHeight * 0.01339,
                                    color: const Color(0xff3d3d3d),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  width: 0.082 * constraints.maxHeight,
                                  height: 0.082 * constraints.maxHeight,
                                  child: RawMaterialButton(
                                    fillColor: Color(0xFF3D3D3D),
                                    shape: CircleBorder(),
                                    elevation: 3,
                                    child: Image(
//                                  width: constraints.maxWidth,
                                        height: 0.028 * constraints.maxHeight,
                                        image:
                                            AssetImage('images/icon/cam.png')),
                                    onPressed: () {
                                      //TODO eco check
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: constraints.maxHeight * 0.01,
                                ),
                                Text(
                                  'Eco-check',
                                  style: TextStyle(
                                    fontFamily: 'Noto Sans',
                                    fontSize: constraints.maxHeight * 0.01339,
                                    color: const Color(0xff3d3d3d),
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 0.0323 * constraints.maxHeight,
                        ),
                        Container(
                          width: constraints.maxWidth,
                          child: Text(
                            'Recommended',
                            style: TextStyle(
                              fontFamily: 'Calibri',
                              fontSize: constraints.maxHeight * 0.02455,
                              color: const Color(0xde000000),
                              letterSpacing: 0.209,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          height: 0.0223 * constraints.maxHeight,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        constraints.maxWidth * 0.089, 0, 0, 0),
                    child: Container(
                      height: constraints.maxHeight * 0.245,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          MaterialButton(
                            onPressed: () {
                              //TODO news
                            },
                            elevation: 3,
                            padding: EdgeInsets.all(0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFF2F3B01),
                                  borderRadius: BorderRadius.circular(5)),

                              width: constraints.maxWidth * 0.54,
                              padding: EdgeInsets.all(
                                  constraints.maxHeight * 0.01785),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage('images/icon/news.png'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, constraints.maxHeight * 0.044, 0, 0),
                                    child: Text(
                                      news[0],
                                      softWrap: true,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                        letterSpacing: 0.1425,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.04,
                          ),
                          MaterialButton(
                            onPressed: () {
                              //TODO news
                            },
                            padding: EdgeInsets.all(0),
                            elevation: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFFC9313),
                                  borderRadius: BorderRadius.circular(5)),

                              width: constraints.maxWidth * 0.54,
                              padding: EdgeInsets.all(
                                  constraints.maxHeight * 0.01785),
//                                  color: Color(0xFF2F3B01),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage('images/icon/news.png'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, constraints.maxHeight * 0.044, 0, 0),
                                    child: Text(
                                      news[1],
                                      softWrap: true,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                        letterSpacing: 0.1425,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.04,
                          ),
                          MaterialButton(
                            onPressed: () {
                              //TODO news
                            },
                            padding: EdgeInsets.all(0),
                            elevation: 3,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xFFD14F2B),
                                  borderRadius: BorderRadius.circular(5)),

                              width: constraints.maxWidth * 0.54,
                              padding: EdgeInsets.all(
                                  constraints.maxHeight * 0.01785),
//                                  color: Color(0xFF2F3B01),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image(
                                    image: AssetImage('images/icon/news.png'),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        0, constraints.maxHeight * 0.044, 0, 0),
                                    child: Text(
                                      news[2],
                                      softWrap: true,
                                      style: TextStyle(
                                        fontFamily: 'Roboto',
                                        fontSize: 15,
                                        color: const Color(0xffffffff),
                                        letterSpacing: 0.1425,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.04,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
