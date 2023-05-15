// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  Timer? _timer;
  Debouncer({
    required this.milliseconds,
  });

  void call(VoidCallback callback){
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), callback);

  }
  
  
}
