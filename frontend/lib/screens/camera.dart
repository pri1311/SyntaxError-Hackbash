
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:async/async.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'analysis_screen.dart';


class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController cameraController;
  List cameras;
  int selectedCameraIndex;
  String imgPath,display="loading";
  File image;
  int stop=0;
  var response;


  void onCapture() async{
    try {
      final p = await getTemporaryDirectory();
      final name =DateTime.now();
      final path = "${p.path}/$name.jpg";
      await cameraController.takePicture(path);
      setState(() {
        image = File(path);
      });
      print(path);
      sendReq(image);

      Timer(Duration(seconds: 30), () {
        onCapture();
      });



    } catch (e) {
      showCameraException(e);
    }
  }

  void sendReq(File image) async{
    var stream =
    new http.ByteStream(DelegatingStream.typed(image.openRead()));

    var length = await image.length();

    var uri = Uri.parse("http://192.168.140.1:5000/predict");

    var request = http.MultipartRequest("POST", uri);

    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(image.path));

    request.files.add(multipartFile);

    var res = await request.send();

    response = await http.Response.fromStream(res);
    final decoded =
    json.decode(response.body) as Map<String, dynamic>;
    setState(() {
      display = decoded["class"];
    });





  }

  Future initCamera(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController.dispose();
    }

    cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);

    cameraController.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });

    if (cameraController.value.hasError) {
      print('Camera Error ${cameraController.value.errorDescription}');
    }

    try {
      await cameraController.initialize();
    } catch (e) {
      showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  /// Display camera preview

  Widget cameraPreview(context) {
    if (cameraController == null || !cameraController.value.isInitialized) {
      return Text(
        'Loading',
        style: TextStyle(
            color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
      );
    }

    final size = MediaQuery.of(context).size;
    final deviceRatio = size.width / size.height;
    final xScale = cameraController.value.aspectRatio / deviceRatio;
// Modify the yScale if you are in Landscape
    final yScale = 1.0;
    return Container(
      child: AspectRatio(
        aspectRatio: deviceRatio,
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.diagonal3Values(xScale, yScale, 1),
          child: CameraPreview(cameraController),
        ),
      ),
    );
  }

  Widget cameraControl(context) {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            SizedBox(
              width: 100,
              height: 75,
              child: FloatingActionButton(
                child: Icon(
                  Icons.forward,
                  color: Color(0xFFAECE2A),
                  size: 35,
                ),
                backgroundColor: Color(0xFF3D3D3D),
                onPressed: () {
                  AnalysisScreen.material = display;
                  if (AnalysisScreen.check(display) != null)
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AnalysisScreen()));

                },
              ),
            )

          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();

    availableCameras().then((value) {
      cameras = value;
      if(cameras.length > 0){
        setState(() {
          selectedCameraIndex = 0;
        });
        initCamera(cameras[selectedCameraIndex]).then((value) {
          onCapture();
        });
      } else {
        print('No camera available');
      }
    }).catchError((e){
      print('Error : ${e.code}');
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: cameraPreview(context),
            ),
            Align(
              alignment: Alignment.center,
                child: Opacity(
                opacity: 0.5,
                child: Container(
                  width: double.infinity,
                  color: Colors.grey,
                  child: Text(display,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),),
                ),
              )
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: 120,
                width: double.infinity,
                padding: EdgeInsets.all(15),
                color: Colors.transparent,
                child: Row(

                  children: <Widget>[

                    cameraControl(context),

                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  showCameraException(e) {
    String errorText = 'Error ${e.code} \nError message: ${e.description}';
  }
}
