import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_scanner_parser/flutter_qr_scan.dart';
import 'package:qr_scanner_parser/qrcode_reader_view.dart';

class ScanViewDemo extends StatefulWidget {
  ScanViewDemo({Key? key}) : super(key: key);

  @override
  _ScanViewDemoState createState() => new _ScanViewDemoState();
}

class _ScanViewDemoState extends State<ScanViewDemo> {
  GlobalKey<QrcodeReaderViewState> _key = GlobalKey();
  QrReaderViewController? _controller;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QrcodeReaderView(
        key: _key,
        onScan: onScan,
        headerWidget: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(
              onPressed: () async {
                await _controller?.setFlashlight();
              },
              icon: Icon(
                Icons.flash_auto,
              ),
            )
          ],
        ),
      ),
    );
  }

  Future onScan(String? data, String? rawData) async {
    await showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("QR DATA"),
          content: Text('$data\n$rawData'),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text("Close"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        );
      },
    );
    _key.currentState?.startScan();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
