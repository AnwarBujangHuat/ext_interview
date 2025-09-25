import 'dart:async';

import 'package:flutter/material.dart';

class TimeService {
  static Timer? _timer;
  static final StreamController<DateTime> _timeController = 
      StreamController<DateTime>.broadcast();

  static Stream<DateTime> get timeStream => _timeController.stream;

  static void startTimeService() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeController.add(DateTime.now());
    });
  }

  static void stopTimeService() {
    _timer?.cancel();
  }

  static String formatTime(DateTime time) {
    final period = time.hour >= 12 ? 'PM' : 'AM';
    final hour = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final second = time.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second $period';
  }


}
class LiveTimeWidget extends StatefulWidget {
  const LiveTimeWidget({super.key});

  @override
  State<LiveTimeWidget> createState() => _LiveTimeWidgetState();
}

class _LiveTimeWidgetState extends State<LiveTimeWidget> {
  late StreamSubscription<DateTime> _timeSubscription;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    TimeService.startTimeService();
    _timeSubscription = TimeService.timeStream.listen((time) {
      if (mounted) {
        setState(() => _currentTime = time);
      }
    });
  }

  @override
  void dispose() {
    _timeSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.access_time, color: Colors.white, size: 16),
        const SizedBox(width: 8),
        Text(
          TimeService.formatTime(_currentTime),
          style: const TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    );
  }
}


class PointsSection extends StatelessWidget {
  const PointsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return      Container(
                        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.white, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  '14 Oct 2024',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                            LiveTimeWidget(),
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.white, size: 16),
                                SizedBox(width: 8),
                                Text(
                                  'Plant St, 7th',
                                  style: TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
  }
}