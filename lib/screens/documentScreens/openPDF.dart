import 'dart:io';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pdftron_flutter/pdftron_flutter.dart';

import 'package:flutter/material.dart';
import 'package:rane_dms/components/constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OpenPDF extends StatefulWidget {
  final String url;
  OpenPDF(this.url);
  @override
  _OpenPDFState createState() => _OpenPDFState();
}

class _OpenPDFState extends State<OpenPDF> {
  String _version = 'Unknown';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();

    PdftronFlutter.openDocument("${widget.url}");
  }

  Future<void> initPlatformState() async {
    String version;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      PdftronFlutter.initialize(
          "Insert commercial license key here after purchase");
      version = await PdftronFlutter.version;
    } on PlatformException {
      version = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _version = version;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Rane DMS'),
        ),
        body: Center(
          child: Text('version $version'),
        ),
      ),
    );
  }
}
