import 'package:flutter/material.dart';

class Event {
  final String title, description;
  final DateTime from, to;
  final Color backgroundColor;
  final bool isAllDay;

  const Event(this.title, this.description, this.from, this.to,
      {this.backgroundColor = Colors.lightGreen, this.isAllDay = false});
}
