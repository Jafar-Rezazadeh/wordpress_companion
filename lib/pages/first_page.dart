import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FirstPage extends StatelessWidget {
  final Duration duration;
  const FirstPage({super.key, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            const Text('First page'),
            ElevatedButton(
              onPressed: () {
                context.goNamed("second-page");
              },
              child: Text('go to second page days ${duration.inDays}'),
            )
          ],
        ),
      ),
    );
  }
}
