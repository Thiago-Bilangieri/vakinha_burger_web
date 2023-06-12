import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

mixin HistoryBackListener<T extends StatefulWidget> on State<T> {
  final _location = const BrowserPlatformLocation();
  @override
  void initState() {
    super.initState();
    _location.addPopStateListener((event) async {
      await Future.delayed(
        const Duration(microseconds: 200),
        () {
          if (mounted) {
            onHistoryBack(event);
          }
        },
      );
    });
  }

  void onHistoryBack(Event event) {}

  @override
  void dispose() {
    _location.removePopStateListener((event) => null);
    super.dispose();
  }
}
