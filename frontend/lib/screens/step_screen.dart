import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pedometer/pedometer.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';
import 'package:jiffy/jiffy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepScreen extends StatefulWidget {
  @override
  _StepScreenState createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
  SharedPreferences prefs;
  int _steps = 0;
  Stream<StepCount> _stepCountStream;
  Stream<PedestrianStatus> _pedestrianStatusStream;

  Future<void> onStepCount(StepCount event) async {
    _steps = event.steps;
    print(_steps);
    int previousSteps = prefs.getInt('step_value') ?? 0;
    int todayDayNo = Jiffy(DateTime.now()).dayOfYear;
    if (_steps < previousSteps) {
      previousSteps = 0;
      prefs.setInt('step_value', previousSteps);
    }
    int previousDaySaved = prefs.getInt('previous_day') ?? 0;
    if (previousDaySaved < todayDayNo) {
      previousDaySaved = todayDayNo;
      previousSteps = _steps;
      prefs.setInt('step_value', previousSteps);
      prefs.setInt('previous_day', previousDaySaved);
    }
    setState(() {
      _steps = _steps - previousSteps;
    });
  }

  void onStepCountError(error) {
    print("Flutter Pedometer Error: $error");
  }

  Future<void> initPlatformState() async {
    _stepCountStream = await Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
  }

  void permission() async {
    if (await Permission.activityRecognition.request().isGranted)
      initPlatformState();
  }

  @override
  void initState() {
    super.initState();
    permission();
  }

  String km(int n) {
    return ((n * 0.0008).toStringAsFixed(2));
  }

  String calories(int n) {
    return ((n * 0.04).toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0xff3D3D3D),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 190,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('images/earth-tree.gif'),
                  ),
                ),
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Color(0xffFFFFFF),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Center(
                child: Text(
                  "Walk For our Earth!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 22,
                      letterSpacing: 1.1),
                ),
              ),
              Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 30),
                  child: Text(
                    "Here is our initiative for you: for every 10,000 steps, we plant a tree for you! You could also choose to gift a tree to do the same.",
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 16, color: Colors.white, letterSpacing: 1.1),
                    textAlign: TextAlign.center,
                  )),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 45, 40, 30),
                  decoration: BoxDecoration(
                    color: Color(0xffFFFFFF),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                  ),
                  child: ListView(
                    children: [
                      Container(
                        height: 200,
                        width: double.infinity,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 20, 0),
                                child: Column(
                                  children: [
                                    Image(
                                      height: 100,
                                      image:
                                          AssetImage('images/icon/steps.png'),
                                    ),
                                    Text(
                                      _steps.toString(),
                                      style: TextStyle(
                                          color: Color(0xff3D3D3D),
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Steps",
                                      style: TextStyle(
                                          color: Color(0xff3D3D3D),
                                          fontSize: 15,
                                          letterSpacing: 1.1),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              color: Color(0xff3D3D3D),
                              height: 150,
                              width: 3,
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 10, 0),
                                          child: Image(
                                            image: AssetImage(
                                                'images/icon/ruler.png'),
                                          ),
                                        ),
                                        Text(
                                          km(_steps),
                                          style: TextStyle(
                                              color: Color(0xff3D3D3D),
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          " Kms",
                                          style: TextStyle(
                                              color: Color(0xff3D3D3D),
                                              fontSize: 15,
                                              letterSpacing: 1.1),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    color: Color(0xff3D3D3D),
                                    height: 3,
                                    width: 170,
                                    margin: EdgeInsets.all(25),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 0, 10, 0),
                                          child: Image(
                                            image: AssetImage(
                                                'images/icon/calories.png'),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              calories(_steps),
                                              style: TextStyle(
                                                  color: Color(0xff3D3D3D),
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(
                                              " Kcal",
                                              style: TextStyle(
                                                  color: Color(0xff3D3D3D),
                                                  fontSize: 15,
                                                  letterSpacing: 1.1),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                          child: Text(
                            "Gift a tree!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xff3D3D3D),
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                letterSpacing: 1.1),
                          ),
                          color: Color(0xffA5C32B),
                          onPressed: () async {
                            const url =
                                'https://www.amazon.in/Leafy-Tales-Crassula-Plastic-Leaves/dp/B083R7WJWC/ref=sr_1_1?adgrpid=61933634055&dchild=1&ext_vrnc=hi&gclid=Cj0KCQiAv6yCBhCLARIsABqJTjYYbbRkAm8B29vUCcHVyebAU6TjtsK5gLRatrBBP8gcUjx3mqIrwO0aAgDAEALw_wcB&hvadid=398060186581&hvdev=c&hvlocphy=9062117&hvnetw=g&hvqmt=b&hvrand=5837074334408708057&hvtargid=kwd-306369606414&hydadcr=24568_1971427&keywords=air+plant+price&qid=1615583651&sr=8-1';
                            if (await canLaunch(url)) {
                              await launch(url);
                            } else {
                              print("failed");
                            }
                          })
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
