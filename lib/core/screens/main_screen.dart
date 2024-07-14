import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: _bodyLayout(),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.black,
      surfaceTintColor: Colors.white,
      elevation: 5,
      shape: _appBarShape(),
      leading: _menuButton(context),
      actions: [
        _profileAvatar(),
        const Gap(10),
      ],
    );
  }

  RoundedRectangleBorder _appBarShape() {
    return const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
    );
  }

  IconButton _menuButton(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: const Icon(Icons.menu),
    );
  }

  Widget _profileAvatar() {
    return InkWell(
      onTap: () {},
      child: const CircleAvatar(
        child: Icon(Icons.person),
      ),
    );
  }

  Widget _bodyLayout() {
    return const Directionality(
      textDirection: TextDirection.rtl,
      child: Center(
        child: Text("MainScreen"),
      ),
    );
  }
}
