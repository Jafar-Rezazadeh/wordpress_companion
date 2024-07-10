import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Page'),
            ElevatedButton(
              onPressed: () {
                context.pushNamed('first-page', extra: const Duration(days: 5));
              },
              child: const Text('go to first page'),
            ),
          ],
        ),
      ),
    );
  }
}
