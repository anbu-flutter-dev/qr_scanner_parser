# flutter_qr_scan

QR code (scan code &#x2F; picture) recognition, forked from
[hetian9288/flutter_qr_reader](https://pub.dev/packages/flutter_qr_reader).

We added Bytes/RawData reading from QR code, so `onScan()` callback function
have 2 params now:
```dart
Future onScan(String data, String rawData) async {
 print(data);
 print(rawData);
}
```

Docs can be found in [hetian9288/flutter_qr_reader](https://pub.dev/packages/flutter_qr_reader).
