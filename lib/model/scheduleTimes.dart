// ignore: file_names
import 'package:flutter/material.dart';

List<String> scheduleTimes = ['01:40 PM', '02:30 PM', '05:40 AM'];

List<bool> selectedDays = List.generate(7, (index) => false);

List<String> daysOfWeek = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];

TimeOfDay setTime = const TimeOfDay(hour: 09, minute: 00);
