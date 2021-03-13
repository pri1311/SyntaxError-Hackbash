import 'package:flutter/material.dart';

class BottomDrawerScreen extends StatefulWidget {
  @override
  _BottomDrawerScreenState createState() => _BottomDrawerScreenState();
}

class _BottomDrawerScreenState extends State<BottomDrawerScreen> {
  //TODO get values from backend
  double treesValue = 9;
  double co2 = 5;
  double stepValue = 1000;
  double deedsValue = 3;

  int deeds = 15;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
          decoration: BoxDecoration(
              color: Color(0xff3D3D3D),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0))),
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return Padding(
              padding: EdgeInsets.only(
                  left: constraints.maxWidth * 0.108,
                  right: 0.108 * constraints.maxWidth,
                  bottom: 0.0223 * constraints.maxHeight,
                  top: 0.15 * constraints.maxHeight),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Image(
                        image: AssetImage('images/growth.png'),
                        height: 0.456 * constraints.maxHeight,
                        width: 0.676 * constraints.maxWidth),
                    SizedBox(height: constraints.maxHeight * 0.067),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Stats(
                          statValue: treesValue,
                          stat: "Trees",
                          constraints: constraints,
                        ),
                        Container(
                          color: Colors.white,
                          width: 0.004 * constraints.maxWidth,
                          height: 0.0737 * constraints.maxHeight,
                        ),
                        Stats(
                          statValue: stepValue,
                          stat: "Steps",
                          constraints: constraints,
                        ),
                        Container(
                          color: Colors.white,
                          width: 0.004 * constraints.maxWidth,
                          height: 0.0737 * constraints.maxHeight,
                        ),
                        Stats(
                          statValue: co2,
                          stat: "Tonns CO2",
                          constraints: constraints,
                        ),
                        Container(
                          color: Colors.white,
                          width: 0.004 * constraints.maxWidth,
                          height: 0.0737 * constraints.maxHeight,
                        ),
                        Stats(
                          statValue: deedsValue,
                          stat: "Good deed",
                          constraints: constraints,
                        ),
                      ],
                    ),
                    SizedBox(height: constraints.maxHeight * 0.067),
                    Padding(
                      padding: EdgeInsets.only(
                          top: 0.025 * constraints.maxHeight,
                          bottom: 0.025 * constraints.maxHeight),
                      child: Text(
                        "Your Badges",
                        style: TextStyle(
                            fontSize: 0.057 * constraints.maxWidth,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.01 * constraints.maxWidth),
                      ),
                    ),
                    Wrap(
                      children: drawBadges(deeds, constraints),
                    ),
                  ],
                ),
              ),
            );
          })),
    );
  }
}

class Stats extends StatelessWidget {
  // var constrains;

  const Stats({
    Key key,
    @required this.statValue,
    @required this.stat,
    @required this.constraints,
  }) : super(key: key);

  final double statValue;
  final String stat;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        0.025 * constraints.maxWidth,
        0.0245 * constraints.maxHeight,
        0.025 * constraints.maxWidth,
        0.0245 * constraints.maxHeight,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 0.015 * constraints.maxWidth,
                right: 0.015 * constraints.maxWidth),
            child: Text(
              statValue.toString(),
              style: TextStyle(
                  fontSize: 0.048 * constraints.maxWidth,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Text(stat,
              style: TextStyle(
                  fontSize: 0.027 * constraints.maxWidth, color: Colors.white))
        ],
      ),
    );
  }
}

List<Widget> drawBadges(int deedCount, BoxConstraints constraints) {
  List<Widget> badgeIcons = [];
  for (int i = 0; i < deedCount; i++)
    badgeIcons.add(Padding(
        padding: EdgeInsets.all(10),
        child: Image(
            image: AssetImage('images/icon/badge.png'),
            width: 0.0869 * constraints.maxWidth,
            height: 0.081 * constraints.maxHeight)));
  return badgeIcons;
}
