import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'timer_counter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TimeController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: const MyHomePage(title: 'Ahmad Tayyab'),
    );
  }
}

class MyHomePage extends GetView<TimeController> {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final timeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.cyan, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Obx(
                  () => TextField(
                    controller: timeController,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: controller.inputFocused.value || timeController.text.isNotEmpty
                          ? null
                          : 'Enter countdown time in seconds',
                      labelStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (text) {
                      controller.inputFocused.value = text.isNotEmpty;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        int countdownTime = int.tryParse(timeController.text) ?? 0;
                        controller.startTimer(countdownTime, context);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50), // Increase button size
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Start Timer'),
                    ),
                    const SizedBox(height: 10),
                    Obx(
                      () => ElevatedButton(
                        onPressed: () {
                          if (controller.isPaused.value) {
                            controller.resumeTimer(context);
                          } else {
                            controller.pauseTimer();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50), // Increase button size
                          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        child: Text(controller.isPaused.value ? 'Resume Timer' : 'Pause Timer'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        controller.resetTimer();
                        timeController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(200, 50), // Increase button size
                        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      child: const Text('Reset Timer'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.grey.shade300],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Obx(
                    () => Center(
                      child: Text(
                        controller.time.value,
                        style: const TextStyle(
                          fontSize: 48,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Courier', // Custom font
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
