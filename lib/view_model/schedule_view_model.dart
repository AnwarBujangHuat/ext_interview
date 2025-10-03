import 'package:flutter/material.dart';

class Schedule {
  final String title;
  final String date;
  final String duration;

  Schedule({
    required this.title,
    required this.date,
    required this.duration,
  });
}

class ScheduleViewModel extends ChangeNotifier {
  List<Schedule> schedules = [
    Schedule(
      title: 'Plant Care Session 1',
      date: '4 Oct 2024 - 2:00 PM',
      duration: '1 hour',
    ),
    // Add more schedules...
  ];
}