import 'package:flutter/material.dart';
import 'package:wordpress_companion/core/presentation/widgets/main_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppBar(),
      body: _bodyLayout(),
    );
  }

  Widget _bodyLayout() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: _bodySections(),
        ),
      ),
    );
  }

  Widget _bodySections() {
    return const Column(
      children: [],
    );
  }
}
