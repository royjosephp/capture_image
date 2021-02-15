import 'package:flutter/material.dart';
import 'photo.dart';
import 'location.dart';

void main() {
  runApp(ReportApp());
}

class ReportApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker',
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('Report Offence'),
        ),
        body: new Column(
          children: [
            Center(
              child: CapturePhoto(),
            ),
            ConvertGeocodesToAddress(),
          ],
        ),
      ),
    );
  }
}
