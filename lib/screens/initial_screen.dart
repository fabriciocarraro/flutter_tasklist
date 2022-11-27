import 'package:flutter/material.dart';
import 'package:flutter_tasklist/components/task.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  bool opacity = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text('Tasks'),
      ),
      body: AnimatedOpacity(
        opacity: opacity ? 1 : 0,
        duration: const Duration(milliseconds: 600),
        child: ListView(
          children: const [
            Task(
                'Study Flutter this is a very very long lorem ipsum to test how it adapts to size and overflow',
                'assets/images/flutter_dash.png',
                3),
            Task(
                'Ride my bike',
                'assets/images/bike.jpg',
                1),
            Task(
                'Meditate',
                'assets/images/meditate.jpeg',
                5),
            Task(
                'Read',
                'assets/images/read.jpg',
                4),
            Task('Play video-games',
                'assets/images/playing.jpg',
                1),
            Task('Gym',
                'assets/images/gym.png',
                3),
            Task('Dance salsa',
                'assets/images/salsa.jpg',
                4),
            SizedBox(height: 50,)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState((){
            opacity = !opacity;
          });
        },
        child: const Icon(Icons.remove_red_eye),
      ),
    );
  }
}