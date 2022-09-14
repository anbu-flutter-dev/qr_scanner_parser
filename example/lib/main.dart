import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_qr_scan_example/scanViewDemo.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_scanner_parser/flutter_qr_scan.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: NewPage());
  }
}

class NewPage extends StatelessWidget {
  NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => HomePage()));
          },
          child: Text("Go"),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  QrReaderViewController _controller = QrReaderViewController(1);
  bool isOk = false;
  String? data;
  String? rawData;
  @override
  void initState() {
    _controller.startCamera((p0, p1, p2) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
        actions: [
          IconButton(
            onPressed: () {
              _controller.setFlashlight();
            },
            icon: Icon(
              Icons.flash_auto,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final status = await Permission.camera.request();
                print(status);
                if (status.isGranted) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Text("ok"),
                      );
                    },
                  );
                  setState(() {
                    isOk = true;
                  });
                }
              },
              child: Text("Permission"),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ScanViewDemo()));
              },
              child: Text("Scanview"),
            ),
            ElevatedButton(
              onPressed: () async {
                var image =
                    await ImagePicker().getImage(source: ImageSource.gallery);
                if (image == null) return;
                final rest = await FlutterQrReader.imgScan(File(image.path));
                setState(() {
                  data = rest;
                });
              },
              child: Text("Pick Image"),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.setFlashlight();
              },
              child: Text("Flash"),
            ),
            ElevatedButton(
              onPressed: () {
                _controller.startCamera(onScan);
              },
              child: Text("Start Camera"),
            ),
            if (data != null) Text('$data\nrawData: $rawData'),
            Container(
              width: 320,
              height: 350,
              child: QrReaderView(
                width: 320,
                height: 350,
                
                callback: (container) {
                  this._controller = container;
                  _controller.startCamera(onScan);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void onScan(String? v, List<Offset>? offsets, String? raw) {
    print([v, offsets, raw]);
    setState(() {
      data = v;
      rawData = raw;
    });
    _controller.stopCamera();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
