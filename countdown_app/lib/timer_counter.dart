import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeController extends GetxController {
  Timer? _timer;
  int remainingSeconds = 1;
  final time = '00:00'.obs;
  final isPaused = false.obs;
  final inputFocused = false.obs;

  void startTimer(int seconds, BuildContext context) {
    const duration = Duration(seconds: 1);
    remainingSeconds = seconds;
    _timer?.cancel();
    _timer = Timer.periodic(duration, (Timer timer) {
      if (remainingSeconds == 0) {
        timer.cancel();
        _showAlertDialog(context);
      } else {
        int minutes = remainingSeconds ~/ 60;
        int seconds = remainingSeconds % 60;
        time.value = '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
        remainingSeconds--;
      }
    });
    isPaused.value = false;
  }

  void pauseTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      isPaused.value = true;
    }
  }

  void resumeTimer(BuildContext context) {
    startTimer(remainingSeconds, context);
  }

  void resetTimer() {
    _timer?.cancel();
    time.value = '00:00';
    remainingSeconds = 0;
    isPaused.value = false;
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Time\'s Up!'),
          content: const Text('The countdown timer has completed.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
